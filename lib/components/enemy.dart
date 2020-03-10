import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class Enemy {
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  bool isDead = false;

  Enemy(this.gameController, double x, double y) {
    health = 2;
    damage = 1;
    //vitesse qui correspond a 2 fois sa taille
    speed = gameController.tileSize * 2;
    enemyRect = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * 1.2,
      gameController.tileSize * 1.2,
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
    c.drawRect(enemyRect, enemyColor);
  }

  //déplacement
  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      //la position qu'il doit viser le centre du player (mais on soustrait le centre de l'enemy pour que le centre de l'enemy vise bien le centre du player et non le top de l'enemy)
      Offset positionPlayer = gameController.player.playerRect.center - enemyRect.center;
      //tant que enemy pas au bord du player il continu d'avancer
      if (stepDistance <= (positionPlayer.distance - gameController.tileSize *1.2)) {
        Offset stepToPositionPlayer = Offset.fromDirection(
          positionPlayer.direction,
          stepDistance,
        );
        //la méthode shift permet de déplacer le widget (ici l'enemy) a l'ensroit spécifier
        enemyRect = enemyRect.shift(stepToPositionPlayer);
      } else {
        //si enemy sur le player alors il l'attaque
        attack();
      }
    }
  }

  //fonction attack player
  // si le player n'est pas mort alors on soustrait de sa currentlife la valeur dommage de l'enemy
  void attack() {
    if (!gameController.player.isDead) {
      gameController.player.currentHealth -= damage;
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
