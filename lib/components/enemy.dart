import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class Enemy {
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyBody;
  Rect enemyArmsL;
  Rect enemyArmsR;
  Rect enemyLegsL;
  Rect enemyLegsR;
  Rect enemyHead;
  Rect enemyEyesOneI;
  Rect enemyEyesTwoI;
  Rect enemyEyesOneO;
  Rect enemyEyesTwoO;
  bool isDead = false;

  Enemy(this.gameController, double x, double y) {
    health = 2;
    damage = 1;
    double widthEnemy = 0.8;
    double positionYHeadAndEyes = 8;
    double positionYArms = 18;
    double widthArmsLegs = 8;
    double heightLegs = 12;
    double heightArms = 8;
    double eyesSizeInside = 2.5;
    double eyesSizeOutside = 5;
    //vitesse qui correspond a 2 fois sa taille
    speed = gameController.tileSize * 2;
    enemyBody = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * widthEnemy,
      gameController.tileSize * widthEnemy,
    );
    //arm left
    enemyArmsL = Rect.fromLTWH(
      x + (gameController.tileSize * widthEnemy),
      y + positionYArms,
      widthArmsLegs,
      heightArms,
    );
    //arm right
    enemyArmsR = Rect.fromLTWH(
      x - widthArmsLegs,
      y + positionYArms,
      widthArmsLegs,
      heightArms,
    );
    //leg left
    enemyLegsL = Rect.fromLTWH(
      x + (gameController.tileSize * 0.5),
      y + gameController.tileSize * 0.8,
      widthArmsLegs,
      heightLegs,
    );
    //leg right
    enemyLegsR = Rect.fromLTWH(
      x + (gameController.tileSize * 0.1),
      y + gameController.tileSize * 0.8,
      widthArmsLegs,
      heightLegs,
    );
    //head
    enemyHead = Rect.fromLTWH(
      x,
      y + positionYHeadAndEyes,
      gameController.tileSize * widthEnemy,
      10,
    );
    //eyes 1 Inside
    enemyEyesOneI = Rect.fromLTWH(
      x + gameController.tileSize * 0.2,
      y + positionYHeadAndEyes,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 1 Outside
    enemyEyesOneO = Rect.fromLTWH(
      x + gameController.tileSize * 0.2,
      y + positionYHeadAndEyes,
      eyesSizeOutside,
      eyesSizeOutside,
    );
    //eyes 2 Inside
    enemyEyesTwoI = Rect.fromLTWH(
      x + gameController.tileSize * 0.6,
      y + positionYHeadAndEyes,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 2 Outside
    enemyEyesTwoO = Rect.fromLTWH(      
      x + gameController.tileSize * 0.6,
      y + positionYHeadAndEyes,
      eyesSizeOutside,
      eyesSizeOutside,
    );
  }

  void render(Canvas c) {
    //change de couleur en fonction de son niveau de vie
    Color colorEnemyFctLife;
    Color colorHeadFctLife;;
    switch (health) {
      case 1:
        colorEnemyFctLife = enemyColorMin;
        colorHeadFctLife = colorFaceMin;
        break;
      case 2:
        colorEnemyFctLife = enemyColorMax;
        colorHeadFctLife = colorFaceMax;
        break;
      default:
        colorEnemyFctLife = Colors.red;
        break;
    }
    Paint enemyColor = Paint()..color = colorEnemyFctLife;
    c.drawRect(enemyBody, enemyColor);
    c.drawRect(enemyArmsL, enemyColor);
    c.drawRect(enemyArmsR, enemyColor);
    c.drawRect(enemyLegsL, enemyColor);
    c.drawRect(enemyLegsR, enemyColor);
    Paint colorHead = Paint()..color = colorHeadFctLife;
    c.drawRect(enemyHead, colorHead);
    Paint colorEyesB = Paint()..color = black;
    c.drawRect(enemyEyesOneO, colorEyesB);
    c.drawRect(enemyEyesTwoO, colorEyesB);
    Paint colorEyesW = Paint()..color = white;
    c.drawRect(enemyEyesOneI, colorEyesW);
    c.drawRect(enemyEyesTwoI, colorEyesW);
  }

  //déplacement
  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      //la position qu'il doit viser le centre du player (mais on soustrait le centre de l'enemy pour que le centre de l'enemy vise bien le centre du player et non le top de l'enemy)
      Offset positionPlayer =
          gameController.ninjaPlayer.playerBody.center - enemyBody.center;
      //tant que enemy pas au bord du player il continu d'avancer
      if (stepDistance <=
          (positionPlayer.distance - gameController.tileSize * 1.2)) {
        Offset stepToPositionPlayer = Offset.fromDirection(
          positionPlayer.direction,
          stepDistance,
        );
        //la méthode shift permet de déplacer le widget (ici l'enemy) a l'ensroit spécifier
        enemyBody = enemyBody.shift(stepToPositionPlayer);
        enemyArmsL = enemyArmsL.shift(stepToPositionPlayer);
        enemyArmsR = enemyArmsR.shift(stepToPositionPlayer);
        enemyLegsL = enemyLegsL.shift(stepToPositionPlayer);
        enemyLegsR = enemyLegsR.shift(stepToPositionPlayer);
        enemyHead = enemyHead.shift(stepToPositionPlayer);
        enemyEyesOneI = enemyEyesOneI.shift(stepToPositionPlayer);
        enemyEyesOneO = enemyEyesOneO.shift(stepToPositionPlayer);
        enemyEyesTwoI = enemyEyesTwoI.shift(stepToPositionPlayer);
        enemyEyesTwoO = enemyEyesTwoO.shift(stepToPositionPlayer);
      } else {
        //si enemy sur le player alors il l'attaque
        attack();
      }
    }
  }

  //fonction attack player
  // si le player n'est pas mort alors on soustrait de sa currentlife la valeur dommage de l'enemy
  void attack() {
    if (!gameController.ninjaPlayer.isDead) {
      gameController.ninjaPlayer.currentHealth -= damage;
    }
  }

  //gestion enemy death
  void onTapDown() {
    if (!isDead) {
      health--;
      if (health <= 0) {
        isDead = true;
        gameController.score++; //when kill enemy incremetn score
        //comparer le score courant ou meilleur score
        // sir le score en cour est plus grand que le score stock avec SharedPref alor on le stock a la place sinon non
        //subtilite les ?? 0 veut dire que si il n"y a pas de valeur sotcker dans highscore alors on met 0 a la place (utile pour la première fois)
        if (gameController.score >
            (gameController.storage.getInt("highscore") ?? 0)) {
          gameController.storage.setInt("highscore", gameController.score);
        }
      }
    }
  }
}
