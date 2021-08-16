import 'dart:math';

import 'package:appcaiokib/Pergunta/Pergunta.dart';
import 'package:appcaiokib/class/classUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  getword() async {
    Random random = new Random();
    int valorRandom = random.nextInt(Users.dados.length);
    var word = await Users.dados.elementAt(valorRandom);
    await Users.dados.removeAt(valorRandom);
    Get.to(Pergunta(
      textValor1: word[1],
      textValor2: word[2],
      textValor3: word[3],
      textValor4: word[4],
      palavra: word[0],
      respostaCerta: word[5],
    ));
  }

  @override
  void initState() {
    this.getword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.deepPurple[700],
        ),
      ),
    );
  }
}
