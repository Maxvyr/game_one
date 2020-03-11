import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

//variable

class NinjaPlayer {
  final GameController gameController;
  int maxHealth;
  int currentHealth;
  Rect playerBody;
  Rect playerArmsL;
  Rect playerArmsR;
  Rect playerLegsL;
  Rect playerLegsR;
  Rect playerHead;
  Rect playerEyesOne;
  Rect playerEyesTwo;
  bool isDead = false;

  NinjaPlayer(this.gameController) {
    //au démarrage la vie max et la current life sont = toute les 2 et on set la val aprés
    maxHealth = currentHealth = 300;
    //création de la taille du player qui dépendra de l'écran car appel fonction tileSize qui dépend de chaque écran ou est jouer le game
    final size = gameController.tileSize;
    double widthArmsLegs = 10;
    double heightLegs = 20;
    double heightArms = 10;
    double eyesSize = 5;
    //draw ninja
    //body
    playerBody = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 2,
      size,
      size,
    );
    //arm left
    playerArmsL = Rect.fromLTWH(
      gameController.screenSize.width / 2 + widthArmsLegs * 2,
      gameController.screenSize.height / 2,
      widthArmsLegs,
      heightArms,
    );
    //arm right
    playerArmsR = Rect.fromLTWH(
      gameController.screenSize.width / 2 - widthArmsLegs * 3,
      gameController.screenSize.height / 2,
      widthArmsLegs,
      heightArms,
    );
    //leg left
    playerLegsL = Rect.fromLTWH(
      gameController.screenSize.width / 2 + size / 2.5 - widthArmsLegs,
      gameController.screenSize.height / 2 + widthArmsLegs * 1.2,
      widthArmsLegs,
      heightLegs,
    );
    //leg right
    playerLegsR = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2.5,
      gameController.screenSize.height / 2 + widthArmsLegs * 1.2,
      widthArmsLegs,
      heightLegs,
    );
    //head
    playerHead = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 4,
      size,
      10,
    );
    //eyes 1
    playerEyesOne = Rect.fromLTWH(
      gameController.screenSize.width / 2 - 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSize,
      eyesSize,
    );
    //eyes2
    playerEyesTwo = Rect.fromLTWH(
      gameController.screenSize.width / 2 + 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSize,
      eyesSize,
    );
  }

  //créer le payer le carré de couleru bleu
  void render(Canvas c) {
    Paint color = Paint()..color = playerColor;
    c.drawRect(playerBody, color);
    c.drawRect(playerArmsL, color);
    c.drawRect(playerArmsR, color);
    c.drawRect(playerLegsL, color);
    c.drawRect(playerLegsR, color);
    Paint colorH = Paint()..color = face;
    c.drawRect(playerHead, colorH);
    Paint colorB = Paint()..color = black;
    c.drawRect(playerEyesOne, colorB);
    c.drawRect(playerEyesTwo, colorB);
  }

  void update(double t) {
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController
          .initialize(); //joueur meurt on init tout le programme - re start
    }
  }
}
