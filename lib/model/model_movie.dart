import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String? title;
  final String? keyword;
  final String? poster;
  final bool? like;
  final DocumentReference reference;

  // Movie({this.title, this.keyword, this.poster, this.like});

  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  Movie.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['title'] = title;
  //   data['keyword'] = keyword;
  //   data['poster'] = poster;
  //   data['like'] = like;
  //
  //   return data;
  // }

  @override
  String toString() {
    return "Movie<$title:$keyword>";
  }
}
