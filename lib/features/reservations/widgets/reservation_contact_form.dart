import 'package:flutter/material.dart';
// Importamos el BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_reservation_bloc.dart';

class ReservationContactForm extends StatelessWidget {
  const ReservationContactForm({super.key});

 @override
  Widget build(BuildContext context) {
    // 1. Envolvemos todo en un BlocBuilder
    // Esto asegura que los campos se redibujen si el estado cambia
    return BlocBuilder<NewReservationBloc, NewReservationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informacion del Contacto',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            
            // --- CAMPO DE NOMBRE ---
            _buildTextField(
              context: context,
              // 2. Usamos una 'key' única para forzar a Flutter
              //    a reconstruir el widget con el nuevo 'initialValue'
              key: Key('name_field_${state.name}'),
              // 3. El valor viene del BLoC
              initialValue: state.name,
              hint: 'Nombre Completo',
              // 4. Cuando cambia, enviamos un evento al BLoC
              onChanged: (value) {
                context.read<NewReservationBloc>().add(NameChanged(value));
              },
            ),
            const SizedBox(height: 12),

            // --- CAMPO DE TELÉFONO ---
            _buildTextField(
              context: context,
              key: Key('phone_field_${state.phone}'),
              initialValue: state.phone,
              hint: 'Número de Teléfono',
              onChanged: (value) {
                context.read<NewReservationBloc>().add(PhoneChanged(value));
              },
            ),
            const SizedBox(height: 12),

            // --- CAMPO DE EMAIL ---
            _buildTextField(
              context: context,
              key: Key('email_field_${state.email}'),
              initialValue: state.email,
              hint: 'Correo electrónico',
              onChanged: (value) {
                context.read<NewReservationBloc>().add(EmailChanged(value));
              },
            ),
          ],
        );
      },
    );
  }

  // Plantilla para un campo de texto (ahora recibe más parámetros)
  Widget _buildTextField({
    required BuildContext context,
    required Key key,
    required String initialValue,
    required String hint,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}