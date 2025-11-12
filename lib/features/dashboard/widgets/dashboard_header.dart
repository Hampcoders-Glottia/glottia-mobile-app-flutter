import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/app_colors.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../authentication/bloc/auth_event.dart';
import '../../authentication/view/welcome_screen.dart';

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
        // Botón de cerrar sesión
        IconButton(
          icon: Icon(Icons.logout, color: Colors.redAccent),
          tooltip: 'Cerrar sesión',
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro que deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Cerrar el diálogo
                Navigator.of(dialogContext).pop();
                
                // Emitir evento de logout
                context.read<AuthBloc>().add(LogoutRequested());
                
                // Navegar a WelcomeScreen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}