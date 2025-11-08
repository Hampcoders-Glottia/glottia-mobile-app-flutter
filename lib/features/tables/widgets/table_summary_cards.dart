import 'package:flutter/material.dart';

// Importamos los colores definidos
import '../../../theme/app_colors.dart';

class TableSummaryCards extends StatelessWidget {
  const TableSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSummaryCard(context, '12', 'Disponible', kColorAvailable, Colors.green),
        _buildSummaryCard(context, '8', 'Reservadas', kColorReserved, Colors.orange),
        _buildSummaryCard(context, '3', 'Ocupadas', kColorOccupied, Colors.red),
      ],
    );
  }

  // Plantilla para una tarjeta de resumen
  Widget _buildSummaryCard(BuildContext context,
      String count, String label, Color bgColor, Color textColor) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5, // Ajusta el ancho
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}