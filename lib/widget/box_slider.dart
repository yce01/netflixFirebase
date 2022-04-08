import 'package:flutter/material.dart';
import 'package:netflix/widget/carousel_slider.dart';
import 'package:netflix/screen/detail_screen.dart';
import '../model/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  const BoxSlider({required this.movies, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('지금 뜨는 콘텐츠'),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index){
                return makeBoxImages(context, movies)[index];
              },
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (int i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return DetailScreen(movies: movies[i]);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.network(movies[i].poster!),
        ),
      ),
    ));
  }
  return results;
}
