import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_reservation_bloc.dart';

class ReservationDateTime extends StatelessWidget {
  const ReservationDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Obtenemos el BLoC una vez
    final bloc = context.read<NewReservationBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha y Hora',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        
        // 4. Envolvemos la fila en un BlocBuilder
        //    para que la UI se actualice con el estado del BLoC
        BlocBuilder<NewReservationBloc, NewReservationState>(
          // Optimización: solo redibuja si la fecha o la hora cambian
          buildWhen: (previous, current) =>
              previous.date != current.date || previous.time != current.time,
          builder: (context, state) {
            
            // 5. Formateamos los valores del estado
            final String dateLabel = state.date == null
                ? 'Seleccionar Fecha'
                // Formato: "15 Octubre 2025" (gracias a 'intl')
                : DateFormat.yMMMMd('es').format(state.date!);
                
            final String timeLabel = state.time == null
                ? 'Seleccionar Hora'
                // Formato: "5:00 PM"
                : state.time!.format(context);

            return Row(
              children: [
                Expanded(
                  child: _buildDateTimePicker(
                    context: context,
                    icon: Icons.calendar_today,
                    label: dateLabel, // 6. Muestra el valor del BLoC
                    onTap: () => _showDatePicker(context, bloc, state.date), // 7. Llama al picker
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimePicker(
                    context: context,
                    icon: Icons.access_time,
                    label: timeLabel, // 6. Muestra el valor del BLoC
                    onTap: () => _showTimePicker(context, bloc, state.time), // 7. Llama al picker
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // --- 8. Lógica para el Date Picker ---
  Future<void> _showDatePicker(
      BuildContext context, NewReservationBloc bloc, DateTime? currentDate) async {
    // Muestra el selector de fecha nativo
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(), // Fecha inicial
      firstDate: DateTime.now(), // No se puede reservar en el pasado
      lastDate: DateTime.now().add(const Duration(days: 365)), // 1 año a futuro
      locale: const Locale('es'), // Pone el picker en español
    );

    // Si el usuario seleccionó una fecha (no canceló)
    if (newDate != null) {
      // 9. Envía el evento al BLoC
      bloc.add(DateChanged(newDate));
    }
  }

  // --- 10. Lógica para el Time Picker ---
  Future<void> _showTimePicker(
      BuildContext context, NewReservationBloc bloc, TimeOfDay? currentTime) async {
    // Muestra el selector de hora nativo
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: currentTime ?? TimeOfDay.now(), // Hora inicial
    );

    // Si el usuario seleccionó una hora (no canceló)
    if (newTime != null) {
      // 9. Envía el evento al BLoC
      bloc.add(TimeChanged(newTime));
    }
  }

  // Plantilla (igual que antes, solo recibe onTap)
  Widget _buildDateTimePicker({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}