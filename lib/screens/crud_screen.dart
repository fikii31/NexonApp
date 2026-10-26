import 'package:flutter/material.dart';
import '/model/item_model.dart';


class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}


class _CrudScreenState extends State<CrudScreen> {
  final List<ItemModel> _items = [];
  void _addItem(String title, String desc) {
    setState(() {
      _items.add(ItemModel(id: DateTime.now().toString(), title: title, description: desc));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Data (CRUD)')),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_items[index].title),
          subtitle: Text(_items[index].description),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _items.removeAt(index)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem('Materi Baru', 'Deskripsi materi perkuliahan'),
        child: const Icon(Icons.add),
      ),
    );
  }
}