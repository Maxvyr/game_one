import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class HealthBar {
  final GameController gameController;
  RRect healthBarRect;
  RRect remainingHealthRect;
  // 2 barre vert et rouge la verte et sur la rouge et elle disparait au fur et mesure que la vie du player descend

  //variable repeat
  double radiusBar = 8.0;
  double pourcentageHeightPositionBar = 0.05;
  double pourcentageWidthPositionBar = 0.1;
  double pourcentageHeightBar = 0.5;
  double pourcentageWidthBar = 0.5;


  HealthBar(this.gameController) {
    double barWidth = gameController.screenSize.width *pourcentageWidthBar;

    //barre rouge
    healthBarRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        gameController.screenSize.width*pourcentageWidthPositionBar, 
        gameController.screenSize.height * pourcentageHeightPositionBar,
        barWidth,
        gameController.tileSize * pourcentageHeightBar,
      ),
      Radius.circular(radiusBar),
    );
    //barre verte au départ
    remainingHealthRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        gameController.screenSize.width*pourcentageWidthPositionBar,
        gameController.screenSize.height * pourcentageHeightPositionBar,
        barWidth,
        gameController.tileSize * pourcentageHeightBar,
      ),
      Radius.circular(radiusBar),
    );
  }

  void render(Canvas c) {
    Paint healthBarColor = Paint()..color = red;
    Paint remainingBarColor = Paint()..color = green;
    c.drawRRect(healthBarRect, healthBarColor);
    c.drawRRect(remainingHealthRect, remainingBarColor);
  }

  void update(double t) {
    double barWidth = gameController.screenSize.width *pourcentageWidthBar;
    double pourcentageHealth = gameController.ninjaPlayer.currentHealth /
        gameController.ninjaPlayer.maxHealth;
    //decrease green bar
    remainingHealthRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        gameController.screenSize.width*pourcentageWidthPositionBar,
        gameController.screenSize.height * pourcentageHeightPositionBar,
        barWidth * pourcentageHealth,
        gameController.tileSize * pourcentageHeightBar,
      ),
      Radius.circular(radiusBar),
    );
  }
}
