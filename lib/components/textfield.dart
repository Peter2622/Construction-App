import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextBox extends StatelessWidget {
   TextBox(
   { this.width,
    this.height,
    required this.controller,
    this.keyboardType,
     this.obscureText = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
     required this.lableText }

    
  );

  double? width;
  double? height;
  TextEditingController controller;
TextInputType? keyboardType;
bool obscureText  ;
int maxLines ;
Widget? prefixIcon;
Widget? suffixIcon;
String lableText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ,
      height: height,
      child: TextFormField(
        
        controller: controller ,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon:prefixIcon , suffixIcon: suffixIcon, label:Text(lableText) , ),
      
      
      ),
    );
  }
}