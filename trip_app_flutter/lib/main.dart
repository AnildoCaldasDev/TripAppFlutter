// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hello You',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new HelloYou(),
//     );
//   }
// }

// class HelloYou extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _HelloYouState();
// }

// class _HelloYouState extends State<HelloYou>{
//   String name = "";
//   final _currencies = ['Dollars','Euro','Pounds'];
//   String _currency = 'Dollars';

//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text("Hello"),
//          backgroundColor: Colors.blueAccent,
//        ),
//        body: Container(
//          padding: EdgeInsets.all(15.0),
//          child: Column(
//            children: <Widget>[
//              TextField(
//                decoration: InputDecoration(
//                  hintText: "Informe seu nome..."
//                ),
//                onChanged: (String newValue){
//                  setState(() {
//                    name = newValue;
//                  });
//                },
//                onSubmitted: (String newValue){
//                  setState(() {
//                    name = "Novo Nome: " + newValue;
//                  });
//                },
//              ),
//             DropdownButton<String>(
//               items: _currencies.map((String value){
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value)
//                 );
//               }).toList(),
//               value: _currency,
//               onChanged: (String value) {
//                 _onDropdownChanged(value);
//               },
//             ),
//              Text("Hello " + name + "!"),
//              Spacer(),
//              Text("Your Currency is: " + _currency + "!")
//            ],
//          ),
//        ),
//      );
//   }
// _onDropdownChanged(String value){
//   setState(() {
//     this._currency = value;
//   });
// }
// }

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = "";
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _distanceForm = 5.0;
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Trip Cost Calculator"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: _distanceForm, bottom: _distanceForm),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                      labelText: "Distancia:",
                      hintText: "ex. 1234 Km",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _distanceForm, bottom: _distanceForm),
                  child: TextField(
                    controller: avgController,
                    decoration: InputDecoration(
                        labelText: "Distancia por Unidade:",
                        hintText: "ex. 12",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    keyboardType: TextInputType.number,
                  )),
              Padding(
                padding:
                    EdgeInsets.only(top: _distanceForm, bottom: _distanceForm),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: "Preço:",
                          hintText: "ex. 1234",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    )),
                    Container(width: _distanceForm * 5),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _currency,
                        onChanged: (String value) {
                          _onDropdownChanged(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _distanceForm, bottom: _distanceForm),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          result = _calculate();
                        });
                      },
                      child: Text(
                        'Calcular',
                        textScaleFactor: 1.5,
                      ),
                    )),
                    Container(width: _distanceForm * 5),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).buttonColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        child: Text(
                          'Limpar',
                          textScaleFactor: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(result),
            ],
          ),
        ));
  }

  _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consuption = double.parse(avgController.text);
    double _totalCost = _distance / _consuption * _fuelCost;
    String _result = 'Custo total da viagem: ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }

  void _reset() {
    distanceController.text = "";
    avgController.text = "";
    priceController.text = "";
    setState(() {
      result = "";
    });
  }
}
