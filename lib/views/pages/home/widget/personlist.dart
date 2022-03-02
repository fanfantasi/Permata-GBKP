import 'package:anggota/service/constants.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  final String label;
  final String text;
  final IconData? icon;
  const PersonWidget(
      {Key? key, required this.text, required this.label, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          indent: 12.0,
        )
      ],
    );
  }
}
