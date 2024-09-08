import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: BlocConsumer<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if(state is AuthFailure){
//               showSnackBar(context, state.message);
//             }
//           },
//           builder: (context, state) {
//             if(state is AuthLoading){
//               return const Loader();
//             }
//             return SingleChildScrollView(
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Sign Up.',
//                       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     AuthField(
//                       hintText: 'Name',
//                       controller: nameController,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     AuthField(
//                       hintText: 'Email',
//                       controller: emailController,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     AuthField(
//                       hintText: 'Password',
//                       controller: passwordController,
//                       isObscureText: true,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     AuthGradientButton(
//                       name: "Sign Up",
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           context.read<AuthBloc>().add(AuthSignUp(
//                                 email: emailController.text.trim(),
//                                 name: nameController.text.trim(),
//                                 password: passwordController.text.trim(),
//                               ));
//                         }
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, SignInPage.route());
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           text: "Already have an account?  ",
//                           style: Theme.of(context).textTheme.titleMedium,
//                           children: [
//                             TextSpan(
//                               text: 'Sign In',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium
//                                   ?.copyWith(
//                                     color: AppPallete.gradient2,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthFailure){
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if(state is AuthLoading){
          return const Loader();
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          const Text(
                            'Sign Up.',
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthField(
                            hintText: 'Name',
                            controller: nameController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                            hintText: 'Email',
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthField(
                            hintText: 'Password',
                            controller: passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthGradientButton(
                            name: "Sign Up",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthSignUp(
                                      email: emailController.text.trim(),
                                      name: nameController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ));
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, SignInPage.route());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account?  ",
                                style: Theme.of(context).textTheme.titleMedium,
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppPallete.gradient2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        );
      },
    ),
  );
}
}