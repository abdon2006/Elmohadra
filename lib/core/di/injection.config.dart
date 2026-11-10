// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i123;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_email_is_exist_usecase.dart'
    as _i216;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/get_user_by_id_usecase.dart'
    as _i15;
import '../../features/auth/domain/usecases/handle_signing_with_google_usecase.dart'
    as _i367;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/send_reset_password_link_usecase.dart'
    as _i867;
import '../../features/auth/domain/usecases/signin_with_email_usecase.dart'
    as _i240;
import '../../features/auth/domain/usecases/signout_usecase.dart' as _i612;
import '../../features/auth/domain/usecases/signup_with_email_usecase.dart'
    as _i397;
import '../../features/auth/presentation/blocs/Auth%20Bloc/bloc/auth_bloc.dart'
    as _i833;
import '../../features/auth/presentation/blocs/SignIn%20Bloc/bloc/sign_in_bloc.dart'
    as _i519;
import '../../features/auth/presentation/blocs/SignUp%20Bloc/bloc/sign_up_bloc.dart'
    as _i128;
import '../../features/auth/presentation/blocs/signup_cubit/signup_cubit.dart'
    as _i578;
import '../../features/characters/data/datasources/character_datasource.dart'
    as _i736;
import '../../features/characters/data/datasources/character_datasource_impl.dart'
    as _i47;
import '../../features/characters/data/repositories/character_repository_impl.dart'
    as _i51;
import '../../features/characters/domain/repositories/character_repository.dart'
    as _i1057;
import '../../features/characters/domain/usecases/get_characters_usecase.dart'
    as _i951;
import '../../features/characters/presentation/bloc/character_bloc.dart'
    as _i204;
import '../../features/subjects/data/datasources/subject_datasource.dart'
    as _i765;
import '../../features/subjects/data/datasources/subject_datasource_impl.dart'
    as _i646;
import '../../features/subjects/data/repositories/subject_repository_impl.dart'
    as _i74;
import '../../features/subjects/domain/repositories/subject_repository.dart'
    as _i425;
import '../../features/subjects/domain/usecases/get_subjects_usecase.dart'
    as _i464;
import '../../features/subjects/presentation/bloc/subject_bloc.dart' as _i93;
import '../localization/locale_cubit.dart' as _i960;
import '../theme/theme_cubit.dart' as _i611;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i578.SignupCubit>(() => _i578.SignupCubit());
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i765.SubjectDatasource>(
      () => _i646.SubjectDatasourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i736.CharacterDatasource>(
      () => _i47.CharacterDatasourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i1057.CharacterRepository>(
      () => _i51.CharacterRepositoryImpl(
        characterDatasource: gh<_i736.CharacterDatasource>(),
      ),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i123.AuthRemoteDataSourceImpl(
        supabaseClient: gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i960.LocaleCubit>(
      () => _i960.LocaleCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i611.ThemeCubit>(
      () => _i611.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i425.SubjectRepository>(
      () => _i74.SubjectRepositoryImpl(
        subjectDatasource: gh<_i765.SubjectDatasource>(),
      ),
    );
    gh.factory<_i464.GetSubjectsUsecase>(
      () => _i464.GetSubjectsUsecase(
        subjectRepository: gh<_i425.SubjectRepository>(),
      ),
    );
    gh.factory<_i951.GetCharactersUsecase>(
      () => _i951.GetCharactersUsecase(
        characterRepository: gh<_i1057.CharacterRepository>(),
      ),
    );
    gh.lazySingleton<_i204.CharacterBloc>(
      () => _i204.CharacterBloc(
        getCharactersUsecase: gh<_i951.GetCharactersUsecase>(),
      ),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i107.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i93.SubjectBloc>(
      () =>
          _i93.SubjectBloc(getSubjectsUsecase: gh<_i464.GetSubjectsUsecase>()),
    );
    gh.factory<_i216.CheckEmailIsExistUsecase>(
      () => _i216.CheckEmailIsExistUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i17.GetCurrentUserUsecase>(
      () => _i17.GetCurrentUserUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i15.GetUserByIdUsecase>(
      () => _i15.GetUserByIdUsecase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i367.HandleSigningWithGoogleUsecase>(
      () => _i367.HandleSigningWithGoogleUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i474.ResetPasswordUsecase>(
      () => _i474.ResetPasswordUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i867.SendResetPasswordLinkUsecase>(
      () => _i867.SendResetPasswordLinkUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i240.SigninWithEmailUsecase>(
      () => _i240.SigninWithEmailUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i612.SignoutUsecase>(
      () => _i612.SignoutUsecase(authRepository: gh<_i787.AuthRepository>()),
    );
    gh.factory<_i397.SignupWithEmailUsecase>(
      () => _i397.SignupWithEmailUsecase(
        authRepository: gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i519.SignInBloc>(
      () => _i519.SignInBloc(
        signinWithEmailUsecase: gh<_i240.SigninWithEmailUsecase>(),
      ),
    );
    gh.lazySingleton<_i833.AuthBloc>(
      () => _i833.AuthBloc(
        getCurrentUserUsecase: gh<_i17.GetCurrentUserUsecase>(),
        handleSigningWithGoogleUsecase:
            gh<_i367.HandleSigningWithGoogleUsecase>(),
        signoutUsecase: gh<_i612.SignoutUsecase>(),
        sendResetPasswordLinkUsecase: gh<_i867.SendResetPasswordLinkUsecase>(),
        resetPasswordUsecase: gh<_i474.ResetPasswordUsecase>(),
      ),
    );
    gh.factory<_i128.SignUpBloc>(
      () => _i128.SignUpBloc(
        signupWithEmailUsecase: gh<_i397.SignupWithEmailUsecase>(),
        checkEmailIsExistUsecase: gh<_i216.CheckEmailIsExistUsecase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
