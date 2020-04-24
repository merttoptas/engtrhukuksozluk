import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class BackendFlipCard extends StatelessWidget {

  BackendFlipCard({@required this.cardKey,this.text,this.onButton2Press,this.onButton3Press});

  final Function onButton2Press,onButton3Press;
  final String text;
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    double heightSize(double value){
      value /= 100;
      return MediaQuery.of(context).size.height * value;
    }

    double widthSize(double value ){
      value /=100;
      return MediaQuery.of(context).size.width * value;
    }
    return Padding(
      padding: const EdgeInsets.only(top:50.0, left: 30.0,right: 30.0, bottom: 10.0),
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
                height: heightSize(16),
                decoration: BoxDecoration(
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width -10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                              FittedBox(
                            fit: BoxFit.fitWidth,
                              child: Text(text,
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: heightSize(2.5),
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5.0),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          addButton(AppConstant.btnLearn, onButton3Press, heightSize(2)),
                          Spacer(),
                          addButton(AppConstant.btnNotLearn, onButton2Press, heightSize(2)),

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

addButton(String label, Function onPressed, double height){
  return FlatButton(
    onPressed: onPressed,
    child: Text(label, style: TextStyle(fontSize: height, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 1.2
    ) ),
  );
}
