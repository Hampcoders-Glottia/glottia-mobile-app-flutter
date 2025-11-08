import 'package:flutter/material.dart';

class ReservationDateTime extends StatelessWidget {
  const ReservationDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha y Hora',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildDateTimePicker(
                context: context,
                icon: Icons.calendar_today,
                label: '15 Octubre 2025',
                onTap: () {
                  // TODO: Mostrar un DatePicker
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateTimePicker(
                context: context,
                icon: Icons.access_time,
                label: '5:00 PM',
                onTap: () {
                  // TODO: Mostrar un TimePicker
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Plantilla para un campo de fecha/hora
  Widget _buildDateTimePicker({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}