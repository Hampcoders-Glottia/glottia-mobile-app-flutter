import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Unimos los archivos de evento y estado
part 'new_reservation_event.dart';
part 'new_reservation_state.dart';

class NewReservationBloc
    extends Bloc<NewReservationEvent, NewReservationState> {
  // 1. Definimos el estado inicial
  NewReservationBloc() : super(const NewReservationState()) {
    
    // 2. Registramos un manejador para cada evento
    on<NameChanged>(_onNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<GuestCountChanged>(_onGuestCountChanged);
    on<DateChanged>(_onDateChanged);
    on<TimeChanged>(_onTimeChanged);
    on<TablePreferenceChanged>(_onTablePreferenceChanged);
    on<OccasionChanged>(_onOccasionChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  // 3. Implementamos los manejadores
  // Cada vez que llega un evento, emitimos un *nuevo* estado
  // usando 'copyWith'
  void _onNameChanged(NameChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(name: event.name, status: FormStatus.initial));
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(phone: event.phone, status: FormStatus.initial));
  }

  void _onEmailChanged(EmailChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(email: event.email, status: FormStatus.initial));
  }

  void _onGuestCountChanged(GuestCountChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(guestCount: event.count, status: FormStatus.initial));
  }

  void _onDateChanged(DateChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(date: event.date, status: FormStatus.initial));
  }

  void _onTimeChanged(TimeChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(time: event.time, status: FormStatus.initial));
  }

  void _onTablePreferenceChanged(
      TablePreferenceChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(
        tablePreference: event.preference, status: FormStatus.initial));
  }

  void _onOccasionChanged(
      OccasionChanged event, Emitter<NewReservationState> emit) {
    emit(state.copyWith(occasion: event.occasion, status: FormStatus.initial));
  }

  // El manejador de envío
  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<NewReservationState> emit) async {
    // 1. Ponemos el estado en "cargando"
    emit(state.copyWith(status: FormStatus.loading));

    // 2. Aquí iría tu validación
    if (state.name.isEmpty) {
      emit(state.copyWith(
          status: FormStatus.failure,
          errorMessage: 'El nombre no puede estar vacío'));
      return; // Detenemos la ejecución
    }

    try {
      // 3. Simulamos un envío a una API
      await Future.delayed(const Duration(seconds: 2));

      // 4. ¡Éxito!
      print('Reserva enviada: ${state.toString()}');
      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      // 5. Falla
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.toString()));
    }
  }
}