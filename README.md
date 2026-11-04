# Agenda

## Proyecto en Flutter para TUDAI Mobile 2

Proyecto realizado en conjunto entre Carucci, Ignacio y Roselli, Omar

## Actividad Obligatoria 1

### Actividad 1: 

Desarrolla una interfaz visual de inicio de, que permita al
usuario ingresar sus credenciales (nombre de usuario y contraseña)
*** Se utilizan credenciales hardcodeadas para ingresar a la app: usuario@ejemplo.com // 123456 ***
mediante campos de texto y un botón para validar la información
proporcionada. Cuando el usuario presione el botón de validación, se
verificarán los datos ingresados.
Si son correctos, la aplicación navegará a la pantalla de contactos.

### Actividad 2: 

Desarrolla una interfaz visual que muestre una lista de
todos los contactos existentes.
La barra de aplicación (AppBar) contendrá un título descriptivo y
botones de acciones.
Además, incluir un botón de acción flotante (FloatingActionButton)
para navegar a la pantalla de creación de nuevos contactos.

### Actividad 3: 

Desarrolla una interfaz visual, para la creación de un
nuevo contacto.
Los atributos del contacto incluirán los campos típicos como
nombre, teléfono, correo electrónico, dirección, y fecha de
nacimiento, como se muestra en la imagen adjunta.
En la barra de aplicación (AppBar), se incluirá un título descriptivo y
un ícono que permitirá guardar y volver atrás una vez que se haya
agregado el contacto.
Utilizar provider para persistir los datos mientras la aplicación esta
corriendo

### Actividad 4: 

Desarrolla una interfaz visual donde se pueda
listar los contactos agregados y mostrar datos relevantes
(Nombre, apellido, teléfono, icon etc.)

### Actividad 5: 

Dar funcionalidad botón buscar de la barra de acciones, al hacer clic debe
mostrar un campo de texto, en el cual a medida que escriba debe aplicar filtro en la lista de
contactos

## Actividad Obligatoria 2

### Actividad 1: 

Al iniciar la aplicación se debe validar si hubo
anteriormente una autenticación correcta, si esta situación es
cierta, no debe solicitar credenciales (Usuario/Password) e
ingresara a la lista de contactos.
Para ello cuando se validen las credenciales y sean correctas se
debe registrar un elemento Clave/Valor en las SharedPreferences
que luego utilizaremos para verificar la autenticación. 

### Actividad 2:

Agregar al menú un ítem (texto o icono) “Cerrar
sesión”, el cual modificara el valor de la clave de autenticación
correcta en las SharedPreferences.

### Actividad 3:

Implementar las funcionalidades de Alta, baja,
Modificación y Listado de la entidad que corresponda,
Utilizar SQLite para almacenar la información. 