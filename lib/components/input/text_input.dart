import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';

class TextInput extends StatefulWidget {
  TextInput({
    super.key,
    required this.maxLength,
    required this.prefixIcon,
    required this.suffixText,
    required this.hintText,
    required this.counterText,
    required this.onChanged,
    required this.errorText,
    this.autofocus,
    this.controller,
  });

  int maxLength;
  IconData prefixIcon;
  String suffixText;
  String hintText;
  String counterText;
  String? errorText;
  Function(String value) onChanged;
  bool? autofocus;
  TextEditingController? controller;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: Theme.of(context).textTheme.bodyLarge,
      autofocus: widget.autofocus != null,
      keyboardType: inputKeyboardType,
      textInputAction: TextInputAction.next,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        suffixText: widget.suffixText,
        errorText: widget.errorText,
        counterText: widget.counterText,
        hintText: widget.hintText,
        contentPadding: inputContentPadding,
      ),
      onChanged: widget.onChanged,
    );
  }
}