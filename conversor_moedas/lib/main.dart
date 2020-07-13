import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const api = 'https://api.hgbrasil.com/finance?key=5f776e83';

void main() async {
  runApp(MaterialApp(
    title: "Conversor de Moedas",
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final controladorReal = TextEditingController();
  final controladorDolar = TextEditingController();
  final controladorEuro = TextEditingController();

  double dolar;
  double euro;

  void _real(String text){
    if (text.isEmpty) {
      limparCampos();
      return;
    }
    double real = double.parse(text);
    controladorDolar.text = (real/dolar).toStringAsFixed(2);
    controladorEuro.text = (real/euro).toStringAsFixed(2);
  }

  
  void _dolar(String text){
    if (text.isEmpty) {
      limparCampos();
      return;
    }
    double dolar = double.parse(text);
    controladorReal.text = (dolar * this.dolar).toStringAsFixed(2);
    controladorEuro.text = (dolar * this.dolar/euro).toStringAsFixed(2);
  }


  void _euro(String text){
    if (text.isEmpty) {
      limparCampos();
      return;
    }
    double euro = double.parse(text);
    controladorReal.text = (euro * this.euro).toStringAsFixed(2);
    controladorDolar.text = (euro * this.euro/dolar).toStringAsFixed(2); 
  }

  void limparCampos(){
    controladorReal.text = "";
    controladorDolar.text = "";
    controladorEuro.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Conversor Monetário"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Carregando os Dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "ERRO",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(Icons.monetization_on,
                                size: 150.0, color: Colors.amber),
                            buildTextField("Reais", "R\$", controladorReal, _real),
                            Divider(),
                            buildTextField("Dólares", "US\$", controladorDolar, _dolar),
                            Divider(),
                            buildTextField("Euros", "€\$", controladorEuro, _euro),
                          ]));
                }
            }
          }),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(api);
  return json.decode(response.body);
}

Widget buildTextField(String moeda, String icone, TextEditingController controlador, Function mudar) {
  return TextField(
    controller: controlador,
    decoration: InputDecoration(
        labelText: moeda,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: icone),
    style: TextStyle(color: Colors.amber),
    onChanged: mudar,
    keyboardType: TextInputType.number,
  );

}
