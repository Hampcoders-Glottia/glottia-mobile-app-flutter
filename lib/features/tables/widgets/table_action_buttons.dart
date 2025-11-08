import 'package:flutter/material.dart';

// Colores
import '../../../theme/app_colors.dart';

class TableActionButtons extends StatelessWidget {

  final VoidCallback? onNewReservationPressed;
  final VoidCallback? onUpdatePressed;
  
  const TableActionButtons({
    super.key,
    this.onNewReservationPressed,
    this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Nueva Reserva'),
            onPressed: onNewReservationPressed,
            // onPressed: () {}
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            child: const Text('Actualizar'),
            onPressed: onUpdatePressed,
            // onPressed: () {}
            style: OutlinedButton.styleFrom(
              foregroundColor: kPrimaryPurple,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: kPrimaryPurple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}