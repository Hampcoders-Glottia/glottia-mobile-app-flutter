import 'package:flutter/material.dart';
import 'package:glottia_app/features/restaurant/models/promotion.dart';

class RecognitionCard extends StatelessWidget {
  final Recognition recognition;

  const RecognitionCard({
    super.key,
    required this.recognition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            color: Color(0xFFFFB74D),
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            recognition.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            recognition.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              recognition.rating,
              (index) => const Icon(
                Icons.star,
                color: Color(0xFFFFB74D),
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
