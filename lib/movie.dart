import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/widgets/nowplaying.dart';
import 'package:movies_app/widgets/toprated.dart';
import 'package:movies_app/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trending =[];
  List topRated =[];
  List nowPlaying=[];
  final String apikey='88b4aee5e062041b39715dd353a232a6';
  final readAccessToken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OGI0YWVlNWUwNjIwNDFiMzk3MTVkZDM1M2EyMzJhNiIsInN1YiI6IjYzYTgxNmMxYjMzMTZiMDBjZmJjOTZmMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IncxXbfsjHIMARSNPDemhWo03Et1L7lO2zq0FNrMb_s';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async{
    TMDB tmbdWithCustomLogs =TMDB(ApiKeys(apikey,readAccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        )
    );
    Map trendingResult = await tmbdWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmbdWithCustomLogs.v3.movies.getTopRated();
    Map nowPlayingResult = await tmbdWithCustomLogs.v3.movies.getNowPlaying();

    setState(() {
      trending = trendingResult['results'];
      topRated = topRatedResult['results'];
      nowPlaying = nowPlayingResult['results'];
    });
  }


  @override
  //final TextEditingController _textEditingController = TextEditingController();
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          color: Colors.black54,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white24,
                        ),
                        child: TextField(
                          //controller: searchController,
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            labelText: '   What\'s New',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      icon: Icon(Icons.logout, color: Colors.black,),
                      label: Text('Logout',style: TextStyle(color: Colors.black54),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TrendingMovies(trending: trending),
                      TopRated(toprated: topRated,),
                      NowPlaying(nowPlaying: nowPlaying),
                    ],
                  ),
                ),
              ])),
    );;
  }
}

