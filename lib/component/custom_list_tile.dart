import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String trailingText;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.trailingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        trailing: Text(
          trailingText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
