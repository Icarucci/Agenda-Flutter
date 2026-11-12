import 'package:agenda/src/db/DBHelper.dart';
import 'package:agenda/src/model/Contacto.dart';
import 'package:flutter/foundation.dart';

class ContactosProvider extends ChangeNotifier {
  List<Contacto> _contactos = [];

  List<Contacto> get contactos => List.unmodifiable(_contactos);

  // Cargar contactos desde la base de datos SQLite
  Future<void> cargarContactos() async {
    _contactos = await DBHelper.obtenerContactos();
    notifyListeners();
  }

  Future<void> agregarContacto(Contacto contacto) async {
    await DBHelper.insertarContacto(contacto);
    await cargarContactos();
  }

  Future<void> actualizarContacto(Contacto contacto) async {
    await DBHelper.actualizarContacto(contacto);
    await cargarContactos();
  }

  Future<void> eliminarContacto(int id) async {
    await DBHelper.eliminarContacto(id);
    await cargarContactos();
  }
}
