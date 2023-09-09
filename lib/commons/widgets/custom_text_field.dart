import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.title,
    this.hint,
    this.fillColor,
    this.controller,
    this.textInputType,
    this.obscure,
    this.onPressed,
    this.validator,
    this.iconVisible,
    this.isSearchBar = false,
    this.readOnly,
    this.focusNode,
    this.autoValidateMode,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
    this.inputDecoration,
    this.labelText,
  }) : super(key: key);

  final String? title;
  final String? hint;
  final Color? fillColor;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? iconVisible;
  final bool? isSearchBar;
  final bool? readOnly;
  final bool? obscure;
  String? labelText;
  AutovalidateMode? autoValidateMode;
  List<TextInputFormatter>? inputFormatters;
  Function()? onPressed;
  FocusNode? focusNode;
  Widget? suffixIcon;
  Widget? prefixIcon;
  InputDecoration? inputDecoration;
  FormFieldValidator<String>? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(8.0);
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      readOnly: widget.readOnly ?? false,
      obscureText: widget.obscure!,
      cursorColor: const Color(0xFF16B98D),
      inputFormatters: widget.inputFormatters ?? [],
      focusNode: widget.focusNode,
      keyboardType: widget.textInputType,
      validator: widget.validator ??
          (value) {
            return null;
          },
      textAlignVertical: widget.isSearchBar!
          ? TextAlignVertical.bottom
          : TextAlignVertical.center,
      textInputAction:
          widget.isSearchBar! ? TextInputAction.search : TextInputAction.done,
      controller: widget.controller,
      decoration: widget.inputDecoration ??
          InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide:
                  BorderSide(width: 0.5, color: Colors.red.withOpacity(0.9)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide:
                  BorderSide(width: 0.5, color: Colors.red.withOpacity(0.9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide:
                  BorderSide(width: 0.2, color: Colors.black.withOpacity(0.9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide:
                  BorderSide(width: 0.2, color: Colors.black.withOpacity(0.9)),
            ),
            fillColor: widget.fillColor ?? Colors.transparent,
            suffixIcon: widget.suffixIcon ??
                InkWell(
                  onTap: widget.onPressed,
                  splashColor: Colors.white.withOpacity(0.1),
                  focusColor: Colors.white.withOpacity(0.1),
                  hoverColor: Colors.white.withOpacity(0.1),
                  child: Container(
                    margin: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(
                      widget.obscure == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: widget.iconVisible == true
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                  ),
                ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            labelText: widget.labelText,
            hintText: widget.hint ?? "",
            prefixIcon: widget.prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 08),
          ),
    );
  }
}
