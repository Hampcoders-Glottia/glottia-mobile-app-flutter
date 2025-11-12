import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_event.dart';
import 'package:glottia_app/features/authentication/models/language.dart';
import 'package:glottia_app/features/authentication/widgets/language_option_card.dart';
import 'package:glottia_app/features/dashboard/view/dashboard_screen.dart';
import 'package:glottia_app/theme/app_colors.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguageCode;

  void _onLanguageSelected(String code) {
    setState(() {
      selectedLanguageCode = code;
    });
  }

  void _onContinue() {
    if (selectedLanguageCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un idioma'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Emitir evento al BLoC si lo necesitas
    context.read<AuthBloc>().add(LanguageSelected(languageCode: selectedLanguageCode!));

    // Navegar al Dashboard
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
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

              const SizedBox(height: 20),

              // Título
              Text(
                'Que te gustaría\naprender?',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: kPrimaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Lista de idiomas
              Expanded(
                child: ListView.builder(
                  itemCount: availableLanguages.length,
                  itemBuilder: (context, index) {
                    final language = availableLanguages[index];
                    final isSelected = selectedLanguageCode == language.code;

                    return LanguageOptionCard(
                      language: language,
                      isSelected: isSelected,
                      onTap: () => _onLanguageSelected(language.code),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Botón continuar
              ElevatedButton(
                onPressed: selectedLanguageCode == null ? null : _onContinue,
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
                        color: selectedLanguageCode == null ? Colors.grey.shade600 : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: selectedLanguageCode == null ? Colors.grey.shade600 : Colors.white,
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
