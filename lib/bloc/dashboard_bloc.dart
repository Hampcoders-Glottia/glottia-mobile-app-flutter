import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Estas directivas 'part' unen los archivos que creamos
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  
  // 1. El BLoC empieza en el estado 'DashboardInitial'
  DashboardBloc() : super(DashboardInitial()) {
    
    // 2. Registramos un "manejador" para el evento 'DashboardDataRequested'
    on<DashboardDataRequested>(_onDataRequested);
    on<CreateEventPressed>(_onCreateEventPressed);
    on<PromotePressed>(_onPromotePressed);
    on<NavigationHandled>(_onNavigationHandled);
  }

  // 3. Esta función se ejecuta cuando llega un evento 'DashboardDataRequested'
  Future<void> _onDataRequested(
    DashboardDataRequested event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(DashboardLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(const DashboardLoaded(
        userName: 'Jose Hernandez',
        userSubtitle: 'Aprendiz de Ingles',
        activeEvents: '24',
        newClients: '156',
        navigateTo: null, // Asegúrate de que el estado inicial no navegue
      ));
      
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  // Manejador para el botón "Crear Evento"
  void _onCreateEventPressed(
    CreateEventPressed event,
    Emitter<DashboardState> emit,
  ) {
    final currentState = state;
    // Solo podemos hacer esto si ya estamos en el estado 'Loaded'
    if (currentState is DashboardLoaded) {
      // Emitimos una COPIA del estado actual, pero cambiando 'navigateTo'
      emit(currentState.copyWith(navigateTo: 'create_event'));
    }
  }

  // Manejador para el botón "Promocionar"
  void _onPromotePressed(
    PromotePressed event,
    Emitter<DashboardState> emit,
  ) {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      emit(currentState.copyWith(navigateTo: 'promote'));
    }
  }

  // Manejador para "limpiar" la navegación
  void _onNavigationHandled(
    NavigationHandled event,
    Emitter<DashboardState> emit,
  ) {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      // Emitimos una copia del estado, pero forzando 'navigateTo' a ser null
      emit(currentState.copyWith(clearNavigation: true));
    }
  }
}