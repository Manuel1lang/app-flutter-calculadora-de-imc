import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Calculadora IMC", home: HOME()));
}

class HOME extends StatefulWidget {
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infotext = "Informe os seus dados";

  void _resetField() {
    weightcontroller.text = "";
    heightcontroller.text = "";

    setState(() {
      _infotext = "Informe os seus dados";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightcontroller.text);
      double height = double.parse(heightcontroller.text) / 100;

      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infotext = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infotext = "Peso ideal(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infotext = "Levemente acima do peso(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infotext = "Obesidade Grau I(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infotext = "Obesidade Grau II(${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infotext = "Obesidade Grau III(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.red,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                  prefixText: "Kg",
                ),
                style: TextStyle(color: Colors.black),
                controller: weightcontroller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 22.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                      prefixText: "Cm"),
                  style: TextStyle(color: Colors.black),
                  controller: heightcontroller,
                  validator: (value) {
                    if (value.isEmpty) return "Insira sua altura";
                    if (value.length < 2)
                      return "O campo deve ter mais de 1 caracter";

                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
              Text(
                _infotext,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
