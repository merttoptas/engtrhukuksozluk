import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class backendFlipCard extends StatelessWidget {
  final Function onButton2Press,onButton3Press;
  backendFlipCard({@required this.cardKey,this.text,this.onButton2Press,this.onButton3Press});
  String text;
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150.0,
                decoration: BoxDecoration(
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(text,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          addButton('BİLİYORUM', onButton3Press),
                          Spacer(),
                          addButton('BİLMİYORUM', onButton2Press),

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

addButton(String label, Function onPressed){
  return FlatButton(
    onPressed: onPressed,
    child: Text(label, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: 1.2
    ) ),
  );
}
