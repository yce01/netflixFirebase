import 'package:flutter/material.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflix/screen/detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  const CarouselImage({Key? key, required this.movies}) : super(key: key);

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie>? movies;
  List<Widget>? images;
  List<String>? keywords;
  List<bool>? likes;
  int _currentPage = 0;
  String _currentKeyword = '';

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies?.map((e) => Image.network(e.poster!)).toList();
    keywords = movies?.map((e) => e.keyword!).toList();
    likes = movies?.map((e) => e.like!).toList();
    _currentKeyword = keywords![0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
        ),
        CarouselSlider(
            items: images,
            options: CarouselOptions(onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords![_currentPage];
              });
            })),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
            _currentKeyword,
            style: const TextStyle(fontSize: 13),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                likes![_currentPage]
                    ? IconButton(
                        onPressed: () {setState(() {
                          likes![_currentPage] = !likes![_currentPage];
                          movies![_currentPage].reference.update({'like': likes![_currentPage]});  //firebase값 업데이트
                        });}, icon: const Icon(Icons.check))
                    : IconButton(
                        onPressed: () {setState(() {
                          likes![_currentPage] = !likes![_currentPage];
                          movies![_currentPage].reference.update({'like': likes![_currentPage]});  //firebase값 업데이트
                        });}, icon: const Icon(Icons.add)),
                const Text(
                  '내가 찜한 콘텐츠',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                ),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      '재생',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return DetailScreen(movies: movies![_currentPage]);
                        }));
                      },
                      icon: const Icon(Icons.info)),
                  const Text(
                    '정보',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // void bottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Wrap(
  //           children: [
  //             Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     SizedBox(
  //                       width: 100,
  //                       height: 120,
  //                       child: images![_currentPage],
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text('${widget.movies[_currentPage].title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
  //                         Text('${widget.movies[_currentPage].keyword}'),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Column(
  //                       children: [
  //                         IconButton(
  //                             onPressed: () {},
  //                             icon: Icon(Icons.play_circle_fill)),
  //                         Text('재생')
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         IconButton(
  //                             onPressed: () {}, icon: Icon(Icons.save_alt)),
  //                         Text('저장')
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         IconButton(onPressed: () {}, icon: Icon(Icons.add)),
  //                         Text('내가 찜한 콘텐츠')
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         IconButton(onPressed: () {}, icon: Icon(Icons.share)),
  //                         Text('공유')
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 const Divider(),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Icon(Icons.info),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('회차 및 상세 정보'),
  //                       ],
  //                     ),
  //                     Icon(Icons.chevron_right)
  //                   ],
  //                 ),
  //                 const Padding(padding: EdgeInsets.only(bottom: 30))
  //               ],
  //             ),
  //           ],
  //         );
  //       });
  // }
}
