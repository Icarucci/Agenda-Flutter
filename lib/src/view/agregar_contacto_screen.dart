import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agenda/src/model/contacto.dart';
import 'package:agenda/src/provider/contactos_provider.dart';

// Necesita estado porque la fecha seleccionada puede cambiar.
class AgregarContactoScreen extends StatefulWidget {
  final Contacto? contacto;

  const AgregarContactoScreen({super.key, this.contacto});

  @override
  State<AgregarContactoScreen> createState() => _AgregarContactoScreenState();
}

class _AgregarContactoScreenState extends State<AgregarContactoScreen> {
  // Permite validar todos los campos del formulario.
  final _formKey = GlobalKey<FormState>();

  // Permiten leer lo que el usuario escribe en cada campo.
  var _nombreController = TextEditingController();
  var _apellidoController = TextEditingController();
  var _telefonoController = TextEditingController();
  var _emailController = TextEditingController();
  var _direccionController = TextEditingController();

  DateTime? _fechaNacimiento;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.contacto?.nombre ?? '',
    );
    _apellidoController = TextEditingController(
      text: widget.contacto?.apellido ?? '',
    );
    _telefonoController = TextEditingController(
      text: widget.contacto?.telefono ?? '',
    );
    _emailController = TextEditingController(
      text: widget.contacto?.email ?? '',
    );
    _direccionController = TextEditingController(
      text: widget.contacto?.direccion ?? '',
    );
    _fechaNacimiento = widget.contacto?.fechaNacimiento;
  }

  // Comprueba que el campo no esté vacío.
  String? _validarCampo(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Completá este campo';
    }
    return null;
  }

  // Abre el calendario y espera la elección del usuario, por eso hasta no elegir la fecha, no continua
  Future<void> _seleccionarFecha() async {
    final fechaElegida = await showDatePicker(
      context: context,

      // Si ya hay una fecha, abre el calendario en esa fecha.
      // Si no hay ninguna, utiliza la fecha actual.
      initialDate: _fechaNacimiento ?? DateTime.now(),

      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // No permite fechas futuras.
    );

    // Comprueba que esta pantalla siga abierta después de esperar.
    if (!mounted) return;

    // Si canceló el calendario, fechaElegida será null.
    if (fechaElegida != null) {
      setState(() {
        _fechaNacimiento = fechaElegida;
      });
    }
  }

  void _guardarContacto() {
    // Si algún campo está vacío, muestra sus errores y no guarda.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Crea un contacto con los datos ingresados.
    // trim() sirve para eliminar los espacios al principio y al final.
    final nuevoContacto = Contacto(
      nombre: _nombreController.text.trim(),
      apellido: _apellidoController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      direccion: _direccionController.text.trim(),
      fechaNacimiento: _fechaNacimiento,
    );

    // Agrega el contacto a la lista administrada por Provider.
    final provider = context.read<ContactosProvider>();

    if (widget.contacto == null) {
      provider.agregarContacto(nuevoContacto);
    } else {
      provider.actualizarContacto(nuevoContacto);
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Libera los controladores cuando se elimina la pantalla.
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contacto == null ? 'Agregar contacto' : 'Editar contacto',
        ),
        actions: [
          IconButton(
            onPressed: _guardarContacto,
            icon: const Icon(Icons.check),
            tooltip: 'Guardar contacto',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _validarCampo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: _validarCampo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: _validarCampo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                ),
                validator: _validarCampo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: _validarCampo,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _seleccionarFecha,
                child: Text(
                  _fechaNacimiento == null
                      ? 'Seleccionar fecha de nacimiento'
                      : 'Nacimiento: ${_fechaNacimiento!.day}/'
                            '${_fechaNacimiento!.month}/'
                            '${_fechaNacimiento!.year}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
