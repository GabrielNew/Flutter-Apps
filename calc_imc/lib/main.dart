import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControle = TextEditingController();
  TextEditingController alturaControle = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String info = "Informe seus Dados";

  void resetCampos() {
    pesoControle.text = "";
    alturaControle.text = "";

    setState(() {
      info = "Informe seus Dados";
      formKey = GlobalKey<FormState>();
    });
  }

  void calcIMC() {
    setState(() {
      double peso = double.parse(pesoControle.text);
      double altura = double.parse(alturaControle.text) / 100;
      double imc = (peso / (altura * altura));

      if (imc < 18.6) {
        info = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        info = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        info = "Levement Acima do Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40.0) {
        info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetCampos,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                controller: pesoControle,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextFormField(
                controller: alturaControle,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return "Insira sua Altura";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        calcIMC();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
