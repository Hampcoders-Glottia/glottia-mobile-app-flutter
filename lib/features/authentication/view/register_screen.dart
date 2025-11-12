import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_bloc.dart';
import 'package:glottia_app/features/authentication/bloc/auth_event.dart';
import 'package:glottia_app/features/authentication/bloc/auth_state.dart';
import 'package:glottia_app/features/authentication/widgets/auth_text_field.dart';
import 'package:glottia_app/features/authentication/widgets/password_field.dart';
import 'package:glottia_app/features/authentication/view/registration_success_screen.dart';
import 'package:glottia_app/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final nombre = _nombreController.text;
    final apellido = _apellidoController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<AuthBloc>().add(RegisterRequested(
          nombre: nombre,
          apellido: apellido,
          email: email,
          password: password,
        ));
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

            if (state is AuthRegistered) {
              // Navegar a pantalla de éxito
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => RegistrationSuccessScreen(nombre: state.nombre),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Registrate',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Regístrate a la aplicación para poder\nutilizar todas sus funcionalidades!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Campos
                AuthTextField(
                  controller: _nombreController,
                  hintText: 'Nombre',
                  icon: Icons.person_outline,
                ),
                AuthTextField(
                  controller: _apellidoController,
                  hintText: 'Apellido',
                  icon: Icons.person_outline,
                ),
                AuthTextField(
                  controller: _emailController,
                  hintText: 'Correo',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                PasswordField(controller: _passwordController),

                const SizedBox(height: 30),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final loading = state is AuthLoading;
                    return ElevatedButton(
                      onPressed: loading ? null : _onSubmit,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: kPrimaryBlue,
                        disabledBackgroundColor: kPrimaryBlue.withValues(alpha: 0.6),
                      ),
                      child: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Registrarse',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Ya tienes una cuenta? ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Inicia Sesión aquí',
                          style: const TextStyle(
                            color: kPrimaryBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacementNamed('/login');
                            },
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'O continúa con una cuenta',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),

                // Botones de redes sociales
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      icon: Icons.apple,
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    _SocialButton(
                      icon: Icons.facebook,
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    _SocialButton(
                      icon: Icons.g_mobiledata,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }
}
