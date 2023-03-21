import 'package:flutter/material.dart';
import 'package:lista_compras/providers/compras_provider.dart';
import 'package:lista_compras/theme/appTheme.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comprasProvider = Provider.of<ComprasProvider>(context);

    _newItemPopUp() {
      String nombre = '';
      int cantidad = 0;

      showDialog(
        context: context,
        builder: (context) => Form(
          child: AlertDialog(
            backgroundColor: AppTheme.greenLigth,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => nombre = value,
                  decoration: InputDecoration(
                    label: Text("Producto"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) => cantidad = int.parse(value),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Cantidad"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  Item item = Item(nombre: nombre, cantidad: cantidad);
                  comprasProvider.agregarCompra(item);
                  nombre = '';
                  cantidad = 0;
                  Navigator.pop(context);
                },
                child: Text("Guardar"),
              )
            ],
          ),
        ),
      );
    }

    _eliminarLista() {
      showDialog(
        context: context,
        builder: (context) => comprasProvider.listaCompra.length > 0
            ? AlertDialog(
                content: Text("Seguro desea eliminar toda la lista?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                      onPressed: () {
                        comprasProvider.eliminarLista();
                        Navigator.pop(context);
                      },
                      child: Text("Si"))
                ],
              )
            : AlertDialog(
                content: Text("La lista ya está vacía"),
              ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.greenLigth,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Text(
          "Lista de compras",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.greenMedium,
        actions: [
          Container(
            child: IconButton(
              onPressed: _eliminarLista,
              icon: Icon(Icons.delete, size: 30),
            ),
            margin: EdgeInsets.only(right: 20),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: comprasProvider.listaCompra.length,
        padding: EdgeInsets.all(40),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(minHeight: 70),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: comprasProvider.listaCompra[index].comprado
                  ? AppTheme.greenLigth
                  : Colors.green[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: CheckboxListTile(
              activeColor: AppTheme.greenHard,
              title: Text(
                '${comprasProvider.listaCompra[index].nombre}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 20,
                    decoration: comprasProvider.listaCompra[index].comprado
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              secondary: Text(
                '${comprasProvider.listaCompra[index].cantidad}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 20,
                    decoration: comprasProvider.listaCompra[index].comprado
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              onChanged: (bool? value) {
                comprasProvider.modificarCompra(index, value!);
              },
              value: comprasProvider.listaCompra[index].comprado,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newItemPopUp,
        backgroundColor: AppTheme.greenMedium,
        child: Icon(Icons.add),
      ),
    );
  }
}
