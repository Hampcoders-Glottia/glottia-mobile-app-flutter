import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/dashboard_bloc.dart'; 

// Importamos nuestros nuevos componentes
import '../widgets/dashboard_header.dart';
import '../widgets/summary_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/management_list.dart';
import '../widgets/recent_activity_list.dart';

// Colores
import '../../../theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() { _selectedIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoaded && state.navigateTo != null) {
            if (state.navigateTo == 'create_event') {
              _showSimpleDialog(context, '¡Acción!', 'Navegando a Crear Evento...');
            } else if (state.navigateTo == 'promote') {
              _showSimpleDialog(context, '¡Acción!', 'Navegando a Promocionar...');
            }
            // Inform the BLoC that we've handled navigation so it can clear the flag
            context.read<DashboardBloc>().add(NavigationHandled());
          }
        },
        builder: (context, state) {
          
          if (state is DashboardLoading || state is DashboardInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is DashboardLoaded) {
            // --- ¡Este es el poder de la composición! ---
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // 1. Header
                      DashboardHeader(
                        userName: state.userName,
                        userSubtitle: state.userSubtitle,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // 2. Tarjetas de Resumen
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              value: state.activeEvents,
                              label: 'Eventos Activos',
                              icon: Icons.calendar_today,
                              iconBgColor: Colors.blue.shade100,
                              iconColor: Colors.blue.shade800,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SummaryCard(
                              value: state.newClients,
                              label: 'Nuevos Clientes',
                              icon: Icons.group,
                              iconBgColor: Colors.green.shade100,
                              iconColor: Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // 3. Acciones Rápidas
                      const QuickActions(),
                      
                      const SizedBox(height: 20),
                      
                      // 4. Lista de Gestión
                      const ManagementList(),
                      
                      const SizedBox(height: 20),
                      
                      // 5. Lista de Actividad Reciente
                      const RecentActivityList(),
                    ],
                  ),
                ),
              ),
            );
          }
          
          return const Center(child: Text('Estado desconocido'));
        },
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
        selectedItemColor: kPrimaryPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _showSimpleDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}