import './components/enemy.dart';
import 'game_controller.dart';

class EnemySpawner {

  final GameController gameController;
  final int maxSpawnInterval = 3500; //écart max entre chaque apparition
  final int minSpawnInterval = 700; //écart min entre chaque apparition
  final int intervalChange = 5;
  final int maxEnemies = 7;
  int currentInterval;
  int nextSpan;

  EnemySpawner(this.gameController){
    initialize();
  }

  void initialize() {
    killAllEnemies();
    currentInterval = maxSpawnInterval; 
    nextSpan = DateTime.now().millisecondsSinceEpoch + currentInterval; //prochaine apparition est égale a  now en millisecond + l'interval courant => est un timer tout simple 
  }

  //démarrage du jeu tue tout les enemy pour les faires disparaitrent
  void killAllEnemies() {
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update (double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    //Si le nombre d'ennemis max est inf a enemis présent (longueur liste) et que le temps de l'apparition suivante est passé alors on appel la fonction qui génére des enemies aléatoire
    if (gameController.enemies.length < maxEnemies && now >= nextSpan) {
      gameController.spawnEnemy();
      // Si l'interval courant entre chaque apparition est sup au mini interval alors on le diminue de la valeur interval change (permet d'accélerer nombre apparition pour augmenter difficulté)
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      //maj valeur prochaine apparition 
      nextSpan = now + currentInterval;
    }
  }
}