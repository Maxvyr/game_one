import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class ScoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;
  double pourcentageHeigth = 0.045;
  double pourcentageWidth = 0.65;

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
        text: "Score : ${gameController.score.toString()}",
        style: TextStyle(
          color: textColor,
          fontSize: 25.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width * pourcentageWidth),
        (gameController.screenSize.height * pourcentageHeigth),
      );
    }
  }
}
