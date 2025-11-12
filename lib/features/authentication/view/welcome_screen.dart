import 'package:flutter/material.dart';
import 'package:glottia_app/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Título
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Bienvenido a\n',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: 'Glottia',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Subtítulo
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Practica idiomas ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: 'cara a\ncara',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Ilustración (placeholder - en las imágenes hay una ilustración)
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Color(0xFFB8C5E8), // Color azul claro de fondo
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Burbujas de texto simuladas
                      _SpeechBubble(text: 'Hello!', color: Color(0xFF6B8DD6)),
                      const SizedBox(height: 10),
                      _SpeechBubble(text: 'Hola', color: Color(0xFF4A6FA5)),
                      const SizedBox(height: 10),
                      _SpeechBubble(text: 'Bonjour', color: Color(0xFF5B7FFF)),
                      const SizedBox(height: 20),
                      // Iconos de personas (simplificado)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF8FA7D4),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF6B8DD6),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF4A6FA5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Botones
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: kPrimaryBlue,
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/register');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: kPrimaryBlue,
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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

class _SpeechBubble extends StatelessWidget {
  final String text;
  final Color color;

  const _SpeechBubble({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
