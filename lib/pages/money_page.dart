import 'package:flutter/material.dart';
import 'package:money_converter/Currency.dart';
import 'package:money_converter/money_converter.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  final _amount = TextEditingController();
  String result = "";
  String chosen_currency1 = 'IDR';
  String chosen_currency2 = 'USD';

  void _convertCurrency() {

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
              controller: _amount,
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
                  value: this.chosen_currency1,
                  items: <String>['IDR', 'USD', 'EUR'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      chosen_currency1 = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 20,),
                DropdownButton<String>(
                  value: this.chosen_currency2,
                  items: <String>['IDR', 'USD', 'EUR'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      chosen_currency2 = newValue!;
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
                  _convertCurrency();
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
