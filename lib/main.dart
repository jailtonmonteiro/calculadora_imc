import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });

    _formKey = GlobalKey<FormState>(); //Resetar código de erro
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText = "Peso Normal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 29.9) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }

      FocusScope.of(context).unfocus(); //Esconde o teclado apos o calculo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline,
                  size: 120.0, color: Colors.lightBlueAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                controller: weightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.lightBlueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                controller: heightController,
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
