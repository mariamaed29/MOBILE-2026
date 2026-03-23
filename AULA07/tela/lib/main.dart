import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaInicial(),
    );
  }
}

//------------------TELA1------------------
class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Ir para a Segunda Tela'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SegundaTela()),
            );
          },
        ),
      ),
    );
  }
}

//------------------TELA2------------------

class SegundaTela extends StatelessWidget {
  const SegundaTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Voltar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}