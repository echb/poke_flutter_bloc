# Answers

1. Flutter en un framework de Dart, entre sus principales ventajas es que permite un desarrollo multiplataforma siendo Android e Ios las principales plataformas objetivo que se suelen desarrollar, sin embargo, también permite desarrollar para Linux, Windows, Web y MacOs y es un lenguaje rápido de aprender, pues su sintaxis se basó en Java y Javascript. Un gran exponente de su uso es Google pay.

2. Son bloques de código reutilizable y **"composable"** para la construcción de Ui, usualmente y por estandar se usan con clases aunque tambien llegan a usarse con funciones. Suelen extenderese (heredar) de una clase **`StatefulWidget`** o **`StatelessWidget`**.

3. Los **`StatefulWidget`** suelen mantener un estado y ser dinámicos y cambiar con el uso de `setState`, mientras que los **`StatelessWidget`** son estáticos, es decir, no cambian, solo se construye al momento de inicializarse.

4. - createState: Crea el estado del widget.
   - initState: Se llama cuando el widget se crea por primera vez y se agrega al widget tree.
   - didChangeDependencies: Este método se llama cuando una dependencia del widget cambia.
   - build: Construye la interfaz basada en el estado actual. Se llama cuando el widget se crea por primera vez y puede volver a construirse cuando sea necesario.
   - setState: Dispara un evento que vuelve a construir el widget cuando el estado cambia.
   - didUpdateWidget: Se dispara cuando el widget se reconstruye.
   - deactivate: Se llama cuando el widget es removido del árbol de widgets.
   - dispose: Se llama cuando el widget es removido del widget tree por completo, liberando recursos del dispositivo.
   - reassemble: Se llama cuando la aplicación se recarga (hot reload) durante el desarrollo(debugging).

Se pueden usar sobreescribiendo los métodos.

5. - Futures, es un objeto con una posible respuesta en el futuro y con un valor o error; suele ser muy utilizado en peticiones HTTP.

   - Stream, son un flujo de datos asíncrono; los manejadores de estado Cubit y Bloc se basan en streams.

6. Con `Navigator`

# Run the project

### Prerequisites

Before you begin, ensure you have the following dependencies and tools installed:

- flutter
- dart
- xcode (ios)
- android studio (android)
- vscode

  - flutter extension

- If you face **_problems_** with dart/flutter version take a look at [fvm](https://fvm.app/)

### Clone the Repository

1. Open your terminal.

2. Use the following command to clone the repository:

`git clone https://github.com/echb/poke_flutter_bloc.git`

### Configuration

1. Change your working directory to the cloned repository:

`cd poke_flutter_bloc`

2. Install the required dependencies using:

`flutter pub get`

### Run

1. Connect your device or start an emulator.

2. To run the app use one of the following commands:
   - Vscode debug mode `fn + F5`
   - Terminal command `flutter run` and select possible device
   - If the images does not load on web use the command `flutter run -d chrome --web-renderer html`
