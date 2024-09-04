import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supaBaseClient;
  AuthRemoteDataSourceImpl(this.supaBaseClient);
  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword({
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

      if(response.user == null){
        throw const ServerException('User not found!');
      }

      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
