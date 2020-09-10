import 'package:engtrhukuksozluk/data/db/dao/historyDao.dart';
import 'package:engtrhukuksozluk/model/history.dart';
import 'package:engtrhukuksozluk/utils/app_const.dart';
import 'package:flutter/material.dart';

class HistoryBodyList extends StatelessWidget {
  HistoryBodyList(
      {Key key,
      @required this.history,
      @required this.historyDao,
      this.onPressed})
      : super(key: key);

  final History history;
  final HistoryDao historyDao;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 24, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppConstant.historyTitle),
              FlatButton(
                  onPressed: onPressed, child: Text(AppConstant.historyBtn))
            ],
          ),
        ),
        StreamBuilder<List<History>>(
            stream: historyDao?.findAllHistoryStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                final history = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: history.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    history[index].historyWord,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }
}
