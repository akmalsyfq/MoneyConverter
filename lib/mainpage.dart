import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  TextEditingController textEditingController = TextEditingController();
  double num = 0, result = 0, val = 0;
  var total = '';
  String selectCur = "USD";
  String selectCur1 = "USD";
  List<String> locList = [
    "USD",
    "MYR",
    "SGD",
    "GBP",
    "JPY",
  ];
  List<String> locList1 = [
    "USD",
    "MYR",
    "SGD",
    "GBP",
    "JPY",
  ];
  String desc = "No record";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F8E9),
        appBar: AppBar(
          leading: Image.asset('assets/images/logo.png'),
          title: const Text('Convert +'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Currency Converter",
                      style: TextStyle(fontSize: 26),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: textEditingController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          hintText: "Money amount",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          itemHeight: 60,
                          value: selectCur1,
                          onChanged: (newValue) {
                            setState(() {
                              selectCur1 = newValue.toString();
                            });
                          },
                          items: locList1.map((selectCur) {
                            return DropdownMenuItem(
                              child: Text(
                                selectCur,
                              ),
                              value: selectCur,
                            );
                          }).toList(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {},
                        ),
                        DropdownButton(
                          itemHeight: 60,
                          value: selectCur,
                          onChanged: (newValue) {
                            setState(() {
                              selectCur = newValue.toString();
                            });
                          },
                          items: locList.map((selectCur) {
                            return DropdownMenuItem(
                              child: Text(
                                selectCur,
                              ),
                              value: selectCur,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: _loadCurrency,
                            child: const Text("Convert Currency"))),
                    Text(desc,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                )))));
  }

  void _loadCurrency() async {
    var apiid = "0e4d7a40-3b8d-11ec-9350-7b4592d4fed6";
    var url = Uri.parse(
        'https://freecurrencyapi.net/api/v2/latest?apikey=$apiid&base_currency=$selectCur1');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        // ignore: non_constant_identifier_names
        var JPY = parsedJson['data']['JPY'];
        // ignore: non_constant_identifier_names
        var MYR = parsedJson['data']['MYR'];
        // ignore: non_constant_identifier_names
        var USD = parsedJson['data']['USD'];
        // ignore: non_constant_identifier_names
        var GBP = parsedJson['data']['GBP'];
        // ignore: non_constant_identifier_names
        var SGD = parsedJson['data']['SGD'];
        num = double.parse(textEditingController.text);

        if (selectCur == 'JPY') {
          result = num * JPY;
        } else if (selectCur == 'MYR') {
          result = num * MYR;
        } else if (selectCur == 'USD') {
          result = num * USD;
        } else if (selectCur == 'GBP') {
          result = num * GBP;
        } else if (selectCur == 'SGD') {
          result = num * SGD;
        }
        total = result.toStringAsFixed(2);
        desc = "$selectCur1$num to $selectCur is $selectCur$total";
      });
    } else {
      setState(() {
        desc = "No  record";
      });
    }
  }
}
