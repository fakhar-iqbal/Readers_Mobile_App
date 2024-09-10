

import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';

class UserSignOut {
  final AuthRepository authRepository;
  UserSignOut(this.authRepository);


  Future<void> signOut()async{
    await authRepository.signOut();
  }

}