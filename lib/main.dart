import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "";

  void _limpar() {
    peso.text = "";
    altura.text = "";
  }

  void _calculateImc() {
    setState(() {
      double _peso = double.parse(peso.text);
      double _altura = double.parse(altura.text) / 100;

      double imc = _peso / (_altura * _altura);

      if (_peso <= 0 || _altura <= 0) {
        _infoText = "Não é possivel calcular digite um valor maior que 0 ";
      } else if (imc < 18.5) {
        _infoText = "Abaixo do Peso ideal (IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Peso Ideal (IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Acima do peso ideal (IMC: ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30) {
        _infoText = "Obeso (IMC: ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.blue),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Peso (Kg)", labelStyle: TextStyle(color: Colors.blue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: peso,
                    validator: (value) {
                      return "Insira seu Peso!";
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Altura (cm)", labelStyle: TextStyle(color: Colors.blue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: altura,
                    validator: (value) {
                      return "Insira sua Altura!";
                    },
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            _calculateImc();
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            _limpar();
                          },
                          child: Text(
                            "Limpar",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ]),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              )),
        ));
  }
}
