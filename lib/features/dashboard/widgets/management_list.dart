import 'package:flutter/material.dart';
import 'shared/custom_list_tile.dart';
import 'shared/list_section.dart';
import '../../../theme/app_colors.dart';

import '../../tables/view/tables_view_screen.dart';

class ManagementList extends StatelessWidget {
  const ManagementList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListSection(
      title: 'Gestion del Establecimiento',
      items: [
        CustomListTile(
          title: 'Eventos y Actividad',
          subtitle: 'Gestionar experiencias culturales',
          icon: Icons.calendar_today_outlined,
          iconBgColor: kIconBlue,
          iconColor: Colors.blue,
        ),
        CustomListTile(
          title: 'Comunidad',
          subtitle: 'Conectar con clientes regulares',
          icon: Icons.group_outlined,
          iconBgColor: kIconGreen,
          iconColor: Colors.green,
        ),
        CustomListTile(
          title: 'Perfil del Local',
          subtitle: 'Editar informacion y fotos',
          icon: Icons.store_outlined,
          iconBgColor: Color(0xFFFFF3E0), // Naranja claro
          iconColor: Colors.orange,
          onTap: () {
            // Navegar a la pantalla de gestion de tablas
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TablesViewScreen()),
            );
          },
        ),
        CustomListTile(
          title: 'Promociones',
          subtitle: 'Crear ofertas especiales',
          icon: Icons.local_offer_outlined,
          iconBgColor: Color(0xFFFFEBEE), // Rojo claro
          iconColor: Colors.red,
        ),
      ],
    );
  }
}