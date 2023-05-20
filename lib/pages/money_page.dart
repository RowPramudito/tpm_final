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

  void _calculate() {
    double input_amount = double.parse(_amount.text);
    print(input_amount);
    if(chosen_currency1 == 'IDR') {
      if(chosen_currency2 == 'USD') {
        var convert_res = MoneyConverter.convert(
            Currency(Currency.IDR, amount: input_amount), Currency(Currency.USD)
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else if(chosen_currency2 == 'EUR') {
        var convert_res = MoneyConverter.convert(
            Currency(Currency.IDR, amount: input_amount), Currency(Currency.EUR)
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else {}
    }
    else if(chosen_currency1 == 'USD') {
      if(chosen_currency2 == 'IDR') {
        var convert_res = MoneyConverter.convert(
            Currency(Currency.USD, amount: input_amount), Currency(Currency.IDR)
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else if(chosen_currency2 == 'EUR') {
        var convert_res = MoneyConverter.convert(
            Currency(Currency.EUR, amount: input_amount), Currency(Currency.EUR)
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else {}
    }
    else if(chosen_currency1 == 'EUR') {
      if(chosen_currency2 == 'IDR') {
        var convert_res = MoneyConverter.convert(
          Currency(Currency.EUR, amount: input_amount), Currency(Currency.IDR),
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else if(chosen_currency2 == 'USD') {
        var convert_res = MoneyConverter.convert(
            Currency(Currency.EUR, amount: input_amount), Currency(Currency.USD)
        );
        setState(() {
          result = convert_res.toString();
        });
      }
      else {}
    }
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
                  _calculate();
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
