import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

_launchUrl1(String url) {
  canLaunch(url).then((bool success) {
    if (success) {
      launch(url);
    }
  });
}

void _launchUrl(command) async{
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print(' could not launch $command');
  }
}

class Indus extends StatelessWidget {

  String A;
  Indus([this.A]);

  @override
  Widget build(BuildContext context) {

    CollectionReference ref = FirebaseFirestore.instance.collection('Indus');
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned(
              left: 0.0,
              right: 0.0,
              height: 20.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: connected ? null : Color(0xFFEE4400),
                child: connected
                    ? null
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "OFFLINE",
                      style: TextStyle(color: Colors.white,fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
          stream: ref.where('item', isEqualTo: A).snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var dat = snapshot.data.docs[index];
                    return Hero(
                      tag: Text("btn2"),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            Get.to(Product1(B: A, I: index));
                          },
                          child: Card(
                            color: (index % 2 == 0) ? Colors.white38.withOpacity(0.5) : Colors.white70.withOpacity(0.6),
                            margin: EdgeInsets.symmetric(vertical: 0.6),
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: CachedNetworkImageProvider(dat['imgUrl']),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,10,5,8.0),
                                  child: Text(
                                    dat['productName'],textAlign: TextAlign.justify,
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,0,5,5.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Rs. ',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightGreen,fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(text: dat['price'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("Check your Internet Connection"));
              // "//${snapshot.error}");
            }else
              return Text("");
          }
      ),
    ),);

  }

}

class Product1 extends StatelessWidget {

  final B;
  int I;
  Product1({Key key,this.B,this.I}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    CollectionReference ref = FirebaseFirestore.instance.collection('Indus');
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            Positioned(
              left: 0.0,
              right: 0.0,
              height: 20.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: connected ? null : Color(0xFFEE4400),
                child: connected
                    ? null
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "OFFLINE",
                      style: TextStyle(color: Colors.white,fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.teal,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: ref.where('item', isEqualTo: B).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Hero(
                  tag: Text("btn1"),
                  child: Material(
                    color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 210,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                //NetworkImage(dat['imgUrl']
                                CachedNetworkImageProvider(snapshot.data.documents[I]['imgUrl']
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 8.0),
                            child: Text(
                              snapshot.data.documents[I]['productName'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Rs. ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightGreen,
                                      fontSize: 35),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: snapshot.data.documents[I]['price'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 35),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.teal.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20,5),
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  text: snapshot.data.documents[I]
                                  ['description'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text("Brand:",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),),
                            title: Text(
                              snapshot.data.documents[I]['companyName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            dense: true,
                          ),
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal)
                            ),
                            child: ListTile(
                              leading: Text("Call:",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15),),
                              title: Text( snapshot.data.documents[I]['contact'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
                              trailing: Icon(Icons.call),
                              dense: true,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Do You want to make Call?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Call"),
                                          onPressed: () {
                                            //Put your code here which you want to execute on Yes button click.
                                            _launchUrl('tel:' +
                                                snapshot.data.documents[I]
                                                ['contact']);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                  ),
                );

              } else
                return Text("");
            }
        ),
      ),
    ),);

  }

}