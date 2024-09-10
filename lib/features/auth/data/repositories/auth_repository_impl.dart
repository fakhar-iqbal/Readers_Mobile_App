import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoriesImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoriesImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async =>  await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    return _getUser(() async => await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      )); 
  }

  Future<Either<Failure,User>> _getUser(Future<User> Function() fn,) async{
    try{
      final user = await fn();
      
      return right(user);
    } on sb.AuthException catch(e){
      return left(Failure(e.message));
    } 
    on ServerException catch(e){
      return left(Failure(e.message));
    } 
  }
  
  @override
  Future<Either<Failure, User>> currentUser() async{
      try{
        final user = await authRemoteDataSource.getCurrentUserData();
        if(user==null){
          return left(Failure('User Not logged in!'));
        }

        return right(user);
      } on ServerException catch(e){
        return left(Failure(e.message));
      }
  }
  
  @override
  Future<void> signOut() async{
    final user = await authRemoteDataSource.getCurrentUserData();
        if(user!=null){
          authRemoteDataSource.signOut();
        }
  }
}
