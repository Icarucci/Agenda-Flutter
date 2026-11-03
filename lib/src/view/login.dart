import 'package:agenda/src/view/contactos_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /* Esta es la clave global para validar el formulario*/
  final _formKey = GlobalKey<FormState>();
  /* Estos son los controladores que leen el campo de texto email y pass */
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /* Credenciales hardcodeadas para ejemplo */
  static const String _validEmail = "usuario@ejemplo.com";
  static const String _validPassword = "123456";

  /* Ocultar la contraseña */
  bool _isPasswordHidden = true;

  /* LOGICA DE INICIO DE SESION */
  Future<void> _inicioSesion() async {
    /** Se validan las credenciales del form */
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final pass = _passwordController.text;

      /* Comprobacion de los datos */
      if (email == _validEmail && pass == _validPassword) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (!mounted) return;

        /* LOGIN CORRECTO -> Navegar a pantalla de contactos */
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inicio de sesión exitoso'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ContactosScreen()),
        );
      } else {
        /** LOGIN INCORRECTO -> Mostrar mensaje de error */
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo electrónico o contraseña incorrectos'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agenda de contactos")),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(40.0),
        /** FORMULARIO DE LOGIN **/
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono que identifica la aplicación.
              const Icon(Icons.contact_page, size: 70, color: Colors.green),
              const SizedBox(height: 12),

              // Nombre de la app debajo del ícono.
              const Text(
                'Mi Agenda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              /** CAMPO DE TEXTO PARA EL CORREO ELECTRÓNICO **/
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              /** CAMPO DE TEXTO PARA LA CONTRASEÑA **/
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              /** BOTÓN DE INICIAR SESIÓN **/
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ElevatedButton(
                  onPressed: _inicioSesion,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(35),
                    // Botón de ancho completo
                  ),
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
