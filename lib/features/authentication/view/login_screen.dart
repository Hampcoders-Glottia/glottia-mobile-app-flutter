import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_event.dart';
import 'package:glottia_app/features/authentication/bloc/auth_state.dart';
import 'package:glottia_app/features/authentication/widgets/auth_text_field.dart';
import 'package:glottia_app/features/authentication/widgets/password_field.dart';
import 'package:glottia_app/features/authentication/view/user_type_selection_screen.dart';
import 'package:glottia_app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<AuthBloc>().add(LoginRequested(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ));
            }

            if (state is AuthAuthenticated) {
              // Navegar a selección de tipo de usuario
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const UserTypeSelectionScreen()),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: kPrimaryBlue),
                    label: const Text('Back', style: TextStyle(color: kPrimaryBlue)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Iniciar Sesión',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingrese su correo y su contraseña para\niniciar sesión',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Campos
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Correo',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                PasswordField(controller: _passwordController),

                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implementar recuperación de contraseña
                    },
                    child: const Text(
                      'Olvidaste tu contraseña? Recuperala aquí',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final loading = state is AuthLoading;
                    return ElevatedButton(
                      onPressed: loading ? null : _onSubmit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: kPrimaryBlue,
                        disabledBackgroundColor: kPrimaryBlue.withValues(alpha: 0.6),
                      ),
                      child: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'Continuar',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'No tienes una cuenta? ',
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.black87, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Registrate',
                          style: const TextStyle(
                            color: kPrimaryBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacementNamed('/register');
                            },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
