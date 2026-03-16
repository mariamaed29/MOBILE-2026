import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  int pontosJogador = 0;
  int pontosComputador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mini Game"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Placar",
              style: TextStyle(fontSize: 28),
            ),

            SizedBox(height: 10),

            Text(
              "Você: $pontosJogador   |   Computador: $pontosComputador",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 40),

            Icon(
              Icons.help_outline,
              size: 120,
            ),

            SizedBox(height: 20),

            Text(
              "Escolha sua jogada",
              style: TextStyle(fontSize: 22),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Pedra"),
                ),

                SizedBox(width: 20),

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Papel"),
                ),

                SizedBox(width: 20),

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Tesoura"),
                ),

              ],
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: Text("Resetar Placar"),
            )

          ],
        ),
      ),
    );
  }
}