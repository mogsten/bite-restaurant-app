import 'dart:async';
import 'dart:convert';

import 'package:bite_restaurant/models/ordersModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


import 'models/userModel.dart';

class OrderList extends StatefulWidget {
  OrderList({Key key, this.access_token}) : super(key: key);

  var access_token = "";
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  String _access_token = "";

   List<Orders> _orders = List<Orders>();
   Timer timer;
   Future<List<Orders>> fetchOrders() async {
    print(widget.access_token);
    
    var url = 'http://vps189597.vps.ovh.ca/api/restaurant/orders/?access_token=${widget.access_token}';

    var response = await http.get(
        url,
        // body,
    );

    print(url);
    print(response.body);
    
    var orders = List<Orders>();

    if (response.statusCode == 200) {
      final jsonResponseArrray = json.decode(response.body);
      print(jsonResponseArrray[0]);
        orders.clear();
        orders.add(Orders.fromJson(jsonResponseArrray[0]));

      // final order = Orders.fromJson(jsonResponseArrray[0]);
      // print(order.customerDet.name);
      return orders;

    }
  }
  startTime() async {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) =>
      fetchOrdersFromBackend());
}
 @override
  void initState() {
    // TODO: implement initState
    fetchOrdersFromBackend();
    startTime();
  super.initState();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
void fetchOrdersFromBackend() {
fetchOrders().then((value) { 
      setState(() {
        _orders.clear();
        _orders.addAll(value);
        print("RESTAURANTS TO PRINT: $_orders");
      });
});
}

 

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xFFF0F3F8),
      appBar: null,
      body: Stack(
        children: <Widget>[
          _appSideBar(context: context),
          _appOrdersBar(context: context),
          _allOrdersLabel(),
          _allOrdersScrollView(context: context),
          _appOrderCustomersView(context: context),
          _appOrderDetailsView(context: context),
          _appOrderTotalView(context: context)
      ],
      ),
    );
  }
}


Widget _appSideBar({
  @required BuildContext context,
}) =>
  Column(
        children: <Widget>[
          Container(
        child: Container(
          width: 350,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF275996),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Column(
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/c2g.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: 
                  Text(
                    "Chickens 2 GO",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child:
                        Container(
                          width: 15,
                          height: 15,
                          child:
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                        ),
                        ),
                  Text(
                    "Accepting Orders",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                    ),
                      ],
                    ),
                  ),
                  ],
                  ),
              ],
        ),
      ),
        ),
      )
      ),
        ],
      );

Widget _appOrdersBar({
  @required BuildContext context,
}) =>
Padding(
  padding: EdgeInsets.only(left: 350),
  child: Row(
        children: <Widget>[
          Container(
          width: 500,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF0F3F8),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                          padding: EdgeInsets.only(left: 50.0),
                          child:
                  Text(
                    "Active Orders",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4D4C4C),
                    ),
                    ),
                    ),
                  ],
                ),
                  Padding(
                    padding: EdgeInsets.only(top: 14.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 35.0, top: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                         Column(
                  children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/dp.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:
                 Text(
                   "Alexander",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                   ),
                ),
                  ],
                ),
                Column(
                  children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/bigsot.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:
                 Text(
                   "Sotiris",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                   ),
                ),
                  ],
                ),
                Column(
                  children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/catfish.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:
                 Text(
                   "Eleni",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                   ),
                ),
                  ],
                ),
               Column(
                  children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/sot.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:
                 Text(
                   "Sotiri",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                   ),
                ),
                  ],
                ),
                Column(
                  children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/sav.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child:
                 Text(
                   "Savvas",
                   style: TextStyle(
                     fontSize: 17,
                   ),
                   ),
                ),
                  ],
                ),
                        ],
                      ),
                    )
                      ],
                    ),
                  ),
                  ],
                  ),
      ),
        ),
      )
        ],
  )
);


