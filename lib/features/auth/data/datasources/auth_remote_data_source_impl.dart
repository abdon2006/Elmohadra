import 'package:elmohadra/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:elmohadra/features/auth/data/models/user_model.dart';
import 'package:elmohadra/features/auth/domain/entities/auth_user_result.dart';
import 'package:elmohadra/features/auth/domain/entities/user_entity.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signin_params.dart';
import 'package:elmohadra/features/auth/domain/usecases/prams%20classes/signup_params.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  Future<UserModel?> _fetchProfile(String userId) async {
    final res = await supabaseClient
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle();
    return res == null ? null : UserModel.fromJson(res);
  }

  @override
  Future<UserModel> signInWithEmail(SigninParams params) async {
    final res = await supabaseClient.auth.signInWithPassword(
      password: params.password,
      email: params.email,
    );

    final user = res.user;
    if (user == null) {
      throw AuthException('invalid_credentials', code: 'invalid_credentials');
    }

    final profile = await _fetchProfile(user.id);
    if (profile == null) {
      throw AuthException('user_not_found', code: 'user_not_found');
    }
    return profile;
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<UserModel> signUpWithEmail(SignupParams params) async {
    final String userId;

    /// case 1 : normal signup
    if (params.password != null) {
      final res = await supabaseClient.auth.signUp(
        password: params.password!,
        email: params.email,
      );

      final user = res.user;
      if (user == null) {
        throw AuthException('signup_failed', code: 'signup_failed');
      }
      userId = user.id;
    }
    /// case 2 : google signup (new account)
    else {
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw AuthException('user_not_found', code: 'user_not_found');
      }
      userId = user.id;
    }

    // When email confirmation is enabled Supabase returns a user without a
    // session, so inserting the profile would fail silently on RLS.
    if (supabaseClient.auth.currentSession == null) {
      throw AuthException('email_not_confirmed', code: 'email_not_confirmed');
    }

    final res2 = await supabaseClient
        .from('users')
        .insert({
          'id': userId,
          'name': params.name,
          'nickname': params.nickName,
          'email': params.email,
          'university': params.university,
          'academic_year': params.academicYear,
          'level': 1,
          'xp': 0,
          'total_battles': 0,
          'won_battles': 0,
          'defeat_battles': 0,
          'draw_battles': 0,
          'coins': 0,
          'avatar_key': params.avatarKey,
          'created_at': DateTime.now().toIso8601String(),
          'status': UserStatus.active.name,
        })
        .select()
        .single();

    return UserModel.fromJson(res2);
  }

  @override
  Future<void> handleSigningWithGoogle() async {
    await supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'elmohadra://login-callback',
    );
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    final profile = await _fetchProfile(userId);
    if (profile == null) {
      throw AuthException('user_not_found', code: 'user_not_found');
    }
    return profile;
  }

  @override
  Future<AuthUserResult> getCurrentUser() async {
    final currentUser = supabaseClient.auth.currentUser;
    if (currentUser == null) return AuthUserResult();

    final profile = await _fetchProfile(currentUser.id);
    if (profile == null) {
      return AuthUserResult(
        newUserId: currentUser.id,
        newUseremail: currentUser.email,
      );
    }
    return AuthUserResult(existingUser: profile);
  }

  @override
  Future<bool> checkEmailIsExist(String email) async {
    final res = await supabaseClient.functions.invoke(
      'check-email-exists',
      body: {'email': email},
    );
    return res.data['exists'] as bool;
  }
}
