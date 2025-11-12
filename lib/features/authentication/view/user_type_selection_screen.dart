import 'package:flutter/material.dart';
import 'package:glottia_app/features/authentication/view/language_selection_screen.dart';
import 'package:glottia_app/features/restaurant/view/restaurant_dashboard_screen.dart';
import 'package:glottia_app/theme/app_colors.dart';

enum UserType { student, restaurant }

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  UserType? selectedType;

  void _onContinue() {
    if (selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un tipo de usuario'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Navegar según el tipo seleccionado
    if (selectedType == UserType.student) {
      // Aprendiz -> Selección de idioma
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
      );
    } else {
      // Local/Restaurante -> Dashboard de restaurante
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RestaurantDashboardScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Botón de retroceso
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: kPrimaryBlue),
                  label: const Text('Back', style: TextStyle(color: kPrimaryBlue)),
                ),
              ),

              const SizedBox(height: 40),

              // Título
              Text(
                '¿Cómo deseas\ncomenzar?',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlue,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'Selecciona tu tipo de cuenta',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Opción: Aprendiz
              _UserTypeCard(
                icon: Icons.school,
                title: 'Soy Aprendiz',
                description: 'Quiero aprender idiomas\npracticando cara a cara',
                isSelected: selectedType == UserType.student,
                onTap: () => setState(() => selectedType = UserType.student),
                color: const Color(0xFF5B7FFF),
              ),

              const SizedBox(height: 20),

              // Opción: Local/Restaurante
              _UserTypeCard(
                icon: Icons.restaurant,
                title: 'Soy Local/Restaurante',
                description: 'Quiero gestionar mi negocio\ny promociones',
                isSelected: selectedType == UserType.restaurant,
                onTap: () => setState(() => selectedType = UserType.restaurant),
                color: const Color(0xFF7B5FFF),
              ),

              const Spacer(),

              // Botón continuar
              ElevatedButton(
                onPressed: selectedType == null ? null : _onContinue,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: kPrimaryBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: selectedType == null ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: selectedType == null ? Colors.grey.shade600 : Colors.white,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _UserTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Row(
          children: [
            // Icono
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.2) : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : color,
              ),
            ),
            const SizedBox(width: 20),
            // Texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white.withValues(alpha: 0.9) : Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Check icon
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
