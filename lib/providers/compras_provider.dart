import 'package:flutter/material.dart';

import '../models/item.dart';

class ComprasProvider extends ChangeNotifier {
  List<Item> listaCompra = [];

  ComprasProvider() {}

  agregarCompra(Item item) {
    listaCompra.add(item);
    print(listaCompra[0].nombre);
    notifyListeners();
  }

  modificarCompra(index, bool valor) {
    listaCompra[index].comprado = valor;
    notifyListeners();
  }

  eliminarLista() {
    listaCompra.clear();
    notifyListeners();
  }
}
