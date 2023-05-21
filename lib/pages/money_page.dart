import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  double _amount = 0.0;
  double result = 0.0;
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';

  Future<double> convertCurrency() async {

    final url = Uri.parse('https://api.exchangerate.host/convert?from=$_fromCurrency&to=$_toCurrency&amount=$_amount');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      double rate = data['info']['rate'];
      return _amount * rate;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _onConvertPressed() {
    convertCurrency().then((value) {
      setState(() {
        result = value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const Text(
              "Currency Converter",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              onChanged: (value) {
                _amount = double.parse(value);
              },
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: this._fromCurrency,
                  items: <String>['IDR', 'USD', 'EUR', 'CNY', 'JPY'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 20,),
                DropdownButton<String>(
                  value: this._toCurrency,
                  items: <String>['IDR', 'USD', 'EUR', 'CNY', 'JPY'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text("Convert"),
                onPressed: (){
                  _onConvertPressed();
                }
            ),
            const SizedBox(height: 20,),
            const Text(
              "Result:",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              '$result',
              style: const TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
