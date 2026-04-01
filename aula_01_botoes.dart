import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Teste flutter")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Texto 1"),
              Text("Texto 2"),
              TextButton(child: Text("TextButton"), onPressed: () {}),
              OutlinedButton(child: Text("OutlinedButton"), onPressed: () {}),
              ElevatedButton(child: Text("ElevatedButton"), onPressed: () {}),
              TextField(
                decoration: InputDecoration(
                  labelText: "TextField",
                  border:
                      OutlineInputBorder(), // OutlineInputBorder UnderlineInputBorder
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
