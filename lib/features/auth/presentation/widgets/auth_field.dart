import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscureText;
  final String hintText;
  const AuthField({super.key,required this.hintText, required this.controller, this.isObscureText=false,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.98, // 80% of screen width
      height:60.0,
      child: TextFormField(
        controller: controller ,
        
        decoration: InputDecoration(
          hintText: hintText,
          
        ),
        validator: (value){
          if(value!.isEmpty){
            return "$hintText is missing!";
          }
          return null;
        },
        obscureText: isObscureText,
      ),
    );
  }
}