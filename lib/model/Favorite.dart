import 'package:floor/floor.dart';

@entity
class Favorite {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(name: 'favWordsEng')
  final String english;

  @ColumnInfo(name: "favWordsTr")
  final String turkish;

  @ColumnInfo(name: "favId")
  final int favId;



  Favorite({this.id,this.turkish, this.english,this.favId});

  @override
  String toString() {
    return 'Favorite{id: $id, turkish: $turkish, english: $english, favId: $favId}';
  }
}