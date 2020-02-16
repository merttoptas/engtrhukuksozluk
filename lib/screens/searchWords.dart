import 'package:flutter/material.dart';

class SearchWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(onTap: (){},
                controller: null,
                decoration: InputDecoration(
                  hintText: 'Arama',
                  focusColor: Color(0XFF2A2E43),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 8.0,right: 8.0),
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
                                      child: Text('Main English Title', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.0,),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                                      child: Text('Sub Turkish Title', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
