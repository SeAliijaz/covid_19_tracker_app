import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  ///var
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final TextEditingController? textEditingController;

  ///const
  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText ?? "hintText",
        labelText: labelText ?? "labelText",
        prefixIcon: Icon(
          prefixIcon ?? Icons.abc_outlined,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
