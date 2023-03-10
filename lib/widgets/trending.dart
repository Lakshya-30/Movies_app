import 'package:flutter/material.dart';
import 'package:movies_app/utils/text.dart';
import '../description.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Trending Movies',size: 26, color: Colors.white,),
          Container(
            height: 270,
            //width: 120,
            child: ListView.builder(itemCount: trending.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                    name: trending[index]['title'],
                    bannerurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                    posterurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path'],
                    description: trending[index]['overview'],
                    vote: trending[index]['vote_average'].toString(),
                    launchDate: trending[index]['release_date'],
                  )));
                },
                child: trending[index]['title']!=null?Container(
                  padding: EdgeInsets.all(5),
                  width: 120,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path']
                          )
                        ),
                        borderRadius: BorderRadius.circular(20),),
                      ),
                      Container(child: modified_text(text: trending[index]['title']!=null?
                      trending[index]['title']:'Loading', color: Colors.white, size: 12,),
                      )
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
