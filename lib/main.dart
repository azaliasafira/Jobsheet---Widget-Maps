import 'package:flutter/material.dart';
import 'Convert.dart';
import 'Input.dart';
import 'Result.dart';

void main() {
  runApp(MyApp());
}

// final TextEditingController inputController;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// This widget is the root of your application.
  //controller
  List<String> listViewItem = List<String>();
  //mengeset nilai pada dropdown
  String _newValue = "Kelvin";
  double _result = 0;

  TextEditingController inputController = new TextEditingController();
  double _inputSuhu = 0;
  double _kelvin = 0;
  double _reamur = 0;
  //list
  var listItem = {"Kelvin", "Reamur"};

  void perhitunganSuhu() {
    setState(() {
      _inputSuhu = double.parse(inputController.text);
      if (_newValue == "Kelvin")
        _result = _inputSuhu + 273;
      else
        _result = (4 / 5) * _inputSuhu;
      listViewItem.add("$_newValue : $_result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konverter Suhu"),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              input(inputController: inputController),
              DropdownButton<String>(
                items: listItem.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                // isi value dengan variabel _newValue.
                value: _newValue,
                onChanged: (String changeValue) {
                  setState(() {
                    _newValue = changeValue;
                    perhitunganSuhu();
                  });
                },
              ),
              Result(result: _result),
              Convert(
                convertHandler: perhitunganSuhu,
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Riwayat Konversi",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView(
                    children: listViewItem.map((String value) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ));
                }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //method dropdownOnChanged
  void dropdownOnChanged(String changeValue) {
    _newValue = changeValue;
  }
}
