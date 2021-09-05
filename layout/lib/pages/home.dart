import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ความรู้เกี่ยวกับคอมพิวเตอร์")),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                //var data = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return myBox(
                        snapshot.data[index]['title'],
                        snapshot.data[index]['subtitle'],
                        snapshot.data[index]['imageUrl'],
                        snapshot.data[index]['detail']);
                  },
                  itemCount: snapshot.data.length,
                );
              },
              future: getData(),
              //future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
            )));
  }

  Widget myBox(String title, String subtitle, String imageUrl, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = imageUrl;
    v4 = detail;

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      //color: Colors.blue[50],
      height: 150,
      decoration: BoxDecoration(
          //color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 10),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text("อ่านต่อ",
                  style: TextStyle(fontSize: 15, color: Colors.white)))
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/deardevilz/BasicAPI/main/data.json
    var url = Uri.https(
        'raw.githubusercontent.com', '/deardevilz/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
