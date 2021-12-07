import 'package:flutter/services.dart';
import 'package:samrajya/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:backdrop/backdrop.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
}


class MyApp extends StatelessWidget {
  _launchUrl(String url) {
    canLaunch(url).then((bool success) {
      if (success) {
        launch(url);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return DefaultTabController(
      length: 1,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Samrajya',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: Colors.teal,
            fontFamily: "Poppins",
           ),
        home: BackdropScaffold(
          appBar: BackdropAppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Samrajya"),
              ],
            ),
            actions: <Widget>[
              BackdropToggleButton(
                icon: AnimatedIcons.list_view,
              )
            ],
          ),
          stickyFrontLayer: true,
          //headerHeight: 210,
          frontLayerBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          backLayer: ListView(
                      children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      child: Text(
                        "\nSamrajya is committed to reaching the maximum numbers of customers around the globe by supplying the necessary supplies delivered directly to the doorsteps of the people who need them. We prioritize the essential materials and promise to deliver the items.\n",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.tealAccent,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                                child: Column(
                                  children: [
                                    Wrap(
                                      spacing: 50.0,
                                      runSpacing: 20.0,
                                      children: <Widget>[
                                           IconButton(
                                             iconSize: 40.0,
                                            icon: Icon(Icons.share, color: Colors.blue,
                                            ),
                                            tooltip: 'Share',
                                            onPressed: () {
                                              Share.share("Check out Samrajya\n" +
                                                  ("https://www.facebook.com/Samrajya-101947348518167"));
                                            },
                                          ),
                                        IconButton(
                                          iconSize: 40.0,
                                          icon: Icon(
                                            Icons.warning,
                                            color: Colors.blue,
                                          ),
                                          tooltip: 'Share',
                                          onPressed: () {
                                            showAboutDialog(
                                                context: context,
                                                applicationVersion: '1.0.0',
                                                applicationIcon: Image.asset(
                                                  "assets/images/icon.png",
                                                  fit: BoxFit.contain,
                                                  height: 65,
                                                  width: 65,
                                                ),
                                                applicationName: 'Samrajya',
                                                children: <Widget>[
                                                  Text(
                                                      "Samrajya application do not take responsibility for decisions taken by the reader based solely on the information provided in this app."),
                                                ]);
                                          },
                                        ),

                                        IconButton(
                                          iconSize: 40.0,
                                          icon: Icon(FontAwesomeIcons.facebook),
                                          color: Colors.blue,
                                          onPressed: () => _launchUrl(
                                              "https://www.facebook.com/Samrajya-101947348518167"),
                                        ),
                                        IconButton(
                                          iconSize: 40.0,
                                          icon: Icon(FontAwesomeIcons.globe),
                                          color: Colors.blue,
                                          onPressed: () => null,
                                              //_launchUrl("https://qa.nepalembassy.gov.np/"),
                                        ),
                                        IconButton(
                                          iconSize: 40.0,
                                          icon: Icon(FontAwesomeIcons.phoneSquare),
                                          color: Colors.blue,
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Do You want to make Call?',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text("Call"),
                                                      onPressed: () {
                                                        _launchUrl('tel:+9779858059096');
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
                                        IconButton(
                                          iconSize: 40.0,
                                          icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                                          color: Colors.blue,
                                          onPressed: () => null,
                                              //_launchUrl("https://www.google.com/maps/@28.1965884,81.690813,15.25z"),
                                        ),

                                      ],
                                    )
                                  ],
                                ),


                    ),
                    //Divider(),
                    ListTile(
                      enabled: false,
                      dense: true,
                     // title: Text("Version", textAlign: TextAlign.center),
                      title: FutureBuilder(
                        future: getVersionNumber(),
                        builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) =>
                            Text(
                          snapshot.hasData ? snapshot.data : "Loading ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black38),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 15.0),
                            child: Text(
                              "Built With",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 15.0),
                            child: SpinKitPumpingHeart(
                              color: Colors.greenAccent,
                              //const Color(0xff8D1B3D),
                              size: 35,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15.0),
                            child: Text(
                              "For You",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
          ),
          frontLayer: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: [Home(),
      //  RulesFire()
      ]),
    );
  }
}

Future<String> getVersionNumber() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return version;
}
