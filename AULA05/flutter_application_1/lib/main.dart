import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TodoPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //  PARTE 3 - PASSO 4: Criar a Lista
  // Esta variável fica aqui pois é o estado que o StatefulWidget precisa controlar.
  final List<String> _tarefas = [];

  //  PASSO 5: Criar o Controller
  // A classe TextEditingController é quem controla o texto digitado.
  final TextEditingController controller = TextEditingController();

  //  PARTE 5 - PASSO 6: Criar função para adicionar
  void adicionarTarefa() {
    // O setState avisa ao Flutter para redesenhar a interface com os novos dados.
    setState(() {
      if (controller.text.isNotEmpty) {
        _tarefas.add(controller.text);
      }
    });
    // Limpa o campo de texto após adicionar.
    controller.clear();
    // Teste de console solicitado no Passo 7.
    print(_tarefas);
  }

  //  PARTE 7 - PASSO 8: Criar função remover
  void removerTarefa(int index) {
    setState(() {
      // O método removeAt exclui o item da posição exata (index).
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        backgroundColor: Colors.blue,
      ),
      //  PARTE 4: Montando o Layout
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Digite uma tarefa...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //  PASSO 7: Conectar o Botão
          ElevatedButton(
            onPressed: adicionarTarefa, // Referência da função sem parênteses.
            child: const Text("Adicionar"),
          ),
          const SizedBox(height: 20),
          //  PARTE 6: Exibindo a Lista
          Expanded(
            child: ListView.builder(
              // .length informa quantas vezes o ListTile será repetido.
              itemCount: _tarefas.length,
              // O index representa a posição atual do item sendo desenhado.
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(_tarefas[index]),
                  //  PASSO 9: Adicionar botão de excluir
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removerTarefa(index), // Passa o índice para remoção.
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

