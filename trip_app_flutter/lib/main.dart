import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello You',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HelloYou(),
    );
  }
}


class HelloYou extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou>{
  String name = "";
  final _currencies = ['Dollars','Euro','Pounds'];
  String _currency = 'Dollars';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Hello"),
         backgroundColor: Colors.blueAccent,
       ),
       body: Container(
         padding: EdgeInsets.all(15.0),
         child: Column(
           children: <Widget>[
             TextField(
               decoration: InputDecoration(
                 hintText: "Informe seu nome..."                 
               ),
               onChanged: (String newValue){
                 setState(() {
                   name = newValue;
                 });
               },
               onSubmitted: (String newValue){
                 setState(() {
                   name = "Novo Nome: " + newValue;
                 });
               },
             ),
            DropdownButton<String>(
              items: _currencies.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value)
                );
              }).toList(),
              value: _currency,
              onChanged: (String value) {
                _onDropdownChanged(value);
              },
            ),
             Text("Hello " + name + "!"),
             Spacer(),
             Text("Your Currency is: " + _currency + "!")
           ],
         ),
       ),
     );
  }

_onDropdownChanged(String value){
  setState(() {
    this._currency = value;
  });
}


}