import 'package:agenda/src/view/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda/src/provider/contactos_provider.dart';
import 'package:agenda/src/view/agregar_contacto_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Esta pantalla necesita estado para mostrar u ocultar la búsqueda y guardar el texto que escribe el usuario.
class ContactosScreen extends StatefulWidget {
  const ContactosScreen({super.key});

  @override
  State<ContactosScreen> createState() => _ContactosScreenState();
}

class _ContactosScreenState extends State<ContactosScreen> {
  bool _buscando = false;
  String _textoBusqueda = '';

  // Actividad 2: Modifica la clave en SharedPreferences y vuelve al Login
  Future<void> _cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el Provider y escucha sus cambios.
    // Cuando se ejecute notifyListeners(), este widget se reconstruirá para mostrar los datos actualizados.
    final contactosProvider = context.watch<ContactosProvider>();

    // Consulta la lista de contactos del Provider por nombre y apellido.
    // Convertimos ambos textos a minúsculas para que la búsqueda no distinga entre mayúsculas y minúsculas.
    final contactos = contactosProvider.contactos.where((contacto) {
      return contacto.nombreCompleto.toLowerCase().contains(
        _textoBusqueda.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        // Si estamos buscando, muestra un campo de texto sino, muestra el título.
        title: _buscando
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar contacto...',
                  border: InputBorder.none,
                ),

                // Se ejecuta cada vez que el usuario cambia el texto.
                onChanged: (texto) {
                  setState(() {
                    _textoBusqueda = texto;
                  });
                },
              )
            : const Text('Contactos'),
        actions: [
          IconButton(
            icon: Icon(_buscando ? Icons.close : Icons.search),
            tooltip: _buscando ? 'Cerrar búsqueda' : 'Buscar',
            onPressed: () {
              setState(() {
                _buscando = !_buscando;
                // Limpia el filtro al cerrar la búsqueda.
                _textoBusqueda = '';
              });
            },
          ),
          // Actividad 2: Ítem del menú "Cerrar sesión"
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _cerrarSesion,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarContactoScreen(),
            ),
          );
        },
        tooltip: 'Agregar contacto',
        child: const Icon(Icons.add),
      ),
      body: contactos.isEmpty
          ? Center(
              child: Text(
                contactosProvider.contactos.isEmpty
                    ? 'No hay contactos disponibles'
                    : 'No se encontraron contactos',
              ),
            )
          : ListView.builder(
              itemCount: contactos.length,
              itemBuilder: (context, index) {
                final contacto = contactos[index];

                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(contacto.nombreCompleto),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teléfono: ${contacto.telefono}'),
                      Text('Email: ${contacto.email}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Actividad 3: Modificación
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AgregarContactoScreen(contacto: contacto),
                            ),
                          );
                        },
                      ),
                      // Actividad 3: Baja
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          if (contacto.id != null) {
                            contactosProvider.eliminarContacto(contacto.id!);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
