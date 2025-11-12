class RestaurantStats {
  final double ganancias;
  final double gananciasPorcentaje;
  final int disponibilidad;
  final double rating;
  final int pedidos;
  final int promociones;

  const RestaurantStats({
    required this.ganancias,
    required this.gananciasPorcentaje,
    required this.disponibilidad,
    required this.rating,
    required this.pedidos,
    required this.promociones,
  });
}

// Datos estáticos de ejemplo
const RestaurantStats defaultStats = RestaurantStats(
  ganancias: 2450.0,
  gananciasPorcentaje: 12.5,
  disponibilidad: 89,
  rating: 4.8,
  pedidos: 156,
  promociones: 8,
);
