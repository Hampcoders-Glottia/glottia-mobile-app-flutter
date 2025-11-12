class Promotion {
  final String id;
  final String nombre;
  final int descuento;
  final String validoHasta;
  final int vistas;
  final bool activa;
  final String? horario;
  final String? imagenUrl;
  final PromotionColor color;

  const Promotion({
    required this.id,
    required this.nombre,
    required this.descuento,
    required this.validoHasta,
    required this.vistas,
    this.activa = true,
    this.horario,
    this.imagenUrl,
    this.color = PromotionColor.orange,
  });
}

enum PromotionColor {
  orange,
  purple,
  blue,
}

// Datos estáticos de ejemplo
final List<Promotion> promotionsData = [
  const Promotion(
    id: '1',
    nombre: '2×1 en Pizzas',
    descuento: 50,
    validoHasta: 'el 15 de Octubre',
    vistas: 234,
    activa: true,
    color: PromotionColor.orange,
    imagenUrl: 'assets/images/pizza.jpg',
  ),
  const Promotion(
    id: '2',
    nombre: 'Happy Hour',
    descuento: 30,
    validoHasta: '',
    vistas: 120,
    activa: true,
    horario: 'Lunes a Viernes 4 - 7 pm',
    color: PromotionColor.purple,
    imagenUrl: 'assets/images/drinks.jpg',
  ),
  const Promotion(
    id: '3',
    nombre: 'Happy Birthday',
    descuento: 35,
    validoHasta: '',
    vistas: 89,
    activa: true,
    horario: 'Todos los días, válido con dni',
    color: PromotionColor.blue,
  ),
];

class Recognition {
  final String title;
  final String subtitle;
  final int rating;

  const Recognition({
    required this.title,
    required this.subtitle,
    required this.rating,
  });
}

final List<Recognition> recognitionsData = [
  const Recognition(
    title: 'Local Destacado',
    subtitle: 'Uno de los mejores valorados',
    rating: 5,
  ),
  const Recognition(
    title: 'Mejor Servicio',
    subtitle: 'Centro Lima',
    rating: 5,
  ),
  const Recognition(
    title: 'Favorito',
    subtitle: '1500 Fans',
    rating: 5,
  ),
];
