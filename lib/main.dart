import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflix/screen/home_screen.dart';
import 'package:netflix/screen/like_screen.dart';
import 'package:netflix/screen/search_screen.dart';
import 'package:netflix/widget/bottom_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Netflix());
}

class Netflix extends StatefulWidget {
  const Netflix({Key? key}) : super(key: key);

  @override
  _NetflixState createState() => _NetflixState();
}

class _NetflixState extends State<Netflix> {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return MaterialApp(
      title: 'Netflix',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        // accentColor: Colors.white
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeScreen(),
              const SearchScreen(),
              const LikeScreen(),
              Container(),
            ],
          ),
          bottomNavigationBar: const Bottom(),
        ),
      ),
    );
  }
}
