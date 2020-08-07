import 'package:floor/floor.dart';

@entity
class History {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'historyWord')
  final String historyWord;

  @ColumnInfo(name: "historyId")
  final int historyId;

  History({this.id, this.historyWord, this.historyId});

  @override
  String toString() {
    return 'History{id: $id, historyWord: $historyWord, favId: $historyId}';
  }
}