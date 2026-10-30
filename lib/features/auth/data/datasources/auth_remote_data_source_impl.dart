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

  @override
  Future<UserModel> signInWithEmail(SigninParams params) async {
    try {
      final String userId;
      final res = await supabaseClient.auth.signInWithPassword(
        password: params.password,
        email: params.email,
      );
      userId = res.user!.id;
      final res2 = await supabaseClient.from('users').select().eq('id', userId);
      return UserModel.fromJson(res2[0]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUpWithEmail(SignupParams params) async {
    try {
      final String userId;
      if (params.password != null) {
        final res = await supabaseClient.auth.signUp(
          password: params.password!,
          email: params.email,
        );
        userId = res.user!.id;
      } else {
        userId = supabaseClient.auth.currentUser!.id;
      }

      final res2 = await supabaseClient.from('users').insert({
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
      }).select();

      return UserModel.fromJson(res2[0]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> handleSigningWithGoogle() async {
    try {
      await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'elmohadra://login-callback',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final res = await supabaseClient.from('users').select().eq('id', userId);
      return UserModel.fromJson(res[0]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserResult> getCurrentUser() async {
    final res = supabaseClient.auth.currentUser;
    if (res != null) {
      print(
        '----------- found user signed in (getCurrent user impl in datasource : res1) -------------',
      );
      final List<Map<String, dynamic>> res2 = await supabaseClient
          .from('users')
          .select()
          .eq('id', res.id);

      if (res2.isEmpty) {
        print(
          '----------- the user isn\'t in the database  (getCurrent user impl in datasource ) -------------',
        );

        return AuthUserResult(newUserId: res.id, newUseremail: res.email);
      } else {
        print(
          '----------- found user in database (getCurrent user impl in datasource : res2) -------------',
        );
        return AuthUserResult(existingUser: UserModel.fromJson(res2[0]));
      }
    } else {
      print(
        '----------- returning empty AuthUserResult (getCurrent user impl in datasource ) -------------',
      );
      return AuthUserResult();
    }
  }

  @override
  Future<bool> checkEmailIsExist(String email) async {
    final res = await supabaseClient.from('users').select().eq('email', email);
    print('check email res: $res');
    if (res.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
