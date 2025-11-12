import 'package:flutter/material.dart';

class EarningsChart extends StatelessWidget {
  final double totalAmount;
  final double percentage;

  const EarningsChart({
    super.key,
    required this.totalAmount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = percentage >= 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ganancias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$ ${totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPositive 
                          ? Colors.green.shade50 
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Placeholder para el gráfico
          // Aquí pueden integrar su propia librería de gráficos
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Stack(
              children: [
                // Líneas de guía horizontales
                Positioned(
                  left: 0,
                  right: 0,
                  top: 20,
                  child: _buildGridLine('3k'),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 80,
                  child: _buildGridLine('2k'),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 140,
                  child: _buildGridLine('1k'),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: _buildGridLine('0'),
                ),
                
                // Labels de días
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDayLabel('Lun'),
                      _buildDayLabel('Mar'),
                      _buildDayLabel('Mie'),
                      _buildDayLabel('Jue'),
                      _buildDayLabel('Vie'),
                      _buildDayLabel('Sab'),
                      _buildDayLabel('Dom'),
                    ],
                  ),
                ),
                
                // Mensaje de placeholder
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF7B5FFF)),
                    ),
                    child: const Text(
                      '📊 Integrar gráfica aquí',
                      style: TextStyle(
                        color: Color(0xFF7B5FFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridLine(String label) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildDayLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
