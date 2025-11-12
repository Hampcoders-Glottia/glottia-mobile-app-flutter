import 'package:flutter/material.dart';
import 'package:glottia_app/features/restaurant/models/promotion.dart';
import 'package:glottia_app/features/restaurant/widgets/promotion_detail_card.dart';

class PromotionsDetailScreen extends StatelessWidget {
  const PromotionsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activePromotions = promotionsData.where((p) => p.activa).toList();
    final totalReservas = promotionsData.fold<int>(0, (sum, p) => sum + p.vistas);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mis Promociones',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjetas de estadísticas
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    number: '${activePromotions.length}',
                    label: 'Promociones\nActiva',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    number: '$totalReservas',
                    label: 'Reservas\neste mes',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Botón crear nueva promoción
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Crear nueva promoción')),
                );
              },
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                'Crear Nueva Promoción',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B5FFF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Header con filtro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Promociones Activas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'filtrar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.filter_list,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de promociones detalladas
            ...promotionsData.map(
              (promo) => PromotionDetailCard(
                promotion: promo,
                onEdit: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Editar: ${promo.nombre}')),
                  );
                },
              ),
            ),

            const SizedBox(height: 100), // Espacio para bottom nav
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
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
                isSelected: false,
                onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
              _BottomNavItem(
                icon: Icons.local_offer,
                label: 'Promociones',
                isSelected: true,
                onTap: () {},
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
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number;
  final String label;

  const _StatCard({
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
