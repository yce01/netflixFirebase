import 'package:flutter/material.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailScreen extends StatefulWidget {
  final Movie movies;
  const DetailScreen({required this.movies, Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Movie>? movies;
  List<Widget>? images;
  int _currentPage = 0;
  bool like = false;

  @override
  void initState() {
    super.initState();
    like = widget.movies.like!;
    images = movies?.map((e) => Image.network(e.poster!)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        // accentColor: Colors.white
      ),
      home: Scaffold(
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 120,
                      child: Image.network('${widget.movies.poster}'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.movies.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('${widget.movies.keyword}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(onTap: (){},
                            child: Icon(Icons.play_circle_fill)),
                        Text('재생')
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(onTap: (){},
                            child: Icon(Icons.save_alt)),
                        Text('저장')
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(onTap: (){setState(() {
                          like = !like;
                          widget.movies.reference.update({'like': like});
                        });},
                            child: like ? Icon(Icons.check) : Icon(Icons.add)),
                        Text('내가 찜한 콘텐츠')
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(onTap: (){},
                            child: Icon(Icons.share)),
                        Text('공유')
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(
                          width: 10,
                        ),
                        Text('회차 및 상세 정보'),
                      ],
                    ),
                    Icon(Icons.chevron_right)
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
              ],
            ),
          ),
        ),
      ),
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
  //                         Text('${widget.movies.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
  //                         Text('${widget.movies.keyword}'),
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

