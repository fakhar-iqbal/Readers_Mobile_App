import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
  }

  void _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    try{
      await _userSignOut.signOut();
      _appUserCubit.updateUser(null);
      emit(const AuthLoggedOut());
      
      

    } catch(e){
      emit(AuthFailure(e.toString()));
    }
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emit(const AuthNeedsVerification()),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignIn(UserSigninParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User? user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user),
    );
  }
}
