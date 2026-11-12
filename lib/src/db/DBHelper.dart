import 'package:agenda/src/model/Contacto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'agenda.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contactos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            apellido TEXT,
            telefono TEXT,
            email TEXT,
            direccion TEXT,
            fechaNacimiento TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertarContacto(Contacto contacto) async {
    final database = await db;
    return await database.insert('contactos', contacto.toMap());
  }

  static Future<List<Contacto>> obtenerContactos() async {
    final database = await db;
    final res = await database.query('contactos');
    return res.map((c) => Contacto.fromMap(c)).toList();
  }

  static Future<int> actualizarContacto(Contacto contacto) async {
    final database = await db;
    return await database.update(
      'contactos',
      contacto.toMap(),
      where: 'id = ?',
      whereArgs: [contacto.id],
    );
  }

  static Future<int> eliminarContacto(int id) async {
    final database = await db;
    return await database.delete('contactos', where: 'id = ?', whereArgs: [id]);
  }
}
