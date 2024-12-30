import 'package:flutter/material.dart';
import 'package:x_tracker/app/const/app_dimension.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final VoidCallback? onTap;
  final int? minLine;
  final int? maxLine;
  final int? maxLength;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.minLine,
    this.maxLine, this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.margin10),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        minLines: minLine,
        maxLines: maxLine,
        maxLength: maxLength,
        buildCounter: (_, {required currentLength, required isFocused, maxLength}) {
          return null; // Hide the counter
        },
        decoration: InputDecoration(
          isCollapsed: true,

          constraints: BoxConstraints(minHeight: AppDimensions.height30, maxHeight: AppDimensions.height30 * 2),
          contentPadding: EdgeInsets.all(AppDimensions.margin10),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey, fontSize: AppDimensions.font15),
          border: inputBorder(),
          enabledBorder: inputBorder(),
          errorBorder: inputBorder(),
          disabledBorder: inputBorder(),
          focusedBorder: inputBorder(),
          focusedErrorBorder: inputBorder(),
        ),
      ),
    );
  }
}

InputBorder inputBorder() => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(AppDimensions.radius10),
    );
