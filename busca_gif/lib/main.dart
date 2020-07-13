import 'package:flutter/material.dart';

import 'package:busca_gif/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "Buscador de Gif",
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white),
  ));
}
