import 'package:agenda/src/model/Contacto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contacto', () {
    test('genera el nombre completo y conserva los datos al convertirlo a mapa', () {
      final fechaNacimiento = DateTime(2000, 1, 15);

      final contacto = Contacto(
        id: 1,
        nombre: 'Juan',
        apellido: 'Perez',
        telefono: '1122334455',
        email: 'juan@ejemplo.com',
        direccion: 'CABA',
        fechaNacimiento: fechaNacimiento,
      );

      expect(contacto.nombreCompleto, 'Juan Perez');

      final datos = contacto.toMap();

      expect(datos['nombre'], 'Juan');
      expect(datos['apellido'], 'Perez');
      expect(datos['email'], 'juan@ejemplo.com');
      expect(datos['fechaNacimiento'], fechaNacimiento.toIso8601String());
    });
  });
}
