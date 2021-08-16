import 'dart:convert';

import 'package:appcaiokib/Home/Home.dart';
import 'package:appcaiokib/TelaEntrada/Entrada.dart';
import 'package:appcaiokib/class/classUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Pergunta extends StatefulWidget {
  final String? textValor1;
  final String? textValor2;
  final String? textValor3;
  final String? textValor4;
  final String? palavra;
  final String? respostaCerta;
  const Pergunta(
      {Key? key,
      @required this.textValor1,
      @required this.textValor2,
      @required this.textValor3,
      @required this.textValor4,
      @required this.palavra,
      @required this.respostaCerta})
      : super(key: key);

  @override
  _PerguntaState createState() => _PerguntaState(
      textValor1: textValor1,
      textValor2: textValor2,
      textValor3: textValor3,
      textValor4: textValor4,
      palavra: palavra,
      respostaCerta: respostaCerta);
}

class _PerguntaState extends State<Pergunta> {
  _PerguntaState(
      {@required this.textValor1,
      this.textValor2,
      this.textValor3,
      this.textValor4,
      this.palavra,
      this.respostaCerta});
  String? respostaCerta;
  String? palavra;
  bool valor1 = false;
  bool valor2 = false;
  bool valor3 = false;
  bool valor4 = false;
  String? textValor1;
  String? textValor2;
  String? textValor3;
  String? textValor4;
  String? txtResultado;
  conferirResult(palavracorreta, palavraselecionada) {
    if (palavracorreta == palavraselecionada) {
      Users.pontuacao.add(1);
      print(Users.dados.length);
      if (Users.dados.length == 0) {
        showDialogAcerto();
      } else {
        Get.to(TelaPrincipal());
      }
    } else {
      if (Users.dados.length == 0) {
        print(Users.dados.length);
        showDialogAcerto();
      } else {
        Get.to(TelaPrincipal());
      }
    }
  }

  showDialogAcerto() async {
    String? resultado;
    if (Users.pontuacao.length <= 4) {
      setState(() {
        resultado = 'Que Pena!';
      });
    } else {
      setState(() {
        resultado = 'Parabéns!';
      });
    }
    String? texto;
    if (Users.pontuacao.length >= 4) {
      setState(() {
        texto = 'Legal!!';
      });
    } else {
      setState(() {
        texto = 'Ok!';
      });
    }
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        title: new Text(
          resultado.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: new Text(
          'Você teve ${Users.pontuacao.length} acertos!!!!!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          FloatingActionButton(
            elevation: 0.0,
            isExtended: true,
            backgroundColor: Colors.deepPurple[700],
            focusColor: Colors.red,
            child: Text(
              '$texto',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            onPressed: () async {
              await fetchApi();
            },
          )
        ],
      ),
    );
  }

  fetchApi() async {
    var corpoRequisicao = jsonEncode(
      {
        'placar': Users.pontuacao.length,
        'usuario': Users.nome.toString(),
      },
    );
    var url = 'https://7c2bad50.us-south.apigw.appdomain.cloud/api/placar';
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: corpoRequisicao,
    );
    if (response.statusCode == 200) {
      Users.dados.addAll([
        ["Sugoi", "Abraço", "Amigo", "Incrível", "Triste", "Incrivel"],
        ["Wakai", "Velho", "Jovem", "Feio", "Vagabundo", "Jovem"],
        ["Kawai", "Nojento", "Idoso", "Gostoso", "Fofo", "Fofo"],
        ["Oishii", "Gostoso", "Ruim", "Bom", "Fedido", "Gostoso"],
        ["Miru", "Socar", "Ver", "Boçal", "Estelionatário", "Ver"],
        [
          "Ohayougozaimasu!",
          "Boa tarde",
          "Estou muito puto",
          "Bom dia",
          "Boa noite",
          "Bom dia"
        ],
        ["Ureshii", "Sede", "Feliz", "Cabisbaixo", "Eu sou casado", "Feliz"],
        [
          "Douitashimashite!",
          "De nada",
          "Obrigado",
          "Petista",
          "Vou sair hoje",
          "Obrigado"
        ],
      ]);
      Users.pontuacao.removeRange(0, Users.pontuacao.length);
      Get.to(Entrada());
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.1,
                  right: size.width * 0.08,
                  left: size.width * 0.08),
              child: Text(
                'Qual palavra esta escrita em Japones?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  right: size.width * 0.08,
                  left: size.width * 0.08),
              child: Text(
                '$palavra',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                  top: size.height * 0.01),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: Text(
                                    '$textValor1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  key: Key('check6'),
                                  value: valor1,
                                  onChanged: (valor) {
                                    setState(() {
                                      valor1 = true;
                                      valor2 = false;
                                      valor3 = false;
                                      valor4 = false;
                                      txtResultado = textValor1;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: Text(
                                    '$textValor2',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  key: Key('check6'),
                                  value: valor2,
                                  onChanged: (valor) {
                                    setState(() {
                                      valor1 = false;
                                      valor2 = true;
                                      valor3 = false;
                                      valor4 = false;
                                      txtResultado = textValor2;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: Text(
                                    '$textValor3',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  key: Key('check6'),
                                  value: valor3,
                                  onChanged: (valor) {
                                    setState(() {
                                      valor1 = false;
                                      valor2 = false;
                                      valor3 = true;
                                      valor4 = false;
                                      txtResultado = textValor3;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: Text(
                                    '$textValor4',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  key: Key('check9'),
                                  value: valor4,
                                  onChanged: (valor) {
                                    setState(() {
                                      valor1 = false;
                                      valor2 = false;
                                      valor3 = false;
                                      valor4 = true;
                                      txtResultado = textValor4;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.3,
                  right: size.width * 0.08,
                  left: size.width * 0.08),
              child: GestureDetector(
                onTap: () => {conferirResult(respostaCerta, txtResultado)},
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                  ),
                  child: Text(
                    'ENVIAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
