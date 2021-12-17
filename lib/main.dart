import 'package:flutter/material.dart';

void main() => runApp(MyConvert());

class MyConvert extends StatefulWidget {
  const MyConvert({Key? key}) : super(key: key);

  @override
  State<MyConvert> createState() => _MyConvertState();
}

class _MyConvertState extends State<MyConvert> {
  String? _resultMessage;

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.blue[700],
    
  );
  String? _startMeasure;
  String? _convertedMeasure;

  final List<String> _measures = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'libras (lbs)',
    'onzas',
  ];

  final Map<String, int> _measuresMap = {
    'metros': 0,
    'kilometros': 1,
    'gramos': 2,
    'kilogramos': 3,
    'pies': 4,
    'millas': 5,
    'libras (lbs)': 6,
    'onzas': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    double result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'Esta conversacion no se puede realizar';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {});
  }

  double? _numberFrom;
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de Medidas',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Convertidor de Medidas'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
      image: NetworkImage('https://media.istockphoto.com/photos/measuring-tools-on-the-background-of-technical-drawings-view-on-top-picture-id845856304'),
      fit: BoxFit.cover,
    ),
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                
             child:  
             
                Center(
                   
                  child: Text(
                    'Valor',
                    style: labelStyle,
                  ),
                 
                ),
                
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  
                   
                  border: Border.all(
                    color: Colors.black,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                    style: inputStyle,
                    decoration: InputDecoration(
                      hintText: "Por favor, inserte la medida a convertir ",
                    ),
                    onChanged: (text) {
                      var rv = double.tryParse(text);
                      if (rv != null) {
                        setState(() {
                          _numberFrom = rv;
                        });
                      }
                    }),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.yellow,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                
                  child: Text(
                    'Desde',
                    style: labelStyle,
                  ),
                ),
            
              Container(
                decoration: BoxDecoration(
                  
                   
                  border: Border.all(
                    color: Colors.black,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasure = value as String?;
                    });
                  },
                  value: _startMeasure,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.green,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'A',
                  style: labelStyle,
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
               
                   
                  border: Border.all(
                    color: Colors.black,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: inputStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertedMeasure = value as String?;
                    });
                  },
                  value: _convertedMeasure,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                child: Text(
                  'Convert',
                  style: inputStyle,
                ),
                onPressed: () {
                  if (_startMeasure!.isEmpty ||
                      _convertedMeasure!.isEmpty ||
                      _numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom!, _startMeasure!, _convertedMeasure!);
                  }
                },
              ),
              Spacer(
                flex: 2,
              ),
              Text((_resultMessage == null) ? '' : _resultMessage.toString(),
                  style: labelStyle),
              Spacer(
                flex: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
