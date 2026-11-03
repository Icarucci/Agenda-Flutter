class Contacto {
  final int? id;
  final String nombre;
  final String apellido;
  final String telefono;
  final String email;
  final String direccion;
  final DateTime? fechaNacimiento;

  Contacto({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.email,
    required this.direccion,
    this.fechaNacimiento,
  });

  String get nombreCompleto => '$nombre $apellido'.trim();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'email': email,
      'direccion': direccion,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
    };
  }

  factory Contacto.fromMap(Map<String, dynamic> map) {
    return Contacto(
      id: map['id'] as int?,
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      telefono: map['telefono'] ?? '',
      email: map['email'] ?? '',
      direccion: map['direccion'] ?? '',
      fechaNacimiento: map['fechaNacimiento'] != null
          ? DateTime.parse(map['fechaNacimiento'])
          : null,
    );
  }
}
