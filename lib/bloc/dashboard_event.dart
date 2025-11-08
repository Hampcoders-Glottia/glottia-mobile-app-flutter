part of 'dashboard_bloc.dart'; 

// Clase base abstracta para todos los eventos
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

// ====== EVENTOS ======

// Evento que la UI disparará para solicitar los datos del dashboard
class DashboardDataRequested extends DashboardEvent {}

// Evento cuando se presiona "Crear Evento"
class CreateEventPressed extends DashboardEvent {}

// Evento cuando se presiona "Promocionar"
class PromotePressed extends DashboardEvent {}

// Evento para "limpiar" la señal de navegación después de que la hayamos usado
class NavigationHandled extends DashboardEvent {}