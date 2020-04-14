import 'package:engtrhukuksozluk/model/Favorite.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM favorite')
  Future<List<Favorite>> getAllFavoriteWords();

  @Query('SELECT * FROM favorite WHERE favId = :favWord')
  Future<List<Favorite>> getId(int favWord);

  @Query('SELECT * FROM favorite')
  Stream<List<Favorite>> findAllFavoriteStream();

  @Query('SELECT * FROM favorite WHERE favWordsEng = :favWordsEng')
  Future<List<Favorite>> findFavoriteWord(String favWordsEng );

  @insert
  Future<void> insertFavoriteWord(Favorite favorite);

  @delete
  Future<void> deleteFavWord(Favorite favorite);

  @delete
  Future<void> deleteFavWords(List<Favorite> favorite);

}