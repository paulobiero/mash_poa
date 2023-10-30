import 'package:flutter/cupertino.dart';

class AboutItem {
  AboutItem({
    this.name = '',
    this.content = '',
    required this.icon,
    required this.onClick

  });

  late String name,content;
  late Widget icon;
  late Function()onClick;


}