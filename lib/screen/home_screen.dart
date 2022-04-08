import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:netflix/widget/box_slider.dart';
import 'package:netflix/widget/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? stream;

  @override
  void initState() {
    super.initState();
    stream = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return _buildBody(context, snapshot.data!.docs);
        }
        return const LinearProgressIndicator();
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot){
    List<Movie> movies = snapshot.map((e) => Movie.fromSnapShot(e)).toList();
    return ListView(
      children: [
        Stack(
          children: [
            CarouselImage(movies: movies),
            const TopBar(),
          ],
        ),
        BoxSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/netflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 1),
            child: const Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
