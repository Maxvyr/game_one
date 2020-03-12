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
    double widthArmsLegs = 10;
    double heightLegs = 20;
    double heightArms = 10;
    double eyesSizeInside = 2.5;
    double eyesSizeOutside = 5;
    //vitesse qui correspond a 2 fois sa taille
    speed = gameController.tileSize * 2;
    enemyBody = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * 1.2,
      gameController.tileSize * 1.2,
    );
    //arm left
    enemyArmsL = Rect.fromLTWH(
      x,
      y,
      widthArmsLegs,
      heightArms,
    );
    //arm right
    enemyArmsR = Rect.fromLTWH(
      x,
      y,
      widthArmsLegs,
      heightArms,
    );
    //leg left
    enemyLegsL = Rect.fromLTWH(
      x,
      y,
      widthArmsLegs,
      heightLegs,
    );
    //leg right
    enemyLegsR = Rect.fromLTWH(      
      x,
      y,
      widthArmsLegs,
      heightLegs,
    );
    //head
    enemyHead = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * 1.2,
      10,
    );
    //eyes 1 Inside
    enemyEyesOneI = Rect.fromLTWH(
      x,
      y,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 1 Outside
    enemyEyesOneO = Rect.fromLTWH(
      x,
      y,
      eyesSizeOutside,
      eyesSizeOutside,
    );
    //eyes 2 Inside
    enemyEyesTwoI = Rect.fromLTWH(
      x,
      y,
      eyesSizeInside,
      eyesSizeInside,
    );
    //eyes 2 Outside
    enemyEyesTwoO = Rect.fromLTWH(
      x,
      y,
      eyesSizeOutside,
      eyesSizeOutside,
    );
  }

  void render(Canvas c) {
    //change de couleur en fonction de son niveau de vie
    Color colorEnemyFctLife;
    switch (health) {
      case 1:
        colorEnemyFctLife = enemyColorMin;
        break;
      case 2:
        colorEnemyFctLife = enemyColorMax;
        break;
      default:
        colorEnemyFctLife = Colors.red;
        break;
    }
    Paint enemyColor = Paint()..color = colorEnemyFctLife;
    c.drawRect(enemyBody, enemyColor);
    /*c.drawRect(enemyArmsL, enemyColor);
    c.drawRect(enemyArmsR, enemyColor);
    c.drawRect(enemyLegsL, enemyColor);
    c.drawRect(enemyLegsR, enemyColor);*/
    Paint colorHead = Paint()..color = face;
    c.drawRect(enemyHead, colorHead);
    /*Paint colorEyesB = Paint()..color = black;
    c.drawRect(enemyEyesOneO, colorEyesB);
    c.drawRect(enemyEyesTwoO, colorEyesB);
    Paint colorEyesW = Paint()..color = white;
    c.drawRect(enemyEyesOneI, colorEyesW);
    c.drawRect(enemyEyesTwoI, colorEyesW);*/
  }

  //déplacement
  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      //la position qu'il doit viser le centre du player (mais on soustrait le centre de l'enemy pour que le centre de l'enemy vise bien le centre du player et non le top de l'enemy)
      Offset positionPlayer = gameController.ninjaPlayer.playerBody.center - enemyBody.center;
      //tant que enemy pas au bord du player il continu d'avancer
      if (stepDistance <= (positionPlayer.distance - gameController.tileSize *1.2)) {
        Offset stepToPositionPlayer = Offset.fromDirection(
          positionPlayer.direction,
          stepDistance,
        );
        //la méthode shift permet de déplacer le widget (ici l'enemy) a l'ensroit spécifier
        enemyBody = enemyBody.shift(stepToPositionPlayer);
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
        if (gameController.score > (gameController.storage.getInt("highscore")?? 0)) { 
          gameController.storage.setInt("highscore", gameController.score);
        }
      }
    }
  }
}
