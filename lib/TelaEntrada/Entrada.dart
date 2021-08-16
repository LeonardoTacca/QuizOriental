import 'package:appcaiokib/Home/Home.dart';
import 'package:appcaiokib/class/classUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Entrada extends StatefulWidget {
  const Entrada({Key? key}) : super(key: key);

  @override
  _EntradaState createState() => _EntradaState();
}

class _EntradaState extends State<Entrada> {
  TextEditingController controllerNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fundo.jpg"), fit: BoxFit.fill)),
          child: Container(
            height: size.height * 0.1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.1),
                    child: Text(
                      'Seja Bem Vindo',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.01),
                    child: Text(
                      'Por favor preencha com seu nome!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03, right: size.width * 0.03),
                    child: Container(
                      child: TextFormField(
                        controller: controllerNome,
                        decoration: InputDecoration(
                          labelText: 'Nome:',
                          fillColor: Colors.grey[300],
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      right: size.width * 0.03,
                      left: size.width * 0.03,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Users.nome = controllerNome.text;
                        Get.to(TelaPrincipal());
                      },
                      child: Container(
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.deepPurple),
                        alignment: Alignment.center,
                        child: Text('Jogar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ]),
          )),
    );
  }
}
