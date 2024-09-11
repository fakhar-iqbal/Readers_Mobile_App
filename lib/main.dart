// import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
// import 'package:blog_app/core/theme/app_theme.dart';
// import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:blog_app/features/auth/presentation/pages/sign_in.dart';
// import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
// import 'package:blog_app/init_dependencies.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDependencies();
//   runApp(MultiBlocProvider(
//     providers: [
//       BlocProvider(
//         create: (_) => serviceLocator<AppUserCubit>(),
//       ),
//       BlocProvider(
//         create: (_) => serviceLocator<AuthBloc>(),
//       ),
//     ],
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<AuthBloc>().add(AuthIsUserLoggedIn());
//   }


// @override
// // Widget build(BuildContext context) {
// //   return MaterialApp(
// //     title: 'Blog App',
// //     debugShowCheckedModeBanner: false,
// //     theme: AppTheme.darkThemeMode,
// //     // home: BlocListener<AuthBloc, AuthState>(
// //     //   listener: (context, state) {
// //     //     print('state is $state');
// //     //     if (state is AuthLoggedOut) {
// //     //       Navigator.of(context).pushAndRemoveUntil(
// //     //         MaterialPageRoute(builder: (context) => const SignInPage()),
// //     //         (route) => false,
// //     //       );
// //     //     }
        
// //     //   },
// //     //   child: BlocBuilder<AppUserCubit, AppUserState>(
// //     //     builder: (context, state) {
          
// //     //       if (state is AppUserLoggedIn) {
// //     //         return const BlogPage();
// //     //       } 
// //     //       return const SignInPage();
// //     //     },
// //     //   ),
// //     // ),

// //     home: BlocListener<AuthBloc, AuthState>(
// //         listener: (context, state) {
// //           print('AuthBloc state is $state');
// //           if (state is AuthLoggedOut) {
// //             context.read<AppUserCubit>().updateUser(null); // Clear user data
// //             Navigator.of(context).pushAndRemoveUntil(
// //               MaterialPageRoute(builder: (context) => const SignInPage()),
// //               (route) => false,
// //             );
// //           } else if (state is AuthSuccess) {
// //             // Update AppUserCubit when successfully logged in
// //             context.read<AppUserCubit>().updateUser(state.user);
// //           }
// //         },
// //         child: BlocBuilder<AppUserCubit, AppUserState>(
// //           builder: (context, state) {
// //             print('AppUserCubit state is $state');
// //             if (state is AppUserLoggedIn) {
// //               return const BlogPage();
// //             } 
// //             return const SignInPage();
// //           },
// //         ),
// //       ),
    
// // //     home: BlocConsumer<AuthBloc, AuthState>(
// // //   listener: (context, state) {
// // //     print('state is $state');
// // //     if (state is AuthLoggedOut) {
// // //       Navigator.of(context).pushAndRemoveUntil(
// // //         MaterialPageRoute(builder: (context) => const SignInPage()),
// // //         (route) => false,
// // //       );
// // //     }
// // //   },
// // //   builder: (context, state) {
// // //     print('state 2 is $state');
// // //     if (state is AuthSuccess) {
// // //       return const BlogPage();
// // //     }
    
// // //     return const SignInPage();
// // //   },
// // // )
// //   );
// // }


//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Blog App',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.darkThemeMode,
//       home: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           print('AuthBloc state is $state');
//           if (state is AuthLoggedOut) {
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => const SignInPage()),
//               (route) => false,
//             );
//           } else if (state is AuthSuccess) {
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => const BlogPage()),
//               (route) => false,
//             );
//           }
//         },
//         child: BlocConsumer<AppUserCubit, AppUserState>(
//           listener: (context, state) {
//             print('AppUserCubit state is $state');
//             if (state is AppUserLoggedOut) {
//               print('Navigating to SignInPage due to AppUserLoggedOut');
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => const SignInPage()),
//                 (route) => false,
//               );
//             }
//           },
//           builder: (context, state) {
//             print('AppUserCubit builder state is $state');
//             if (state is AppUserLoggedIn) {
//               return const BlogPage();
//             } else {
//               return const SignInPage();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }


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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    print('AuthWrapper build method called');
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print('AuthBloc state in build: $state');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is AuthLoggedOut) {
            print('Navigating to SignInPage from AuthBloc after delay');
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            });
          } else if (state is AuthSuccess) {
            print('Navigating to BlogPage from AuthBloc after delay');
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const BlogPage()),
              );
            });
          }
        });
      },
      child: BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) {
          print('AppUserCubit state in build: $state');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is AppUserLoggedOut) {
              print('Navigating to SignInPage from AppUserCubit after delay');
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              });
            }
          });
        },
        builder: (context, state) {
          print('AppUserCubit builder: $state');
          if (state is AppUserLoggedIn) {
            return const BlogPage();
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
