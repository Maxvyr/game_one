import 'package:flutter/material.dart';
import '../controller/colors.dart';
import '../game_controller.dart';

class StartText {
  final GameController gameController;
  TextPainter painter;
  RRect btStart;
  Offset position;

  StartText(this.gameController) {    
  double widthButton = gameController.screenSize.width*0.5;
  double heightButton = gameController.screenSize.height*0.1;
    //texte start
    painter = TextPainter(
      textAlign: TextAlign.center, 
      textDirection: TextDirection.ltr, 
    );
    //bouton Start
    btStart = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        gameController.screenSize.width *0.5 - widthButton / 2,
        gameController.screenSize.height * 0.77 - heightButton / 2,
        widthButton,
        heightButton,
      ),
      Radius.circular(50.0),
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    final color =Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = white;
    c.drawRRect(btStart, color);
    painter.paint(c, position);
  }

  void update(double t) {
      painter.text = TextSpan(
        text: "Start",
        style: TextStyle(
          color: textColor,
          fontSize: 50.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2 - painter.width / 2),
        (gameController.screenSize.height * 0.8 - painter.width / 2),
      );
    }
  }