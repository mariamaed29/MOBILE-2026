import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class Item {
  int? id;
  String titulo;
  String descricao;

  Item({this.id, required this.titulo, required this.descricao});

  Map<String, dynamic> toMap() {
    return {'titulo': titulo, 'descricao': descricao};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int?,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }
}

class DatabaseHelper {
  //instance → garante que só existe um banco aberto no app
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  //_initDB() → encontra a pasta certa no celular e abre o banco
 Future<Database> _initDB() async {
  final dbPath = await getDatabasesPath();

  final dbFilePath = path.join(dbPath, 'dasdos.db');

  return await openDatabase(dbFilePath, version: 1, onCreate: _createDB);
}

  //_createDB() → cria a tabela dados (só na primeira vez)
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dados (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT
      )
    ''');
  }

  //INSERT - INSERIR
  Future<int> insert(Item item) async {
    final db = await database;
    return await db.insert('dados', item.toMap());
  }

  //SELECT - BUSCAR
  Future<List<Item>> getAll() async {
    final db = await database;
    final maps = await db.query('dados', orderBy: 'titulo ASC');
    return maps.map((map) => Item.fromMap(map)).toList();
  }

  //UPDATE - EDITAR
  Future<int> update(Item item) async {
    final db = await database;
    return await db.update(
      'dados',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  //DELETE -  EXCLUIR
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('dados', where: 'id = ?', whereArgs: [id]);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await DatabaseHelper.instance.getAll();
    setState(() {
      _items = items;
    });
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.delete(id);
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Inteligente')),
      body: _items.isEmpty
          ? const Center(child: Text('Nenhum item cadastrado'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.titulo),
                  subtitle: Text(item.descricao),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormScreen(item: item)),
                    );
                    _loadItems();
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                    if (item.id != null) {
                    _deleteItem(item.id!);
                    }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormScreen()),
          );
          _loadItems();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  final Item? item;
  const FormScreen({super.key, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _tituloController.text = widget.item!.titulo;
      _descricaoController.text = widget.item!.descricao;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    final titulo = _tituloController.text;
    final descricao = _descricaoController.text;

    if (widget.item == null) {
      await DatabaseHelper.instance.insert(
        Item(titulo: titulo, descricao: descricao),
      );
    } else {
      await DatabaseHelper.instance.update(
        Item(id: widget.item!.id, titulo: titulo, descricao: descricao),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Novo Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Inteligente',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}