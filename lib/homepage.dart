// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:aprendizado/fantasmas.dart';
import 'package:aprendizado/path.dart';
import 'package:aprendizado/pixel.dart';
import 'package:aprendizado/player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numeroColunas = 11;
  int numeroQuadrados = numeroColunas * 14;
  int player = numeroColunas * 12 + 1;
  int posicaoFantasmaVermelho = 12;
  int posicaoFantasmaVerde = 20;
  int posicaoFantasmaRosa = 141;
  int posicaoFantasmaAmarelo = 60;

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

  void pegarAlvo() {
    for (int i = 0; i < numeroQuadrados; i++) {
      if (!barreiras.contains(i)) {
        alvo.add(i);
        alvo.remove(player);
      }
    }
  }

  void portal(destino) {
    player = destino;
    alvo.remove(destino);
  }

  comeralvo(player) {
    if (alvo.contains(player)) {
      alvo.remove(player);
      somAlvo.play(AssetSource('sounds/pellet.wav'));
    }
  }

  void moveEsquerda() {
    if (!barreiras.contains(player - 1)) {
      setState(() {
        player--;
        //alvo.remove(player);
        //somAlvo.play(AssetSource('sounds/pellet.wav'));
        comeralvo(player);
        direcao = 'esquerda';
        bocaFechada = !bocaFechada;

        if (player == 33) {
          portal(43);
        }

        if (player == 110) {
          portal(120);
        }

        posicaoFantasmaVermelho = moveFantasma(posicaoFantasmaVermelho);
        posicaoFantasmaVerde = moveFantasma(posicaoFantasmaVerde);
        posicaoFantasmaRosa = moveFantasma(posicaoFantasmaRosa);
        posicaoFantasmaAmarelo = moveFantasma(posicaoFantasmaAmarelo);
      });
    }
    if (morte == true) {
      recarregarTela();
    }
  }

  void moveDireita() {
    if (!barreiras.contains(player + 1)) {
      setState(() {
        player++;
        //alvo.remove(player);
        //somAlvo.play(AssetSource('sounds/pellet.wav'));
        comeralvo(player);
        direcao = 'direita';
        bocaFechada = !bocaFechada;

        if (player == 43) {
          portal(33);
        }

        if (player == 120) {
          portal(110);
        }
        posicaoFantasmaVermelho = moveFantasma(posicaoFantasmaVermelho);
        posicaoFantasmaVerde = moveFantasma(posicaoFantasmaVerde);
        posicaoFantasmaRosa = moveFantasma(posicaoFantasmaRosa);
        posicaoFantasmaAmarelo = moveFantasma(posicaoFantasmaAmarelo);
      });
    }
    if (morte == true) {
      recarregarTela();
    }
  }

  void moveCima() {
    if (!barreiras.contains(player - numeroColunas)) {
      setState(() {
        player -= numeroColunas;
        //alvo.remove(player);
        //somAlvo.play(AssetSource('sounds/pellet.wav'));
        comeralvo(player);
        direcao = 'cima';
        bocaFechada = !bocaFechada;
      });
      posicaoFantasmaVermelho = moveFantasma(posicaoFantasmaVermelho);
      posicaoFantasmaVerde = moveFantasma(posicaoFantasmaVerde);
      posicaoFantasmaRosa = moveFantasma(posicaoFantasmaRosa);
      posicaoFantasmaAmarelo = moveFantasma(posicaoFantasmaAmarelo);
    }
    if (morte == true) {
      recarregarTela();
    }
  }

  void moveBaixo() {
    if (!barreiras.contains(player + numeroColunas)) {
      setState(() {
        player += numeroColunas;
        //alvo.remove(player);
        //somAlvo.play(AssetSource('sounds/pellet.wav'));
        comeralvo(player);
        direcao = 'baixo';
        bocaFechada = !bocaFechada;
      });
      posicaoFantasmaVermelho = moveFantasma(posicaoFantasmaVermelho);
      posicaoFantasmaVerde = moveFantasma(posicaoFantasmaVerde);
      posicaoFantasmaRosa = moveFantasma(posicaoFantasmaRosa);
      posicaoFantasmaAmarelo = moveFantasma(posicaoFantasmaAmarelo);
    }
    if (morte == true) {
      recarregarTela();
    }
  }

  void recarregarTela() {

    if (morte == false) {
      somAbertura.play(AssetSource('sounds/begin.wav'));
    }

    player = numeroColunas * 12 + 1;
    posicaoFantasmaVermelho = 12;
    posicaoFantasmaVerde = 20;
    posicaoFantasmaRosa = 141;
    posicaoFantasmaAmarelo = 60;
    alvo = [];
    pegarAlvo();
    direcao = 'direita';
    bocaFechada = false;
    morte = false;
    setState(() {});
  }

  bool morte = false;
  final somAbertura = AudioPlayer();
  final somMorte = AudioPlayer();
  final somAlvo = AudioPlayer();

  checarMorte(int posicaoFantasma) {
    if (posicaoFantasma == player) {
      somMorte.play(AssetSource('sounds/die.wav'));

      morte = true;
      return true;
    } else {
      return false;
    }
  }

  moveFantasma(int posicaoFantasma) {
    for (int i = 1; i < 4; i++) {
      bool movimento = false;

      while (movimento == false && checarMorte(posicaoFantasma) == false) {
        int valorAleatorio = Random().nextInt(4);

        switch (valorAleatorio) {
          case 0: //move direita
            if (!barreiras.contains(posicaoFantasma + 1)) {
              posicaoFantasma++;
              movimento = true;
            }
            break;

          case 1: //move cima
            if (!barreiras.contains(posicaoFantasma - numeroColunas)) {
              posicaoFantasma -= numeroColunas;
              movimento = true;
            }
            break;

          case 2: // move esqueda
            if (!barreiras.contains(posicaoFantasma - 1)) {
              posicaoFantasma--;
              movimento = true;
            }
            break;

          case 3: // move baixo
            if (!barreiras.contains(posicaoFantasma + numeroColunas)) {
              posicaoFantasma += numeroColunas;
              movimento = true;
            }
            break;
        }
      }
      if (i == 3) {
        checarMorte(posicaoFantasma);
      }
    }
    return posicaoFantasma;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            //expande para o tamanho máximo da tela
            flex: 6, //proporção 1/6 para os demais widget

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
                } else if (posicaoFantasmaVermelho == index) {
                  return MyGhostVermelho();
                } else if (posicaoFantasmaVerde == index) {
                  return MyGhostVerde();
                } else if (posicaoFantasmaRosa == index) {
                  return MyGhostRosa();
                } else if (posicaoFantasmaAmarelo == index) {
                  return MyGhostAmarelo();
                } else if (barreiras.contains(index)) {
                  return Mypixel(
                      innerColor: Colors.blue[100],
                      outerColor: Colors.blue[900]);
                  //child: Text(index.toString()));
                }

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
                  onTap: recarregarTela,
                  child: Text('PLAY',
                      style: TextStyle(color: Colors.yellow, fontSize: 40))),
              GestureDetector(
                  onTap: moveEsquerda,
                  child: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.yellow,
                    size: 70,
                  )),
              GestureDetector(
                  onTap: moveDireita,
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.yellow,
                    size: 70,
                  )),
              GestureDetector(
                  onTap: moveCima,
                  child: Icon(
                    Icons.arrow_circle_up,
                    color: Colors.yellow,
                    size: 70,
                  )),
              GestureDetector(
                  onTap: moveBaixo,
                  child: Icon(
                    Icons.arrow_circle_down,
                    color: Colors.yellow,
                    size: 70,
                  ))
            ],
          )),
        ],
      ),
    );
  }
}
