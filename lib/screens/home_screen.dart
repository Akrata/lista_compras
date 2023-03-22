import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista_compras/providers/compras_provider.dart';
import 'package:lista_compras/services/boxes.dart';
import 'package:lista_compras/theme/appTheme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comprasProvider = Provider.of<ComprasProvider>(context);
    String nombre = '';
    int cantidad = 0;
    bool comprado = false;
    _newItemPopUp() {
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
                  decoration: const InputDecoration(
                    label: Text("Producto"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (value) => cantidad = int.parse(value),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Cantidad"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  if (nombre.isNotEmpty) {
                    comprasProvider.agregarCompra(nombre, cantidad, comprado);
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("Es necesario agregar algo..."),
                            ));
                  }
                },
                child: const Text("Guardar"),
              )
            ],
          ),
        ),
      );
    }

    _eliminarLista() {
      showDialog(
        context: context,
        builder: (context) => Boxes.getItems().isNotEmpty
            ? AlertDialog(
                content: const Text("Seguro desea eliminar toda la lista?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                      onPressed: () {
                        comprasProvider.eliminarLista();
                        Navigator.pop(context);
                      },
                      child: const Text("Si"))
                ],
              )
            : const AlertDialog(
                content: Text("La lista ya está vacía"),
              ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.greenLigth,
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          "Lista de compras",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.greenMedium,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: _eliminarLista,
              icon: const Icon(Icons.delete, size: 30),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder<Box<Item>>(
        valueListenable: Boxes.getItems().listenable(),
        builder: (context, box, _) {
          final items = box.values.toList();
          // comprasProvider.items = items;
          return ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(40),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Slidable(
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12)),
                          onPressed: (context) =>
                              {comprasProvider.eliminarCompra(items[index])},
                          label: 'Eliminar?',
                          icon: Icons.delete,
                          spacing: 10,
                          backgroundColor: Colors.red.shade300,
                        )
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(minHeight: 50),
                      decoration: BoxDecoration(
                        color: items[index].comprado
                            ? AppTheme.greenLigth
                            : Colors.green[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CheckboxListTile(
                        checkColor: Colors.white,
                        activeColor: AppTheme.greenHard,
                        title: Text(
                          StringUtils.capitalize(items[index].nombre),
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              overflow: TextOverflow.clip,
                              fontSize: 20,
                              decoration: items[index].comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        secondary: Text(
                          '${items[index].cantidad}',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              overflow: TextOverflow.clip,
                              fontSize: 20,
                              decoration: items[index].comprado
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        onChanged: (bool? value) {
                          comprasProvider.editarCompra(items[index], value!);
                        },
                        value: items[index].comprado,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            },
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
