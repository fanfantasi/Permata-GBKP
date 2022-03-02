import 'package:anggota/service/constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.0),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: kPrimaryColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
