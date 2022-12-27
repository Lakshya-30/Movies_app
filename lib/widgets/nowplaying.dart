import 'package:flutter/material.dart';
import 'package:movies_app/utils/text.dart';
import '../description.dart';

class NowPlaying extends StatelessWidget {
  final List nowPlaying;
  const NowPlaying({Key? key, required this.nowPlaying}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Now Playing Movies',size: 26, color: Colors.white,),
          Container(
            height: 270,
            //width: 120,
            child: ListView.builder(itemCount: nowPlaying.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                        name: nowPlaying[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+nowPlaying[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+nowPlaying[index]['poster_path'],
                        description: nowPlaying[index]['overview'],
                        vote: nowPlaying[index]['vote_average'].toString(),
                        launchDate: nowPlaying[index]['release_date'],
                      )));
                    },
                    child: nowPlaying[index]['title']!=null?Container(
                      padding: EdgeInsets.all(5),
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500'+nowPlaying[index]['poster_path']
                                )
                            ),
                            borderRadius: BorderRadius.circular(10),),
                          ),
                          Container(child: modified_text(text: nowPlaying[index]['title']!=null?
                          nowPlaying[index]['title']:'Loading', color: Colors.white, size: 12,),)
                        ],
                      ),
                    ):Container(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
