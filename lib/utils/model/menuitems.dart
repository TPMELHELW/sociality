import 'package:flutter/material.dart';
import 'package:sociality/utils/model/menuitem.dart';

class MenuItems {
  static List<MenuItem> items = [itemDelete, itemEdit];

  static var itemDelete = MenuItem(
    text: 'Delete',
    icon: Icons.delete,
  );
  static var itemEdit = MenuItem(
    text: 'Edit',
    icon: Icons.edit,
  );
}
