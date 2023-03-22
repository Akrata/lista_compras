import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../models/item.dart';

class Boxes {
  static Box<Item> getItems() => Hive.box<Item>('itemsBox');
}
