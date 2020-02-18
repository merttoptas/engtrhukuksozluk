import 'package:cloud_firestore/cloud_firestore.dart';

class Words {
   String id;
   String english;
   String turkish;

   Words({this.english, this.turkish, this.id});

   Map<String, dynamic> toMap() {
      return {
         'id': id,
         'english': english,
         'turkish': turkish,
      };
   }

   Words.fromMap(Map<String, dynamic> map)
       : id =map['id'],
          english = map['english'],
          turkish = map['turkish'];

   @override
   String toString() {
      return 'Words{id: $id, english: $english, turkish: $turkish}';
   }

}
