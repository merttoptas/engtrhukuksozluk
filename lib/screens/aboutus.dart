import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0XFF2A2E43),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Positioned(
                  top: 75.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height -100.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: (MediaQuery.of(context).size.width/2)-100,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/aboutus.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
                Positioned(
                  top: 240.0,
                  left: 25.0,
                  right: 25.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Hakkımızda', style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600, letterSpacing: 1.4),),
                      SizedBox(height: 15.0,),
                      Text('Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. '
                          'Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere'
                          ' bir yazı galerisini alarak karıştırdığı 1500\'lerden beri endüstri standardı sahte metinler'
                          ' olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pe'
                          'k değişmeden elektronik dizgiye de sıçramıştır. 1960\'larda Lorem Ipsum pasajları da içeren Letraset y'
                          'apraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masa'
                          'üstü yayıncılık yazılımları ile popüler olmuştur.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2),),
                      SizedBox(height: 15.0,),
                      Container(
                        height: 150.0,
                        width: 350.0,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0XFF2A2E43),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text('deneme',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
