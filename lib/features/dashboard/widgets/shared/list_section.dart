import 'package:flutter/material.dart';

class ListSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const ListSection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          // Usamos Column.children para apilar los items
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}