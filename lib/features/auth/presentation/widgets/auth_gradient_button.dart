import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  const AuthGradientButton({super.key,required this.name,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          AppPallete.gradient1, AppPallete.gradient2,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,),  
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(onPressed: onPressed,
      
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      
      ),
      child:  Text(name,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),),
      ),
    );
  }
}