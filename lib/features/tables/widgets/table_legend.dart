import 'package:flutter/material.dart';

class TableLegend extends StatelessWidget {
  const TableLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLegendItem('Disponible', Colors.green.shade300),
        const SizedBox(height: 8),
        _buildLegendItem('Reservada', Colors.orange.shade300),
        const SizedBox(height: 8),
        _buildLegendItem('Ocupada', Colors.red.shade300),
      ],
    );
  }

  // Plantilla para un ítem de la leyenda
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}