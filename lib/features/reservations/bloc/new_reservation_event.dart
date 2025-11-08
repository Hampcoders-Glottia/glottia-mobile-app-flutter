part of 'new_reservation_bloc.dart';

abstract class NewReservationEvent extends Equatable {
  const NewReservationEvent();

  @override
  List<Object?> get props => [];
}

// Evento cuando el usuario escribe en el campo de nombre
class NameChanged extends NewReservationEvent {
  final String name;
  const NameChanged(this.name);
  @override
  List<Object> get props => [name];
}

// Evento cuando el usuario escribe en el campo de teléfono
class PhoneChanged extends NewReservationEvent {
  final String phone;
  const PhoneChanged(this.phone);
  @override
  List<Object> get props => [phone];
}

// Evento cuando el usuario escribe en el campo de email
class EmailChanged extends NewReservationEvent {
  final String email;
  const EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

// Evento cuando el usuario cambia el número de invitados
class GuestCountChanged extends NewReservationEvent {
  final int count;
  const GuestCountChanged(this.count);
  @override
  List<Object> get props => [count];
}

// Evento cuando el usuario selecciona una fecha
class DateChanged extends NewReservationEvent {
  final DateTime date;
  const DateChanged(this.date);
  @override
  List<Object> get props => [date];
}

// Evento cuando el usuario selecciona una hora
class TimeChanged extends NewReservationEvent {
  final TimeOfDay time;
  const TimeChanged(this.time);
  @override
  List<Object> get props => [time];
}

// Evento cuando el usuario selecciona una preferencia de mesa
class TablePreferenceChanged extends NewReservationEvent {
  final String preference;
  const TablePreferenceChanged(this.preference);
  @override
  List<Object> get props => [preference];
}

// Evento cuando el usuario selecciona una ocasión
class OccasionChanged extends NewReservationEvent {
  final String occasion;
  const OccasionChanged(this.occasion);
  @override
  List<Object> get props => [occasion];
}

// Evento cuando el usuario presiona "Confirmar Reserva"
class FormSubmitted extends NewReservationEvent {}