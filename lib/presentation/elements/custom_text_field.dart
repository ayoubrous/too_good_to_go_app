import 'package:flutter/material.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? validator;
  bool obsecureText;
  bool isPasswordField;
  final IconData? prefixIcon;
  final Widget? suffixicon;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final int? maxline;
  final bool isPrefixIcon;
  final VoidCallback? onTapped;
  final bool enable;
  final bool? readOnly;
  final ValueChanged<String>? onValueChanged;

  CustomTextField({
    super.key,
    required this.hintText,
    this.onValueChanged,
    this.suffixicon,
    this.enable = true,
    this.onTapped,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.obsecureText = false,
    this.isPasswordField = false,
    this.textAlign,
    this.textInputType,
    this.maxline = 1,
    this.isPrefixIcon = false, this.readOnly=false,
  });

  @override
  State<CustomTextField> createState() => _CuctomTextFieldState();
}

class _CuctomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.0),
      child: TextFormField(

        readOnly: widget.readOnly?? false,
        maxLines: widget.maxline,
        enabled: widget.enable,
        onTap: widget.onTapped,
        keyboardType: widget.textInputType ?? TextInputType.text,
        textAlign: widget.textAlign ?? TextAlign.start,
        controller: widget.controller,
        validator: (val) => widget.validator!(val!),
        obscureText: widget.obsecureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.isPrefixIcon
              ? Icon(
                  widget.prefixIcon,
                  color: AppColors.kPrimaryColor,
                )
              : null,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obsecureText = !widget.obsecureText;
                    });
                  },
                  child: Icon(
                    widget.obsecureText ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: AppColors.blackTextColor,
                  ))
              : widget.suffixicon,
        ),
      ),
    );
  }
}
