part of 'new_reservation_bloc.dart';

// Un enum para rastrear el estado del envío del formulario
enum FormStatus { initial, loading, success, failure }

class NewReservationState extends Equatable {
  // 1. El estado de todos los campos del formulario
  final String name;
  final String phone;
  final String email;
  final int guestCount;
  final DateTime? date;
  final TimeOfDay? time;
  final String? tablePreference;
  final String? occasion;

  // 2. El estado del formulario en sí
  final FormStatus status;
  final String? errorMessage; // Para mostrar un error si falla

  // 3. Constructor con valores iniciales
  const NewReservationState({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.guestCount = 2, // Valor inicial de ejemplo
    this.date,
    this.time,
    this.tablePreference,
    this.occasion,
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  // 4. El método copyWith (¡CRUCIAL!)
  // Nos permite crear una copia del estado pero cambiando solo
  // los campos que necesitamos.
  NewReservationState copyWith({
    String? name,
    String? phone,
    String? email,
    int? guestCount,
    DateTime? date,
    TimeOfDay? time,
    String? tablePreference,
    String? occasion,
    FormStatus? status,
    String? errorMessage,
  }) {
    return NewReservationState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      guestCount: guestCount ?? this.guestCount,
      date: date ?? this.date,
      time: time ?? this.time,
      tablePreference: tablePreference ?? this.tablePreference,
      occasion: occasion ?? this.occasion,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // 5. Props para Equatable
  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        guestCount,
        date,
        time,
        tablePreference,
        occasion,
        status,
        errorMessage,
      ];
}