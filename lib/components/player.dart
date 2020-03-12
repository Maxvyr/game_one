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
  Rect playerEyesOneI;
  Rect playerEyesTwoI;
  Rect playerEyesOneO;
  Rect playerEyesTwoO;
  bool isDead = false;

  NinjaPlayer(this.gameController) {
    //au démarrage la vie max et la current life sont = toute les 2 et on set la val aprés
    maxHealth = currentHealth = 300;
    //création de la taille du player qui dépendra de l'écran car appel fonction tileSize qui dépend de chaque écran ou est jouer le game
    final size = gameController.tileSize;
    double widthArmsLegs = 10;
    double heightLegs = 20;
    double heightArms = 10;
    double eyesSizeInside = 2.5;
    double eyesSizeOutside = 5;
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
    //eyes 1 Inside
    playerEyesOneI = Rect.fromLTWH(
      gameController.screenSize.width / 2 - 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 1 Outside
    playerEyesOneO = Rect.fromLTWH(
      gameController.screenSize.width / 2 - 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSizeOutside,
      eyesSizeOutside,
    );
    //eyes 2 Inside
    playerEyesTwoI = Rect.fromLTWH(
      gameController.screenSize.width / 2 + 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 2 Outside
    playerEyesTwoO = Rect.fromLTWH(
      gameController.screenSize.width / 2 + 10,
      gameController.screenSize.height / 2 - size / 4,
      eyesSizeOutside,
      eyesSizeOutside,
    );
  }

  //créer le payer le carré de couleru bleu
  void render(Canvas c) {
    Paint colorBody = Paint()..color = playerColor;
    c.drawRect(playerBody, colorBody);
    c.drawRect(playerArmsL, colorBody);
    c.drawRect(playerArmsR, colorBody);
    c.drawRect(playerLegsL, colorBody);
    c.drawRect(playerLegsR, colorBody);
    Paint colorHead = Paint()..color = face;
    c.drawRect(playerHead, colorHead);
    Paint colorEyesB = Paint()..color = black;
    c.drawRect(playerEyesOneO, colorEyesB);
    c.drawRect(playerEyesTwoO, colorEyesB);
    Paint colorEyesW = Paint()..color = white;
    c.drawRect(playerEyesOneI, colorEyesW);
    c.drawRect(playerEyesTwoI, colorEyesW);
  }

  void update(double t) {
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController
          .initialize(); //joueur meurt on init tout le programme - re start
    }
  }
}
