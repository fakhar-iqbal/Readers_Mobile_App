import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Readers'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddNewBlogPage.route(),
              );
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
            

          ),
          IconButton(onPressed: (){
            context.read<AuthBloc>().add(AuthSignOut());
          }, 
          icon: const Icon(Icons.logout_rounded,),),
        ],
      ),
    );
  }
}
