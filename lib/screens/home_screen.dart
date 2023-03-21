import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/providers/compras_provider.dart';
import 'package:lista_compras/theme/appTheme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          return Column(
            children: [
              Slidable(
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          topLeft: Radius.circular(12)),
                      onPressed: (context) =>
                          {comprasProvider.eliminarItem(index)},
                      label: 'Eliminar?',
                      icon: Icons.delete,
                      spacing: 10,
                      backgroundColor: Colors.red.shade300,
                    )
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 70),
                  decoration: BoxDecoration(
                    color: comprasProvider.listaCompra[index].comprado
                        ? AppTheme.greenLigth
                        : Colors.green[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: AppTheme.greenHard,
                    title: Text(
                      StringUtils.capitalize(
                          comprasProvider.listaCompra[index].nombre),
                      style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 20,
                          decoration:
                              comprasProvider.listaCompra[index].comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                    ),
                    secondary: Text(
                      '${comprasProvider.listaCompra[index].cantidad}',
                      style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 20,
                          decoration:
                              comprasProvider.listaCompra[index].comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                    ),
                    onChanged: (bool? value) {
                      comprasProvider.modificarCompra(index, value!);
                    },
                    value: comprasProvider.listaCompra[index].comprado,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newItemPopUp,
        backgroundColor: AppTheme.greenMedium,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
