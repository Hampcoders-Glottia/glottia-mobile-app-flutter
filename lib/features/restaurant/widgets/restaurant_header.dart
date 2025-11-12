import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication/bloc/auth_bloc.dart';
import '../../authentication/bloc/auth_event.dart';
import '../../authentication/view/welcome_screen.dart';

class RestaurantHeader extends StatelessWidget {
  final String restaurantName;
  final String subtitle;

  const RestaurantHeader({
    super.key,
    required this.restaurantName,
    this.subtitle = 'Dashboard Local',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar del restaurante
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF7B5FFF),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B5FFF).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        // Nombre y subtítulo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        // Icono de notificaciones
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF7B5FFF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
        // Botón de cerrar sesión
        GestureDetector(
          onTap: () => _showLogoutDialog(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 22,
            ),
          ),
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
                
                // Navegar a WelcomeScreen eliminando todo el historial
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
