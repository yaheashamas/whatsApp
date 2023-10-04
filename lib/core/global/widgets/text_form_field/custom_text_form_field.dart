import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? label;
  final String? errorText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final double top;
  final double bottom;
  final double right;
  final double left;
  final bool readOnly;
  final bool obscureText;
  final bool existsSuffix;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final bool withSpace;
  final bool autofocus;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final bool outsideValidation;
  final bool outsideTitle;
  final Function()? onEditingComplete;
  final bool enableInteractiveSelection;

  const CustomTextFormField({
    Key? key,
    this.label,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.controller,
    this.textInputType = TextInputType.text,
    this.errorText,
    this.prefix,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.existsSuffix = false,
    this.suffixIcon,
    this.top = 10,
    this.bottom = 10,
    this.right = 0,
    this.left = 0,
    this.maxLength,
    this.maxLines = 1,
    this.withSpace = false,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.outsideValidation = false,
    this.outsideTitle = false,
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        enableInteractiveSelection: enableInteractiveSelection,
        textAlign: textAlign,
        autofocus: autofocus,
        style: Theme.of(context).textTheme.titleMedium,
        controller: controller,
        readOnly: readOnly,
        keyboardType: textInputType,
        maxLines: maxLines,
        onChanged: onChanged,
        onTap: onTap,
        obscureText: obscureText,
        maxLength: maxLength,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: label,
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: existsSuffix ? suffixIcon : null,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 30,
            minWidth: 30,
          ),
          errorText: errorText,
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
