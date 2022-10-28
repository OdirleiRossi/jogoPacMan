// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:aprendizado/path.dart';
import 'package:aprendizado/pixel.dart';
import 'package:aprendizado/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numeroColunas = 11;
  int numeroQuadrados = numeroColunas * 14;
  int player = numeroColunas * 12 + 1;

  List<int> barreiras = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    11,
    22,
    44,
    55,
    66,
    77,
    88,
    99,
    121,
    132,
    143,
    21,
    32,
    54,
    65,
    76,
    87,
    98,
    109,
    131,
    142,
    153,
    67,
    68,
    70,
    71,
    72,
    74,
    75,
    78,
    79,
    81,
    82,
    83,
    85,
    86,
    24,
    35,
    46,
    30,
    41,
    52,
    26,
    37,
    48,
    49,
    50,
    39,
    28,
    101,
    112,
    123,
    107,
    118,
    129,
    125,
    114,
    103,
    104,
    105,
    116,
    127
  ];

  List<int> alvo = [];

  String direcao = 'direita';

  bool jogoComecou = true;
  bool bocaFechada = false;

  void startGame() {
    pegarAlvo();

    //Timer.periodic(Duration(milliseconds: 150), (timer) {
    setState(() {
      bocaFechada = !bocaFechada;
    });

    if (alvo.contains(player)) {
      alvo.remove(player);
    }

    /*
      if (player == 43) {
        //Navigator.push(
        //  context, MaterialPageRoute(builder: (context) => SegundaTela()));

        barreiras = [21, 32, 54,65,76,87,98,109,131,142,153];
        pegarAlvo();
      ////// ZERAR O VETOR DE ALVOS???
      }*/

    switch (direcao) {
      case 'esquerda':
        moveEsquerda();
        break;
      case 'direita':
        moveDireita();
        break;
      case 'cima':
        moveCima();
        break;
      case 'baixo':
        moveBaixo();
        break;
    }
    ;
  }

  void pegarAlvo() {
    for (int i = 0; i < numeroQuadrados; i++) {
      if (!barreiras.contains(i)) {
        alvo.add(i);
      }
    }
  }

  void moveEsquerda() {
    if (!barreiras.contains(player - 1)) {
      setState(() {
        player--;
        direcao = 'esquerda';
        bocaFechada = !bocaFechada;
        if (alvo.contains(player)) {
          alvo.remove(player);
        }
      });
    }
  }

  void moveDireita() {
    if (!barreiras.contains(player + 1)) {
      setState(() {
        player++;
        direcao = 'direite';
        bocaFechada = !bocaFechada;       
        if (alvo.contains(player)) {
          alvo.remove(player);
        }
      });
    }
  }

  void moveCima() {
    if (!barreiras.contains(player - numeroColunas)) {
      setState(() {
        player -= numeroColunas;
        direcao = 'cima';
        bocaFechada = !bocaFechada; 
        if (alvo.contains(player)) {
          alvo.remove(player);
        }
      });
    }
  }

  void moveBaixo() {
    if (!barreiras.contains(player + numeroColunas)) {
      setState(() {
        player += numeroColunas;
        direcao = 'baixo';
        bocaFechada = !bocaFechada;
        if (alvo.contains(player)) {
          alvo.remove(player);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            //expande para o tamanho máximo da tela
            flex: 10, //proporção 1/10 para os demais widget

            child: GridView.builder(
              //cria a grade 15x300
              physics: NeverScrollableScrollPhysics(),
              itemCount: numeroQuadrados,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numeroColunas),
              itemBuilder: (BuildContext context, int index) {
                if (bocaFechada && player == index) {
                  //teste para animação boca
                  return Padding(
                      padding: EdgeInsets.all(7),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow[400], shape: BoxShape.circle),
                      ));
                } else if (player == index) {
                  //teste para direção pac man
                  switch (direcao) {
                    case "esquerda":
                      return Transform.rotate(
                        angle: pi,
                        child: MyPlayer(),
                      );
                    case "direita":
                      return MyPlayer();
                    case "cima":
                      return Transform.rotate(
                        angle: 3 * pi / 2,
                        child: MyPlayer(),
                      );
                    case "baixo":
                      return Transform.rotate(
                        angle: pi / 2,
                        child: MyPlayer(),
                      );
                    default:
                      return MyPlayer();
                  }
                } else if (barreiras.contains(index)) {
                  return Mypixel(
                      innerColor: Colors.blue[800],
                      outerColor: Colors.blue[900]);
                  //child: Text(index.toString()));
                }
                ;

                if (jogoComecou == true && !alvo.contains(index)) {
                  return MyPath(
                    innerColor: Colors.black,
                    outerColor: Colors.black,
                  );
                } else {
                  return MyPath(
                    innerColor: Colors.orange,
                    outerColor: Colors.black,
                  );
                }
              },
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: startGame,
                  child: Text('PLAY',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              GestureDetector(
                  onTap: moveDireita,
                  child: Text('D',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              GestureDetector(
                  onTap: moveEsquerda,
                  child: Text("E",
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              GestureDetector(
                  onTap: moveCima,
                  child: Text('C',
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              GestureDetector(
                  onTap: moveBaixo,
                  child: Text("B",
                      style: TextStyle(color: Colors.white, fontSize: 30)))
            ],
          )),
        ],
      ),
    );
  }
}
