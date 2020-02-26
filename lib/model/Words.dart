import 'package:cloud_firestore/cloud_firestore.dart';

class Words {
   int id;
   String english;
   String turkish;

   Words({this.english, this.turkish, this.id});

   Map<Object, dynamic> toMap() {
      return {
         'id': id,
         'english': english,
         'turkish': turkish,
      };
   }

   Words.fromMap(Map<Object, dynamic> map)
       :  id = map['id'],
          english = map['english'],
          turkish = map['turkish'];



   @override
   String toString() {
      return 'Words{id: $id, english: $english, turkish: $turkish}';
   }

}
