// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:viapp/env/theme/app_theme.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? controller;
  String? hinText;
  bool? obscureText;
  int? maxLines;
  int? maxLength;
  double? fontSize;
  Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final void Function()? onTap;

  CustomTextField({
    Key? key,
    this.controller,
    this.hinText = '',
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.fontSize = 14,
    this.borderColor = AppTheme.borderLineTextField,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.readOnly = false,
    this.focusNode, this.onSubmitted, this.inputFormatters, this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      readOnly: widget.readOnly!,
      inputFormatters: widget.inputFormatters,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.keyboardType,
      textAlign: TextAlign.justify,
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText!,
      obscuringCharacter: '*',
       onTapOutside: (pointerDownEvent) {
        //GlobalHelper.dismissKeyboard(context);
        FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
      },
      style:
          const TextStyle(color: AppTheme.hinText, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: widget.hinText,
        
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor!),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor!),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor!),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
