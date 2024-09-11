import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Blog App',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.darkThemeMode,
    home: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('state is $state');
        if (state is AuthLoggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignInPage()),
            (route) => false,
          );
        }else if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BlogPage()),
              (route) => false,
            );
          }
        
      },
      child: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return const BlogPage();
          } 
          return const SignInPage();
        },
      ),
    ),
  );
}


}