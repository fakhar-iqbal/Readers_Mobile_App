import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<User, UserSigninParams> {
  final AuthRepository authRepository;
  const UserSignIn(
    this.authRepository,
  );

  @override
  Future<Either<Failure, User>> call(UserSigninParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSigninParams {
  final String password;
  final String email;

  const UserSigninParams({
    required this.email,
    required this.password,
  });
}
