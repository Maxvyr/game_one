import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class Ninja {
  final GameController gameController;
  int maxHealth;
  int currentHealth;
  Rect playerRect;
  Image player;
  bool isDead = false;

  Ninja(this.gameController) {
    //au démarrage la vie max et la current life sont = toute les 2 et on set la val aprés
    maxHealth = currentHealth = 300;
    //création de la taille du player qui dépendra de l'écran car appel fonction tileSize qui dépend de chaque écran ou est jouer le game
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(
      //créer le player au centre du screen
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 2,
      size,
      size,
    );
    player = Image.asset("assets/ninja_small.png");
  }

  //créer le payer le carré de couleru bleu
  void render (Canvas c) {
    Paint color =  Paint()..color = playerColor;
    c.drawRect(playerRect, color);
    // c.drawImage(player, Offset.zero, color);
  }

  void update (double t) {
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.initialize(); //joueur meurt on init tout le programme - re start
    }
  }
}
