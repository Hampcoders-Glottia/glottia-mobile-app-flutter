import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final String userName;
  final String userSubtitle;
  
  // Recibe los datos que necesita, nada más.
  const DashboardHeader({
    super.key,
    required this.userName,
    required this.userSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    // Este es el mismo código que teníamos en _buildHeader()
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/prueba.png'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userSubtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.star_border_purple500_outlined, color: kPrimaryPurple),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: kPrimaryPurple),
          onPressed: () {},
        ),
      ],
    );
  }
}