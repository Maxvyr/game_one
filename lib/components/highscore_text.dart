import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class HighScoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;
  double pourcentageHeigth = 0.15;

  HighScoreText(this.gameController) {
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
    int highscore = gameController.storage.getInt("highscore") ?? 0;
      painter.text = TextSpan(
        text: "HighScore : $highscore",
        style: TextStyle(
          color: textColor,
          fontSize: 40.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2 - painter.width / 2),
        (gameController.screenSize.height * pourcentageHeigth),
      );
    }
}
