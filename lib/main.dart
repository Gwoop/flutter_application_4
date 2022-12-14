import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo GG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer timer5;

  int _counter = 0;
  int qwe = 1;
  String ewq = "qwe";
  _incrementCounterplus() {
    setState(() {
      if (qwe == 2) {
        _counter++;
      }
      _counter++;
      listqwe.add('+');
    });
    timer5.cancel();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
  }

  _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('count');
    prefs.remove('list');
    setState(() {
      _counter = 0;
      listqwe = [];
      timer5.cancel();
      timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    });
  }

  _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', _counter);
    prefs.setStringList('list', listqwe);
    timer5.cancel();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
  }

  _incrementCounterminus() {
    setState(() {
      if (qwe == 2) {
        _counter--;
      }
      _counter--;
      listqwe.add('-');
      timer5.cancel();
      timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    });
  }

  late List<String> listqwe;
  String qweeqw = "Првоерка";
  late String Textqwe;

  @override
  void initState() {
    listqwe = [];
    super.initState();
    timer5 = Timer(Duration(seconds: 5), _incrementCounterplus);
    SharedPreferences.getInstance().then((value) {
      setState(() {
        if (value.containsKey('count')) {
          _counter = value.getInt('count')!;
        }
        if (value.containsKey('list')) {
          listqwe = value.getStringList('list')!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Textqwe = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';
    if (Textqwe == 'DarkTheme') {
      qwe = 2;
    } else if(Textqwe == 'LightTheme')
      qwe = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
      Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Счёт :',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                  onPressed: () {
                    _incrementCounterplus();
                  },
                  child: Text("+")),
              ElevatedButton(
                  onPressed: () {
                    _incrementCounterminus();
                  },
                  child: Text("-")),
              
                  Container(
                    color: Colors.deepOrange,
                    height: 75,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _clearData,
                        child: Text("Очистить лист"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                            side: BorderSide(width:8, color: Colors.yellow)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.deepOrange,
                    height: 75,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _saveData,
                        child: Text("Сохранить Данные"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                            side: BorderSide(width:8, color: Colors.yellow)
                        ),
                      ),
                    ),
                  ),
              
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  ...listqwe
                      .map((element) => ListTile(
                            title: Text(element),
                          ))
                      .toList()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
