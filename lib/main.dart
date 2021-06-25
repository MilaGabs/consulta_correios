import 'package:flutter/material.dart';
import 'consulta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Consulta()));
            },
            child: Container(
                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.height / 8,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2),
                  ],
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Realizar consulta',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
