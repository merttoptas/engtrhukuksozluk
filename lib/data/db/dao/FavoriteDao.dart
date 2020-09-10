import 'package:engtrhukuksozluk/model/favorite.dart';
import 'package:floor/floor.dart';
import 'package:get/get.dart';

@dao
abstract class FavoriteDao extends GetxController {
  @Query('SELECT * FROM favorite')
  Future<List<Favorite>> getAllFavoriteWords();

  @Query('SELECT * FROM favorite WHERE favId = :favWord')
  Future<List<Favorite>> getId(int favWord);

  @Query('SELECT * FROM favorite')
  Stream<List<Favorite>> findAllFavoriteStream();

  @Query('SELECT * FROM favorite WHERE favWordsEng = :favWordsEng')
  Future<List<Favorite>> findFavoriteWord(String favWordsEng);

  @insert
  Future<void> insertFavoriteWord(Favorite favorite);

  @delete
  Future<void> deleteFavWord(Favorite favorite);

  @delete
  Future<void> deleteFavWords(List<Favorite> favorite);
}