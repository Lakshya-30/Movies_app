import 'package:flutter/material.dart';
import 'package:movies_app/utils/text.dart';
import '../description.dart';

class TopRated extends StatelessWidget {
  final List toprated;
  const TopRated({Key? key, required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(text: 'Top Rated Movies',size: 26, color: Colors.white,),
          Container(
            height: 270,
            //width: 120,
            child: ListView.builder(itemCount: toprated.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                        name: toprated[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                        description: toprated[index]['overview'],
                        vote: toprated[index]['vote_average'].toString(),
                        launchDate: toprated[index]['release_date'],
                      )));
                    },
                    child: toprated[index]['title']!=null?Container(
                      padding: EdgeInsets.all(5),
                      width: 120,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path']
                                )
                            ),
                            borderRadius: BorderRadius.circular(10)),
                          ),
                          Container(child: modified_text(text: toprated[index]['title']!=null?
                          toprated[index]['title']:'Loading', color: Colors.white, size: 12,),)
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
