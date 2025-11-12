import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glottia_app/features/dashboard/view/dashboard_screen.dart';
import 'package:glottia_app/features/authentication/bloc/auth_bloc.dart';
import 'package:glottia_app/features/authentication/view/login_screen.dart';
import 'package:glottia_app/features/authentication/view/register_screen.dart';
import 'package:glottia_app/features/authentication/view/welcome_screen.dart';
import 'package:glottia_app/features/authentication/view/language_selection_screen.dart';
import 'package:glottia_app/features/authentication/view/user_type_selection_screen.dart';
import 'package:glottia_app/features/restaurant/view/restaurant_dashboard_screen.dart';
import 'package:glottia_app/features/restaurant/view/promotions_list_screen.dart';
import 'package:glottia_app/features/restaurant/view/promotions_detail_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bloc/dashboard_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc()..add(DashboardDataRequested()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Glottia App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'), // Español
          Locale('en'), // Inglés (opcional)
        ],
        locale: const Locale('es'), // Forzar español
        // Rutas: registrar pantallas de autenticación
        routes: {
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/user-type-selection': (context) => const UserTypeSelectionScreen(),
          '/language-selection': (context) => const LanguageSelectionScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/restaurant-dashboard': (context) => const RestaurantDashboardScreen(),
          '/promotions': (context) => const PromotionsListScreen(),
          '/promotions-detail': (context) => const PromotionsDetailScreen(),
        },
        // Pantalla inicial: Welcome
        home: const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}