import 'package:flutter/material.dart';

// Colores de estado para Table
import '../../../theme/app_colors.dart';

class TableMapGrid extends StatelessWidget {
  const TableMapGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Este es un placeholder. En el futuro, lo reemplazaremos con
    // los iconos de mesas arrastrables.
    return Container(
      height: 300, // Altura fija por ahora
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: GridView.count(
        crossAxisCount: 4, // 4 columnas como en el diseño
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        physics: const NeverScrollableScrollPhysics(), // Evita scroll dentro del grid
        children: List.generate(12, (index) {
          // Generamos 12 mesas de ejemplo
          Color color = kColorAvailable;
          if (index % 4 == 1) color = kColorReserved;
          if (index % 4 == 2) color = kColorOccupied;

          return Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.restaurant_menu, // Icono de mesa de ejemplo
              color: Colors.black54,
            ),
          );
        }),
      ),
    );
  }
}