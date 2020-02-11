import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:engtrhukuksozluk/widgets/frontFlipCard.dart';
import 'package:engtrhukuksozluk/widgets/backendFlipCard.dart';

class WordsLearn extends StatelessWidget {

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF2A2E43),
        title: Text('Kelime Öğrenme'),
        centerTitle: true,
      ),
      backgroundColor: Color(0XFF2A2E43),
    body: Column(
      children: <Widget>[
        FlipCard(
          key: cardKey,
          flipOnTouch: true,
          front: frontFlipCard(cardKey: cardKey,),
          back: backendFlipCard(cardKey: cardKey),
        ),
        Padding(
          padding: const EdgeInsets.only(top:20.0, left: 30.0,right: 30.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 80,
                width: 350.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:30.0,top: 10),
                              child: Text(
                                'Öğrenilen',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 5.0),
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right:30.0,top: 10),
                              child: Text(
                                'Bilinmeyen',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2
                                ),
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0,right:40.0),
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}


