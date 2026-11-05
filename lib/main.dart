import 'package:agenda/src/view/Contactos_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda/src/provider/contactos_provider.dart';
import 'package:agenda/src/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    // Crea el Provider y lo pone a disposición de los widgets que están debajo de él en el árbol de la aplicación.
    ChangeNotifierProvider(
      create: (context) => ContactosProvider()..cargarContactos(),

      // Nuestra aplicación podrá consultar este Provider desde el login y desde las pantallas de contactos.
      child: Agenda(isLoggedIn: isLoggedIn),
    ),
  );
}

class Agenda extends StatelessWidget {
  final bool isLoggedIn;
  const Agenda({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Definimos los colores para toda la aplicación.
      theme: ThemeData(
        // Genera una combinación de colores a partir del verde.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),

        // Fondo blanco para las pantallas.
        scaffoldBackgroundColor: Colors.white,

        // Barras superiores
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),

        // Botón de inicio de sesión
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),

        // Botón flotante de agregar contacto.
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),

      home: isLoggedIn ? const ContactosScreen() : const Login(),
    );
  }
}