Widget _allOrdersLabel() =>
Padding(
  padding: EdgeInsets.only(left: 350, top: 275),
  child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 50.0),
              child:
                  Text(
                    "All Orders",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4D4C4C),
                    ),
                    ),
                    ),
        ],
  )
);


Widget _allOrdersScrollView({
  @required BuildContext context,
}) =>
Padding(
  padding: EdgeInsets.only(left: 400, top: 310),
  child: Container(
  width: 440,
  child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF275795),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/dp.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Alexander Mogavero",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Pickup",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 50.0, top: 65.0),
                                child:
                              Text(
                                "10 mins ago",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/bigsot.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Sotiris Demitriou",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF545354)
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Delivery",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 80.0, top: 65.0),
                                child:
                              Text(
                                "16 mins ago",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/catfish.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Eleni Vassiliou",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF545354)
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Delivery",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 100.0, top: 65.0),
                                child:
                              Text(
                                "24 mins ago",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/sot.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Sotiri Vassiliou",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF545354)
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Pickup",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 95.0, top: 65.0),
                                child:
                              Text(
                                "37 mins ago",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                          height: 120,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/sav.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Savvas Vassiliou",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF545354)
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Delivery",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 80.0, top: 65.0),
                                child:
                              Text(
                                "49 mins ago",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ),
                      ],
                    ),
),
);

Widget _appOrderCustomersView({
  @required BuildContext context,
}) =>
Padding(
  padding: EdgeInsets.only(left: 875, top: 100),
  child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0)
              ),
            ),
            width: 525,
            height: MediaQuery.of(context).size.height  /1.2,
            child: Column(
              
              children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                color: Color(0xFFF5F8FF),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0)
              ),
            ),
                height: 150.0,
                child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child:
                              Container(
                  width: 80,
                  height: 80,
                  child: 
                  ClipOval(
                    child: Image.asset(
                      "assets/dp.jpg",
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 55.0),
                                child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Alexander Mogavero",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF545354)
                                ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child:
                              Text(
                                "Pickup",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFA3A3A3),
                                ),
                                ),
                              ),
                                ],
                              ),
                              ),
                            ],
              )
              ),
              ],
            ),
          ),
        ],
  )
);

Widget _appOrderDetailsView({
  @required BuildContext context,
}) =>
Padding(
  padding: EdgeInsets.only(left: 875, top: 260, bottom: 180.0),
  child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 32.0),
            child:
          Text(
            "1 x Chicken Classic Subway Footlong",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Choice of Bread",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
          Text(
            " - Wheat Bread (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
           Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Preparation",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
          Text(
            " - Toasted (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
           Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Add Cheese",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
          Text(
            " - Natural Cheddar (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
           Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Add Veggies",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          Text(
            " - Lettuce (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
             Text(
            " - Lettuce (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
            Text(
            " - Cucumber (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
            Text(
            " - Pickles (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
            Text(
            " - Olives (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
            Text(
            " - Jalapenos (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Add Sauce",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
          Text(
            " - Mayonnaise (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "Seasonings",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 8.0),
            child:
          Text(
            " - Salt & Pepper (\$0.00)",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "3 x Double Chocolate Chip Cookie",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "3 x Chocolate Chip Cookie",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, top: 15.0),
            child:
          Text(
            "3 x Chocolate Chip Rainbox Cookie",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: Color(0xFF676667),
            ),
            ),
          ),
        ],
  ),
  );

Widget _appOrderTotalView({
  @required BuildContext context,
}) =>
Padding(
  padding: EdgeInsets.only(left: 875, top: 750),
  child:Row(
              
              children: <Widget>[
              Container(
                width: 525,
                decoration: new BoxDecoration(
                color: Color(0xFFF5F8FF),
              borderRadius: new BorderRadius.only(
                bottomRight: const Radius.circular(20.0),
                bottomLeft: const Radius.circular(20.0)
              ),
            ),
                height: 100.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              // Text('asdasdsa'),
                            ],
              )
              ),
              ],
            ),
  );