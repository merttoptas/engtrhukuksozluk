import 'package:flutter/material.dart';

import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flip_card/flip_card.dart';

class FrontFlipCard extends StatelessWidget {
  FrontFlipCard({Key key, this.text, this.cardKey}): super(key:key);
  final String text;
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:80.0, left: 30.0,right: 30.0, bottom: 20.0),
      child: GestureDetector(
        child: InkWell(
          onTap: (){
            cardKey.currentState.toggleCard();
          },
          child: Card(
            color: Color(0XFF78aaff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(text,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,letterSpacing: 1.2
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10.0),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(AppConstant.btnMeaning,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
