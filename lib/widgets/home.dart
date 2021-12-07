import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:samrajya/widgets/Indus.dart';
import 'package:samrajya/widgets/Mech.dart';
import 'package:samrajya/widgets/Offer.dart';
import 'package:samrajya/widgets/Slide.dart';
import '../constant.dart';

import 'Embassy.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection('Slide');
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
              height: 10.0,
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
      child: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  Get.to(Slide());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 30,
                                      color: kShadowColor,
                                    ),
                                  ],
                                ),
                                child: CarouselSlider.builder(
                                  itemCount: snapshot.data.documents.length,
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    aspectRatio: 2,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.99,
                                    autoPlayInterval: Duration(seconds: 15),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 2000),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(
                                            snapshot.data.documents[index]
                                                ['imgUrl'],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15.0, 0, 15),
                                child: Text(
                                  "Electrical & Electronics",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Tools')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.tools,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "Tools &\nTester",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Contractors')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/contactor.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Contactor",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Fuses')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/fuse.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Fuses",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('MCB')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/mcb.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "MCB",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Lighting')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.lightbulb,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "Lighting &\nfixtures",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Elec-Wire')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.electrical_services_rounded,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "Electrical\nWire",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Ext-Cord')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/extensioncord.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Extension\nCord",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Switch')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/off.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Switches &\nDimmers",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Elec-Motors')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/motor.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Electrical\nMotors",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Elec-fitting')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/plug.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Electrical\nfittings &\ncomponents",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Elec-Connectors')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/connector.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Electrical\nConnectors",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Smart-Elec-Product')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.devices_other,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "Smart\nElectrical\nProducts",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('TLC')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/insulator.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Transmission\nLine\nComponents",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Switchyard')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/tt.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Switchyard",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Hydro-Equip')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/hydropower.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Hydropower\nEquipments",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Product('Charge-Device')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.chargingStation,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "Charge\nStorage\nDevices",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15.0, 0, 15),
                                child: Text(
                                  "Mechanical products",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Metal-Work')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/blacksmith.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Metal\nWork",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Nuts')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/bolts.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Nut &\nBolt",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Hoist')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/winch.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Hoist",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('House-Hardware')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.home,
                                          color: Colors.teal,
                                          size: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 14.0, 0, 0),
                                          child: Text(
                                            "House\nHardware",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Compressors')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/compressor.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Compressors",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Mech-Tools')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/welding.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Mechanical\nTools",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Pump-Mech')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/pump.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Pumping\nMachines",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Plastic-Product')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/pipe.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Plastic\nProducts",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Oil')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/oil.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Oil &\nLubricants ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Storage')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/water.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Storage",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Ball')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/bearing.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Ball\nbearings",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Mech-Parts')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/car.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Mechanical\nParts",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Fire-Prevention')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/fire.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Fire\nprevention\nproducts",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Mech('Pistons')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/pistons.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Piston &\nCrankshafts\nAssemblies",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15.0, 0, 15),
                                child: Text(
                                  "Industrial products",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kTitleTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Indus('Pipeline')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/pipeline.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Industrial\npipes &\nfittings",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Indus('Coolers')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/cooler.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Industrial\nCoolers, \nBlowers & Fans",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Indus('Brushes')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/brush.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Industrial &\nMachine\nBrushes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Indus('Wears')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/coverall.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Industrial\nUniforms &\nSafety Wears",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      Get.to(Indus('Crusher')),
                                    },
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/crusher.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            "Crusher\nEquipments",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 30,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(Offer());
                                },
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Offer')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return AspectRatio(
                                            aspectRatio: 20 / 9,
                                            child: Image(
                                              image: CachedNetworkImageProvider(
                                                  snapshot.data.docs[0]
                                                      ['imgUrl']),
                                              fit: BoxFit.cover,
                                            ));
                                      } else
                                        return Text("");
                                    })),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else
              return Text("");
          }),
    );
  }

//setState(bool Function() param0) {}
}
