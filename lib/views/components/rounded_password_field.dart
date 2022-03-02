import 'package:anggota/service/constants.dart';
import 'package:anggota/views/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Color color;
  final String text;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool visible = true;

  void togglepassword() {
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: widget.color,
      child: TextField(
        obscureText: visible,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.text.toString(),
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
              onTap: () => togglepassword(),
              child: visible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
