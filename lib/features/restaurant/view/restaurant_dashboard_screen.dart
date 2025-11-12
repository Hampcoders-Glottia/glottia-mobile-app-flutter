import 'package:flutter/material.dart';
import 'package:glottia_app/features/restaurant/models/restaurant_stats.dart';
import 'package:glottia_app/features/restaurant/widgets/restaurant_header.dart';
import 'package:glottia_app/features/restaurant/widgets/earnings_card.dart';
import 'package:glottia_app/features/restaurant/widgets/availability_card.dart';
import 'package:glottia_app/features/restaurant/widgets/stat_card.dart';
import 'package:glottia_app/features/restaurant/widgets/time_period_filter.dart';
import 'package:glottia_app/features/restaurant/widgets/earnings_chart.dart';
import 'package:glottia_app/features/restaurant/view/promotions_list_screen.dart';

class RestaurantDashboardScreen extends StatefulWidget {
  const RestaurantDashboardScreen({super.key});

  @override
  State<RestaurantDashboardScreen> createState() => _RestaurantDashboardScreenState();
}

class _RestaurantDashboardScreenState extends State<RestaurantDashboardScreen> {
  TimePeriod _selectedPeriod = TimePeriod.day;
  
  // Datos estáticos
  final RestaurantStats stats = defaultStats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RestaurantHeader(
                restaurantName: 'Mi Restaurante',
              ),
            ),

            // Contenido scrolleable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    // Tarjetas principales (Ganancias y Disponibilidad)
                    Row(
                      children: [
                        Expanded(
                          child: EarningsCard(
                            amount: stats.ganancias,
                            percentage: stats.gananciasPorcentaje,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AvailabilityCard(
                            percentage: stats.disponibilidad,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Tarjetas pequeñas de estadísticas
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: Icons.star,
                            value: stats.rating.toString(),
                            label: 'Disponibilidad',
                            iconColor: const Color(0xFFFFB74D),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.shopping_bag,
                            value: stats.pedidos.toString(),
                            label: 'Pedidos',
                            iconColor: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.local_offer,
                            value: stats.promociones.toString(),
                            label: 'Promociones',
                            iconColor: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Filtros de tiempo
                    TimePeriodFilter(
                      selectedPeriod: _selectedPeriod,
                      onChanged: (period) {
                        setState(() {
                          _selectedPeriod = period;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // Gráfica de ganancias
                    EarningsChart(
                      totalAmount: 8450,
                      percentage: 15.2,
                    ),

                    const SizedBox(height: 20),

                    // Botón de actualizar
                    ElevatedButton.icon(
                      onPressed: () {
                        // Acción de actualizar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Actualizando datos...')),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Actualizar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B5FFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 100), // Espacio para el bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF7B5FFF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItem(
                  icon: Icons.home,
                  label: 'Inicio',
                  isSelected: true,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.local_offer,
                  label: 'Promociones',
                  isSelected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PromotionsListScreen(),
                      ),
                    );
                  },
                ),
                _BottomNavItem(
                  icon: Icons.restaurant_menu,
                  label: 'Menú',
                  isSelected: false,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.access_time,
                  label: 'Horario',
                  isSelected: false,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.person,
                  label: 'Perfil',
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
