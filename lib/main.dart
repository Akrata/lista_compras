import 'package:flutter/material.dart';
import 'package:lista_compras/providers/compras_provider.dart';
import 'package:lista_compras/screens/home_screen.dart';
import 'package:lista_compras/theme/appTheme.dart';
import 'package:provider/provider.dart';
import '';

void main() {
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ComprasProvider(),
        )
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: AppTheme.lightTheme,
    );
  }
}