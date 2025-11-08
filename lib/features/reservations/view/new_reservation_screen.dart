import 'package:flutter/material.dart';

import '../widgets/reservation_header.dart';
import '../widgets/reservation_date_time.dart';
import '../widgets/reservation_guest_counter.dart';
import '../widgets/reservation_dropdown_field.dart';
import '../widgets/reservation_contact_form.dart';

import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../bloc/new_reservation_bloc.dart';

class NewReservationScreen extends StatefulWidget {
  const NewReservationScreen({super.key});

  @override
  State<NewReservationScreen> createState() => _NewReservationScreenState();
}

class _NewReservationScreenState extends State<NewReservationScreen> {
  // Estado para la barra de navegación inferior
  int _selectedIndex = 2; // Asumimos 'Reservas'

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Navegar al inicio (probablemente 2 pop)
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      // Navegar a Evento
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryPurple = Color(0xFF6A1B9A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nueva Reserva'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      
      // --- INICIO DE MODIFICACIONES ---
      // 1. Envolvemos el body en un BlocConsumer
      body: BlocConsumer<NewReservationBloc, NewReservationState>(
        
        // 2. El 'listener' es para acciones (diálogos, popups, navegación)
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            // Éxito: Muestra un diálogo y luego cierra la pantalla
            showDialog(
              context: context,
              barrierDismissible: false, // No se puede cerrar tocando fuera
              builder: (_) => AlertDialog(
                title: const Text('¡Éxito!'),
                content: const Text('Tu reserva ha sido confirmada.'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo
                      Navigator.of(context).pop(); // Cierra la pantalla de reserva
                    },
                  ),
                ],
              ),
            );
          } else if (state.status == FormStatus.failure) {
            // Falla: Muestra un diálogo de error
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMessage ?? 'Ocurrió un error.'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo
                  ),
                ],
              ),
            );
          }
        },
        
        // 3. El 'builder' es para construir la UI que cambia con el estado
        builder: (context, state) {
          // 4. Usamos un Stack para poner un overlay de carga
          return Stack(
            children: [
              // Tu formulario original va aquí
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Ensamblamos nuestros componentes ---
                      const ReservationHeader(),
                      const Divider(height: 32, thickness: 1),
                      
                      const ReservationDateTime(),
                      const SizedBox(height: 20),
                      
                      const ReservationGuestCounter(),
                      const SizedBox(height: 20),
                      
                      // Dropdown 1
                      const ReservationDropdownField(
                        label: 'Preferencias de Mesa',
                        hint: 'Seleccionar preferencia de mesa',
                        items: ['Junto a la ventana', 'Terraza', 'Interior'],
                      ),
                      const SizedBox(height: 20),
                      
                      // Dropdown 2
                      const ReservationDropdownField(
                        label: 'Ocasión Especial',
                        hint: 'Seleccionar ocasión',
                        items: ['Cumpleaños', 'Aniversario', 'Negocios'],
                      ),
                      const SizedBox(height: 20),
                      
                      // TODO: Añadir widget de solicitudes especiales
                      
                      const ReservationContactForm(),
                      const SizedBox(height: 32),
                      
                      // --- 5. Botón de confirmar MODIFICADO ---
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (state.status == FormStatus.loading)
                              ? null // Deshabilita el botón si está cargando
                              : () {
                                  // Envía el evento de 'submit' al BLoC
                                  context
                                      .read<NewReservationBloc>()
                                      .add(FormSubmitted());
                                },
                          child: (state.status == FormStatus.loading)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3, // Más pequeño
                                )
                              : const Text('Confirmar Reserva'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 6. El Overlay de Carga
              // Se muestra solo si el estado es 'loading'
              if (state.status == FormStatus.loading)
                Container(
                  color: Colors.black.withOpacity(0.5), // Fondo semitransparente
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
      // --- FIN DE MODIFICACIONES ---

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Evento'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Reservas'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Comunidad'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}