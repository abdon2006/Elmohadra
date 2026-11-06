import 'dart:async';

import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/errors/failures.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/handle_signing_with_google_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/send_reset_password_link_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/signout_usecase.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/events/auth_events.dart';
import 'package:elmohadra/features/auth/presentation/blocs/Auth%20Bloc/states/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final HandleSigningWithGoogleUsecase handleSigningWithGoogleUsecase;
  final SignoutUsecase signoutUsecase;
  final SendResetPasswordLinkUsecase sendResetPasswordLinkUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  AuthBloc({
    required this.getCurrentUserUsecase,
    required this.handleSigningWithGoogleUsecase,
    required this.signoutUsecase,
    required this.sendResetPasswordLinkUsecase,
    required this.resetPasswordUsecase,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>((event, emit) async {
      emit(AuthLoading());

      final res = await getCurrentUserUsecase(NoParams());
      res.fold((failure) => emit(AuthError(failure: failure)), (success) {
        if (success.existingUser != null) {
          emit(AuthAuthenticated(user: success.existingUser!));
        } else if (success.newUserId != null) {
          emit(AuthNewUser(user: success));
        } else {
          emit(AuthUnAuthenticated());
        }
      });
    });

    on<DeepLinkReceivedEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // A session may already be restored locally, in which case no
        // `signedIn` event will ever arrive.
        final auth = getIt<SupabaseClient>().auth;
        if (auth.currentSession == null) {
          await auth.onAuthStateChange
              .where((e) => e.event == AuthChangeEvent.signedIn)
              .first
              .timeout(const Duration(seconds: 10));
        }
      } on TimeoutException {
        emit(AuthUnAuthenticated());
        return;
      }

      final res = await getCurrentUserUsecase(NoParams());
      res.fold((failure) => emit(AuthError(failure: failure)), (success) {
        if (success.existingUser != null) {
          emit(
            AuthAuthenticated(
              user: success.existingUser!,
              isGoogleSignIn: true,
            ),
          );
        } else {
          emit(
            AuthNewUser(
              user: AuthUserResult(
                newUserId: success.newUserId,
                newUseremail: success.newUseremail,
              ),
              isGoogleSignIn: true,
            ),
          );
        }
      });
    });

    on<HandleSigningWithGoogleEvent>((event, emit) async {
      // The browser takes over from here; the result comes back through the
      // deep link. Emitting AuthLoading would leave the app stuck if the user
      // closes the browser without finishing.
      final res = await handleSigningWithGoogleUsecase(NoParams());
      res.fold(
        (failure) => emit(AuthError(failure: failure)),
        (success) => null,
      );
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await signoutUsecase(NoParams());
      res.fold((failure) => emit(AuthError(failure: failure)), (success) {
        emit(AuthUnAuthenticated());
      });
    });

    on<SendResetPasswordLinkEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await sendResetPasswordLinkUsecase(event.email);
      res.fold(
        (l) => emit(AuthError(failure: l)),
        (r) => emit(ResetPasswordLinkSent()),
      );
    });

    on<PasswordResetLinkReceivedEvent>((event, emit) async {
      emit(ResetPasswordLinkReceived());
    });
    on<UpdatePasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await resetPasswordUsecase(event.password);
      final failure = res.fold<Failure?>((l) => l, (r) => null);
      if (failure != null) {
        emit(AuthError(failure: failure));
        return;
      }

      final userRes = await getCurrentUserUsecase(NoParams());
      userRes.fold((l) => emit(AuthError(failure: l)), (r) {
        final user = r.existingUser;
        if (user == null) {
          emit(AuthUnAuthenticated());
          return;
        }
        emit(PasswordUpdated());
        emit(AuthAuthenticated(user: user));
      });
    });
  }
}
