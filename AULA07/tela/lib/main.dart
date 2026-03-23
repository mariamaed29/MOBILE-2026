// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TelaInicial()
//   ));
// }

// //-------------- TELA 1 --------------

// class TelaInicial extends StatelessWidget {
//   final String nome = "Maria";

//   @override
//   Widget build(BuildContext context){
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Tela Inicial"),
//        backgroundColor: const Color.fromARGB(255, 243, 33, 243),
//     ),
//     body: Center(
//       child: ElevatedButton(
//           child: Text ("Ir para a Segunda Tela"),
//           onPressed: (){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => SegundaTela(nome: nome)),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// //-------------- TELA 2 --------------

// class SegundaTela extends StatelessWidget {
//   final String nome;

//   SegundaTela({required this.nome});
  
//   @override
//   Widget build(BuildContext context){
//    return Scaffold(
//     appBar: AppBar(
//       title: Text("Segunda Tela"),
//       backgroundColor: const Color.fromARGB(255, 236, 109, 230),
//     ),
//     body:Center(
//         child:Text("Olá, $nome!", style:TextStyle(fontSize: 20)),
//       ),
//     );
//   }
// }

//-------------- Exercício --------------

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaContatos(),
  ));
}

//---------------- TELA 1: LISTA ----------------

class ListaContatos extends StatelessWidget {
  final List contatos = [
    {"nome": "Brenda", "telefone": "99999-1111", "cor": Colors.pink},
    {"nome": "Carlos", "telefone": "98888-2222", "cor": Colors.blue},
    {"nome": "Ana", "telefone": "97777-3333", "cor": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          var contato = contatos[index];

          return ListTile(
            leading: Icon(Icons.person, color: contato["cor"]),
            title: Text(contato["nome"]),
            subtitle: Text(contato["telefone"]),
            tileColor: contato["cor"].withOpacity(0.1),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheContato(
                    nome: contato["nome"],
                    telefone: contato["telefone"],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

//---------------- TELA 2: DETALHES ----------------

class DetalheContato extends StatelessWidget {
  final String nome;
  final String telefone;

  DetalheContato({required this.nome, required this.telefone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.purple),
            SizedBox(height: 20),

            Text(
              nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              telefone,
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Ligando para $nome...")),
                );
              },
              icon: Icon(Icons.call),
              label: Text("Ligar"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Voltar"),
            )
          ],
        ),
      ),
    );
  }
}