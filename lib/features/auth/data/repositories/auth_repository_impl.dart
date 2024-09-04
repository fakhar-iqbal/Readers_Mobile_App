import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoriesImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoriesImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
