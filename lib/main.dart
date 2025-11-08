import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glottia_app/features/dashboard/view/dashboard_screen.dart';
import 'bloc/dashboard_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider (
      create: (context) => DashboardBloc()
        ..add(DashboardDataRequested()), // Despacha el evento inicial
      
      // 3. El HIJO del provider es el MaterialApp
      child: MaterialApp(
        title: 'Glottia App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        // 4. Ahora, DashboardScreen es un descendiente del BlocProvider
        //    y podrá encontrar el BLoC sin problemas.
        home: const DashboardScreen(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}