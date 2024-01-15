// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';

class CustomTextField extends StatefulWidget {
   CustomTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.hint,
    required this.isPassword,
    required this.textInputAction,
    required this.textInputType,
    this.onChange,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? prefixIcon;
  final String? suffixIcon;
  final String hint;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  Function(String)? onChange; 
  Function(String)? onSubmitted; 

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: widget.controller,
          onChanged:  widget.onChange,
          onSubmitted: widget.onSubmitted,
          cursorColor: AppColors.red,
          obscureText: widget.isPassword ? !showPassword : false,
          textDirection: Get.locale!.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            prefixIcon: widget.prefixIcon != null
                ? Image.asset(
                    widget.prefixIcon!,
                  )
                : Visibility(visible: false, child: Icon(Icons.abc)),
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Image.asset(
                      widget.suffixIcon!,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: AppColors.red),
              borderRadius: BorderRadius.circular(10.0),
            ),
            //hintText: widget.hint,
            labelText: widget.hint,
            labelStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
