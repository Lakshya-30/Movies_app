import 'package:flutter/material.dart';
import 'package:movies_app/utils/text.dart';

class Description extends StatelessWidget {
  final String description, bannerurl, posterurl, vote, launchDate;
  final String name;
  const Description({Key? key, required this.name, required this.description, required this.bannerurl, required this.posterurl, required this.vote, required this.launchDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(bannerurl,fit: BoxFit.cover,),
                  )),
                  Positioned(
                      bottom: 10,
                      child: Text('⭐ Average Rating - '+vote,
                          style: TextStyle(fontSize: 20, color: Colors.white70, backgroundColor: Colors.black54)))

                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(padding: EdgeInsets.all(10),
            child: modified_text(text: name.toString()!=null? name:'Not Loaded', size:24, color: Colors.white70,),
            ),
            Container(padding: EdgeInsets.only(left: 10),
            child: modified_text(text: 'Releasing on- '+launchDate,size: 14,color: Colors.white,),
            ),
            Row(
              children: [
                Container(height: 170,
                margin: EdgeInsets.all(10),
                width: 140,
                child: Image.network(posterurl),),
                Flexible(
                  child: Container(
                    child: modified_text(text: description,size: 18,color: Colors.white,),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
