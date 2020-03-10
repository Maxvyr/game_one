import 'dart:math';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './components/start_text.dart';
import './components/highscore_text.dart';
import './components/score_text.dart';
import './components/enemy.dart';
import './components/health_bar.dart';
import 'enemy_spawner.dart';
import 'state.dart' as ste;

import 'components/player.dart';

class GameController extends Game {
  final SharedPreferences storage;
  Random random;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner enemySpawner;
  List<Enemy>
      enemies; //pour avoir plusieur enemy il faut créer une liste d'enemy
  HealthBar healthBar;
  int score;
  ScoreText scoreText;
  ste.State state;
  HighScoreText highScoreText;
  StartText startText;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = ste.State.menu;
    random = Random();
    player = Player(this);
    enemies = List<Enemy>(); //créer liste d'ennemy vide
    enemySpawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    score = 0; //init score player
    scoreText = ScoreText(this);
    highScoreText = HighScoreText(this);
    startText =StartText(this);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroudnPaint = Paint()..color = Colors.white;
    //affiche le fond
    c.drawRect(background, backgroudnPaint);

    //affiche le player
    player.render(c);

    if (state == ste.State.menu) {
      startText.render(c);
      highScoreText.render(c);
    } else if (state == ste.State.playing) {
      //affiche tout les enemies de la liste avec  forEach
      enemies.forEach((Enemy enemy) => enemy.render(c));

      //affiche le score
      scoreText.render(c);

      //affiche bar de vie
      healthBar.render(c);
    }
  }

  //maj dans le temps des composant
  void update(double t) {
    if (state == ste.State.menu) {
      startText.update(t);
      highScoreText.update(t);
    } else if (state == ste.State.playing) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      //delete enemy when is Dead => for do that when the enemy is dead is delete from the list so is not render anymore
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  //fonction click on screen to decrease enemy life when calling fonction enemy.onTapDown
  void onTapDown(TapDownDetails d) {
    if (state == ste.State.menu) {
      state = ste.State.playing;
    } else if (state == ste.State.playing) {
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
  }

  //create random enemy
  void spawnEnemy() {
    double x, y;
    //switc avec 4 position qui représente chacune les 4 coté du smartphone générer aléatoirement avec le nombre random
    switch (random.nextInt(4)) {
      case 0:
        //top
        x = random.nextDouble() *
            screenSize
                .width; //génére un nombre positif en x pour sur la largeur du smartphone
        y = -tileSize *
            2.5; //nombre neg pour que l'enemy apparaissent en dehors de l'écran
        break;
      case 1:
        //right
        x = screenSize.width +
            tileSize *
                2.5; //génére un valeur x supérieur a la largeur de l'écran pour qu'il apparaissent en dehors a droite
        y = random.nextDouble() *
            screenSize
                .height; //génére un nombre positif en x pour sur la hauteur du smartphone
        break;
      case 2:
        //bottom
        x = random.nextDouble() * screenSize.width;
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        //left
        x = -tileSize * 2.5;
        y = random.nextDouble() * screenSize.height;
        break;
    }
    //ajouter un nouvelle ennemy au tableau
    enemies.add(Enemy(this, x, y));
  }
}
