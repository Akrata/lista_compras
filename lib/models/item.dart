import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  late String nombre;
  @HiveField(1)
  late int cantidad;
  @HiveField(2)
  late bool comprado = false;
}
