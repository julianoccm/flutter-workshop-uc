import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() { //stf
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  TextEditingController controllerPerguntaUsuario = TextEditingController();
  
  String perguntaUsuario = "";
  String respostaChat = "";

  Future<void> chamarChatGPT(String pergunta) async {
    setState(() {
      perguntaUsuario = pergunta;
    });

    final resposta = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer TOKEN',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': pergunta},
          ],
        }),`
      ); 

      var dados = jsonDecode(resposta.body);

      var textoRetorno = dados['choices'][0]['message']['content'] as String;
      
      setState(() {
        respostaChat = textoRetorno;
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App com IA", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          backgroundColor: Colors.indigo,
          centerTitle: true,
        ),
        backgroundColor: Colors.white70,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Faça sua pergunta:", style: TextStyle(
                fontWeight: FontWeight.bold
              )),
          
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite sua pergunta',
                        border: OutlineInputBorder()
                      ),
                      controller: controllerPerguntaUsuario,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton.filled(
                      onPressed: () {
                        chamarChatGPT(controllerPerguntaUsuario.value.text);
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),

              if (perguntaUsuario.isNotEmpty)
              Padding( //Pergunta do usuario
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(perguntaUsuario, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )),
                  ),
                ),
              ),


              if(respostaChat.isNotEmpty)
              Padding( // Reposta do chat
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(respostaChat, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
