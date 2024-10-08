import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supaBaseClient;
  AuthRemoteDataSourceImpl(this.supaBaseClient);

  @override
  Session? get currentUserSession => supaBaseClient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supaBaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const ServerException('User not found!');
      }else if (response.user!.emailConfirmedAt == null){
        throw const ServerException('Email not verified. Verify by accessing the gmail app!');
      }
      return UserModel.fromJson(response.user!.toJson());
      
    } catch (e) {
      throw ServerException(e.toString());
    }
  }



  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supaBaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException('User not found!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {

      if (currentUserSession != null) {
        final userData = await supaBaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
            

        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        ); 
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
@override
Future<void> signOut() async {
  try {
    await supaBaseClient.auth.signOut();
  } catch (e) {
    throw ServerException('Error logging out: $e');
  }
}
}
