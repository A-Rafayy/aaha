import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'searchPage.dart';
import 'loginScreen.dart';

class topTravelDestinations extends StatelessWidget {
  const topTravelDestinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tile> TileList = [
      Tile(
          name: 'Trip 1',
          company: 'ABC Travels',
          price: '\$ 299',
          url:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/24701-nature-natural-beauty.jpg/1280px-24701-nature-natural-beauty.jpg'),
      Tile(
          name: 'Trip 2',
          company: 'DEF Travels',
          price: '\$ 599',
          url: 'https://wallpaperaccess.com/full/393735.jpg'),
      Tile(
          name: 'Trip 2',
          company: 'GHI Travels',
          price: '\$ 499',
          url:
              'https://media.springernature.com/full/springer-cms/rest/v1/img/18893370/v1/height/320'),
      Tile(
          name: 'Trip 4',
          company: 'JKL Travels',
          price: '\$ 399',
          url:
              'https://images.pexels.com/photos/414102/pexels-photo-414102.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
      Tile(
          name: 'Trip 5',
          company: 'MNO Travels',
          price: '\$ 999',
          url: 'https://wallpaperaccess.com/full/1204217.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Top Travel Destinations",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: ListView.builder(
      //     itemCount: TileList.length,
      //     itemBuilder: (context, index) {
      //       return Align(
      //         alignment: Alignment.centerRight,
      //         child: SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           child: Card(
      //             // color: Colors.black,
      //             elevation: 0,
      //             margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      //             child: ListTile(
      //               title: ClipRRect(
      //                 borderRadius: BorderRadius.circular(5.0),
      //                 child: Image.network(TileList[index].url),
      //               ),
      //               subtitle: Column(
      //                 children: [
      //                   Row(
      //                     children: [
      //                       Text(
      //                         TileList[index].name,
      //                         style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.bold,
      //                             color: Colors.black),
      //                       ),
      //                     ],
      //                   ),
      //                   Container(
      //                     width: double.infinity,
      //                     child: Text(
      //                       TileList[index].days,
      //                       style: TextStyle(fontSize: 20, color: Colors.black),
      //                       textAlign: TextAlign.left,
      //                     ),
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text(
      //                         TileList[index].company,
      //                         style:
      //                             TextStyle(fontSize: 20, color: Colors.black),
      //                       ),
      //                       Text(
      //                         TileList[index].price,
      //                         style:
      //                             TextStyle(fontSize: 20, color: Colors.black),
      //                       ),
      //                     ],
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     }),
       body: topPackages(),
    );
  }
}

class topPackages extends StatefulWidget {
  @override
  _topPackagesState createState() => _topPackagesState();
}

class _topPackagesState extends State<topPackages> {
  @override
  Widget build(BuildContext context) {
    CollectionReference Packages =
        FirebaseFirestore.instance.collection('Packages');
    return StreamBuilder(
      stream: Packages.orderBy('sales').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.length > 0) {
          print(snapshot.data.docs.length);
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      // color: Colors.black,
                      elevation: 0,
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: ListTile(
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                              snapshot.data.docs[index]['photoUrl']),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Package ' +
                                      snapshot.data.docs[index]['Package name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                snapshot.data.docs[index]['days'] + ' Days',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.docs[index]['Agency Name'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  '\$ ' + snapshot.data.docs[index]['price'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return (Center(
            child: Text(
              'Not Found',
              style: TextStyle(fontSize: 25),
            ),
          ));
        }
      },
    );
  }
}

class Tile {
  String name;
  String company;
  String price;
  String url;
  String days = '12 Days';

  Tile({
    required this.name,
    required this.company,
    required this.price,
    required this.url,
  });
}
