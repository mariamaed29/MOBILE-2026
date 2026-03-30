import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaComprasApp(),
  ));
}

class ListaComprasApp extends StatefulWidget {
  @override
  _ListaComprasAppState createState() => _ListaComprasAppState();
}

class _ListaComprasAppState extends State<ListaComprasApp> {
  List<String> itens = [];
  List<bool> comprado = [];

  TextEditingController controller = TextEditingController();

  // ✅ ADICIONAR ITEM
  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        comprado.add(false);
        controller.clear();
      });
      salvarDados();
    }
  }

  // ✅ MARCAR / DESMARCAR
  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index];
    });
    salvarDados();
  }

  // ✅ REMOVER ITEM
  void removerItem(int index) {
    setState(() {
      itens.removeAt(index);
      comprado.removeAt(index);
    });
    salvarDados();
  }

  // ✅ SALVAR
  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList("itens", itens);

    prefs.setStringList(
      "comprado",
      comprado.map((e) => e.toString()).toList(),
    );
  }

  // ✅ CARREGAR
  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      itens = prefs.getStringList("itens") ?? [];

      List<String> listaBool =
          prefs.getStringList("comprado") ?? [];

      comprado = listaBool.map((e) => e == "true").toList();
    });
  }

  // ✅ INIT
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  // ✅ LIMPAR LISTA (EXTRA)
  void limparLista() {
    setState(() {
      itens.clear();
      comprado.clear();
    });
    salvarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: limparLista,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Digite um item",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: adicionarItem,
            child: Text("Adicionar"),
          ),
          Expanded(
            child: itens.isEmpty
                ? Center(child: Text("Lista vazia"))
                : ListView.builder(
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => alternarComprado(index),

                        title: Text(
                          itens[index],
                          style: TextStyle(
                            decoration: comprado[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),

                        leading: Icon(
                          comprado[index]
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removerItem(index),
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