import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LanguageSelected>(_onLanguageSelected);
    on<LogoutRequested>(_onLogoutRequested);
  }

  FutureOr<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Simula una llamada a API/servicio
    await Future.delayed(const Duration(seconds: 1));

    // Lógica simple de validación de ejemplo
    final email = event.email.trim();
    final password = event.password;

    if (!email.contains('@')) {
      emit(const AuthFailure('Ingrese un correo válido'));
      return;
    }

    if (password.length < 6) {
      emit(const AuthFailure('La contraseña debe tener al menos 6 caracteres'));
      return;
    }

    // Si pasa las validaciones, emitir autenticado
    emit(AuthAuthenticated(email: email));
  }

  FutureOr<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Simula una llamada a API/servicio
    await Future.delayed(const Duration(seconds: 1));

    // Validaciones simples
    final nombre = event.nombre.trim();
    final apellido = event.apellido.trim();
    final email = event.email.trim();
    final password = event.password;

    if (nombre.isEmpty) {
      emit(const AuthFailure('Ingrese su nombre'));
      return;
    }

    if (apellido.isEmpty) {
      emit(const AuthFailure('Ingrese su apellido'));
      return;
    }

    if (!email.contains('@')) {
      emit(const AuthFailure('Ingrese un correo válido'));
      return;
    }

    if (password.length < 6) {
      emit(const AuthFailure('La contraseña debe tener al menos 6 caracteres'));
      return;
    }

    // Si pasa las validaciones, emitir registrado
    emit(AuthRegistered(nombre: nombre, email: email));
  }

  FutureOr<void> _onLanguageSelected(
      LanguageSelected event, Emitter<AuthState> emit) {
    // Aquí puedes guardar el idioma seleccionado en SharedPreferences
    // o enviarlo al backend
    // Por ahora solo emitimos un estado inicial
    // (el idioma ya está guardado en el contexto de la navegación)
  }

  FutureOr<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
