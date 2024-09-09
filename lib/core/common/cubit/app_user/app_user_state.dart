part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}


//core cannot depend on other features
//other features can depend on core

final class AppUserLoggedIn extends AppUserState{
  final User user;
  AppUserLoggedIn(this.user);
}