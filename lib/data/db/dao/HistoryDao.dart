import 'package:engtrhukuksozluk/model/history.dart';
import 'package:floor/floor.dart';

@dao
abstract class HistoryDao {
  @Query('SELECT * FROM history')
  Future<List<History>> getAllHistoryWords();

  @Query('SELECT * FROM history WHERE historyId = :historyWord')
  Future<List<History>> getId(int historyWord);

  @Query('SELECT * FROM history')
  Stream<List<History>> findAllHistoryStream();

  @Query('DELETE FROM history')
  Future<void> deleteHistoryWord();

  @Query('SELECT * FROM history WHERE historyWord = :historyWord')
  Future<List<History>> findHistoryWord(String historyWord);

  @insert
  Future<void> insertHistoryWord(History history);

  @delete
  Future<void> deleteHistoryWords(List<History> history);
}
