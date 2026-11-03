import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda/src/provider/contactos_provider.dart';
import 'package:agenda/src/view/agregar_contacto_screen.dart';

// Esta pantalla necesita estado para mostrar u ocultar la búsqueda y guardar el texto que escribe el usuario.
class ContactosScreen extends StatefulWidget {
  const ContactosScreen({super.key});

  @override
  State<ContactosScreen> createState() => _ContactosScreenState();
}

class _ContactosScreenState extends State<ContactosScreen> {
  // Indica si el campo de búsqueda está visible.
  bool _buscando = false;

  // Guarda el texto utilizado para filtrar los contactos.
  String _textoBusqueda = '';

  @override
  Widget build(BuildContext context) {
    final contactosProvider = context.watch<ContactosProvider>();

    // Consulta la lista de contactos del Provider por nombre y apellido.
    // Convertimos ambos textos a minúsculas para que la búsqueda no distinga entre mayúsculas y minúsculas.
    final contactos = contactosProvider.contactos.where((contacto) {
      return contacto.nombreCompleto.toLowerCase().contains(
        _textoBusqueda.toLowerCase(),
      );
    }).toList();    // toList convierte el resultado en una lista.

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
            icon: Icon(
              _buscando ? Icons.close : Icons.search,
            ),
            tooltip: _buscando ? 'Cerrar búsqueda' : 'Buscar',
            onPressed: () {
              setState(() {
                // Alterna entre mostrar y ocultar el campo.
                _buscando = !_buscando;

                // Limpia el filtro al cerrar la búsqueda.
                _textoBusqueda = '';
              });
            },
          ),
        ],
      ),

      // Botón flotante para abrir la pantalla de creación de contactos.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Abre el formulario sobre la pantalla del listado.
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

      // Si la lista está vacía, muestra un mensaje.
      // Si tiene contactos, construye una lista desplazable.
      body: contactos.isEmpty
          ? Center(
            child: Text(contactosProvider.contactos.isEmpty
                  ? 'No hay contactos disponibles'
                  : 'No se encontraron contactos',
            ),
          )
          : ListView.builder(
              itemCount: contactos.length,
              itemBuilder: (context, index) {
                // Obtiene el contacto correspondiente a esta fila.
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
                );
              },
            ),
    );
  }
}