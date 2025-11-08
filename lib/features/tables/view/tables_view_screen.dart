import 'package:flutter/material.dart';
import 'package:glottia_app/features/reservations/view/new_reservation_screen.dart';

// Importamos todos nuestros nuevos componentes
import '../widgets/table_summary_cards.dart';
import '../widgets/table_zoom_controls.dart';
import '../widgets/table_map_grid.dart';
import '../widgets/table_legend.dart';
import '../widgets/table_action_buttons.dart';

// Importamos bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Importamos el nuevo BLoC Y la pantalla
import '../../reservations/bloc/new_reservation_bloc.dart';

class TablesViewScreen extends StatefulWidget {
  const TablesViewScreen({super.key});

  @override
  State<TablesViewScreen> createState() => _TablesViewScreenState();
}

class _TablesViewScreenState extends State<TablesViewScreen> {
  // Estado para la barra de navegación inferior
  int _selectedIndex = 0; // Asumimos 'Inicio'

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Si el índice es 0 (Inicio), volvemos al dashboard
    if (index == 0) {
      Navigator.pop(context); // Vuelve a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // El fondo de esta pantalla es blanco
      appBar: AppBar(
        title: const Text('Vista del Local'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableActionButtons(
                onNewReservationPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(create: (context) => NewReservationBloc(),
                      child: const NewReservationScreen(),
                      )
                    ));
                },
              ),
              const TableSummaryCards(),
              const SizedBox(height: 24),
              const TableZoomControls(),
              const SizedBox(height: 20),
              const TableMapGrid(),
              const SizedBox(height: 24),
              const TableLegend(),
              const SizedBox(height: 24),
              const TableActionButtons(),
            ],
          ),
        ),
      ),
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
        selectedItemColor: const Color(0xFF6A1B9A), // kPrimaryPurple
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}