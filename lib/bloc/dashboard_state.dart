part of 'dashboard_bloc.dart'; 

// Clase base abstracta para todos los estados
abstract class DashboardState extends Equatable {
  const DashboardState();
  
  @override
  List<Object> get props => [];
}

// Estado inicial, cuando la app recién arranca
class DashboardInitial extends DashboardState {}

// Estado mientras se "cargan" los datos (aunque sean estáticos)
class DashboardLoading extends DashboardState {}

// Estado cuando los datos se han cargado exitosamente
class DashboardLoaded extends DashboardState {
  final String userName;
  final String userSubtitle;
  final String activeEvents;
  final String newClients;

  // 1. AÑADE ESTA NUEVA PROPIEDAD
  //    Será 'null' la mayor parte del tiempo.
  final String? navigateTo; 

  const DashboardLoaded({
    required this.userName,
    required this.userSubtitle,
    required this.activeEvents,
    required this.newClients,
    this.navigateTo, // 2. Añade al constructor
  });

  // 3. AÑADE UN MÉTODO 'copyWith'
  //    Esto nos permite emitir una copia del estado actual
  //    pero cambiando solo la propiedad que necesitamos.
  DashboardLoaded copyWith({
    String? userName,
    String? userSubtitle,
    String? activeEvents,
    String? newClients,
    String? navigateTo, // Importante
    bool clearNavigation = false, // Un truco para limpiar el 'navigateTo'
  }) {
    return DashboardLoaded(
      userName: userName ?? this.userName,
      userSubtitle: userSubtitle ?? this.userSubtitle,
      activeEvents: activeEvents ?? this.activeEvents,
      newClients: newClients ?? this.newClients,
      // Si clearNavigation es true, forza 'navigateTo' a ser null.
      // Si no, usa el 'navigateTo' que nos pasaron (que puede ser null o un valor).
      navigateTo: clearNavigation ? null : navigateTo ?? this.navigateTo,
    );
  }

  // 4. ACTUALIZA TUS PROPS
  @override
  List<Object> get props => [
        userName,
        userSubtitle,
        activeEvents,
        newClients,
        // Añade 'navigateTo' a los props para que Equatable lo compare.
        // Usamos '??' para darle un valor por defecto si es null.
        navigateTo ?? 'null' 
      ];
}

// Estado si algo sale mal
class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
