import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class HealthBar {
  final GameController gameController;
  Rect healthBarRect;
  Rect remainingHealthRect;
  // 2 barre vert et rouge la verte et sur la rouge et elle disparait au fur et mesure que la vie du player descend

  HealthBar(this.gameController) {
    double barWidth = gameController.screenSize.width * 0.75;

    //barre rouge
    healthBarRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.93,
      barWidth,
      gameController.tileSize * 0.5,
    );
    //barre verte au départ
    remainingHealthRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.93,
      barWidth,
      gameController.tileSize * 0.5,
    );
  }


  void render (Canvas c) {
    Paint healthBarColor = Paint()..color = red;
    Paint remainingBarColor = Paint()..color = green;
    c.drawRect(healthBarRect, healthBarColor);
    c.drawRect(remainingHealthRect, remainingBarColor);
  }

  void update (double t) {
    double barWidth = gameController.screenSize.width *0.75;
    double pourcentageHealth = gameController.player.currentHealth / gameController.player.maxHealth;
    //decrease green bar
    remainingHealthRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.93,
      barWidth * pourcentageHealth,
      gameController.tileSize * 0.5,
    );
  }
}
