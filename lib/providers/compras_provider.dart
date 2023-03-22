import 'package:flutter/material.dart';
import 'package:lista_compras/services/boxes.dart';

import '../models/item.dart';

class ComprasProvider extends ChangeNotifier {
  bool tieneItems = false;
  actualizarLista() {
    Boxes.getItems();
    notifyListeners();
  }

  agregarCompra(String nombre, int cantidad, bool comprado) {
    final item = Item()
      ..nombre = nombre
      ..cantidad = cantidad
      ..comprado = comprado;
    final box = Boxes.getItems();
    box.add(item);
  }

  editarCompra(Item item, bool comprado) {
    final box = Boxes.getItems();
    item.comprado = comprado;
    box.put(item.key, item);
    item.save();
  }

  eliminarCompra(Item item) {
    final box = Boxes.getItems();
    box.delete(item.key);
  }

  eliminarLista() {
    final box = Boxes.getItems();
    box.clear();
  }
}
