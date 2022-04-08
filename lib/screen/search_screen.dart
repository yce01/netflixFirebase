import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix/screen/detail_screen.dart';

import '../model/model_movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildList(context, snapshot.data!.docs);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1/1.35,
          padding: const EdgeInsets.all(3),
          children:
            searchResults.map((e) => _buildListItem(context, e)).toList(),
    ));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    final movie = Movie.fromSnapShot(data);
    return InkWell(
      child: Image.network(movie.poster!),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context){
            return DetailScreen(movies: movie);
          }
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(30)),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = '';
                                });
                              },
                            )
                          : Container(),
                      hintText: '검색',
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ))
            ],
          ),
        ),
        _buildBody(context),
      ],
    );
  }
}
