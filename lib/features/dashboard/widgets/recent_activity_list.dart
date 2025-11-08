import 'package:flutter/material.dart';
import 'shared/custom_list_tile.dart';
import 'shared/list_section.dart';
import '../../../theme/app_colors.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListSection(
      title: 'Actividad Reciente',
      items: [
        CustomListTile(
          title: 'Nuevo miembro se unió',
          subtitle: 'Ana Garcia - hace 2 horas',
          icon: Icons.person_add_alt_1_outlined,
          iconBgColor: kIconGreen,
          iconColor: Colors.green,
          showArrow: false,
        ),
        CustomListTile(
          title: 'Evento programado',
          subtitle: 'Noche de Jazz - mañana 8:00',
          icon: Icons.calendar_today_outlined,
          iconBgColor: kIconBlue,
          iconColor: Colors.blue,
          showArrow: false,
        ),
        CustomListTile(
          title: 'Nueva reseña',
          subtitle: '5 estrellas - "Excelente ambiente"',
          icon: Icons.star_outline,
          iconBgColor: Color(0xFFFFFDE7), // Amarillo claro
          iconColor: Colors.amber,
          showArrow: false,
        ),
      ],
    );
  }
}