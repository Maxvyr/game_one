import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class ScoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  ScoreText(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center, //centrer
      textDirection: TextDirection.ltr, //de droite a gauche
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    //si le painter qui affiche le text n'est pas égale au score actuelle alors on met  jour le score
    if ((painter.text ?? "") != gameController.score.toString()) {
      painter.text = TextSpan(
        text: gameController.score.toString(),
        style: TextStyle(
          color: textColor,
          fontSize: 70.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2 - painter.width / 2),
        (gameController.screenSize.height * 0.18 - painter.width / 2),
      );
    }
  }
}
