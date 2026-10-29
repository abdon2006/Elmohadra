import 'package:elmohadra/core/di/injection.dart';
import 'package:elmohadra/core/usecase/base_usecase.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:elmohadra/features/auth/domain/usecases/handle_signing_with_google_usecase.dart';
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

  AuthBloc({
    required this.getCurrentUserUsecase,
    required this.handleSigningWithGoogleUsecase,
    required this.signoutUsecase,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>((event, emit) async {
      emit(AuthLoading());

      final res = await getCurrentUserUsecase(NoParams());
      res.fold((failure) => emit(AuthUnAuthenticated()), (success) {
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
      await getIt<SupabaseClient>().auth.onAuthStateChange
          .where((e) => e.event == AuthChangeEvent.signedIn)
          .first;
      final res = await getCurrentUserUsecase(NoParams());
      res.fold((failure) => emit(AuthUnAuthenticated()), (success) {
        if (success.existingUser != null) {
          emit(AuthAuthenticated(user: success.existingUser!));
        } else {
          emit(
            AuthNewUser(
              user: AuthUserResult(
                newUserId: success.newUserId,
                newUseremail: success.newUseremail,
              ),
            ),
          );
        }
      });
    });

    on<HandleSigningWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await handleSigningWithGoogleUsecase(NoParams());
      res.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (success) => null,
      );
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await signoutUsecase(NoParams());
      res.fold((failure) => emit(AuthError(message: failure.message)), (
        success,
      ) {
        emit(AuthUnAuthenticated());
      });
    });
  }
}
