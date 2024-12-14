
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);
  @override
  OrderTrackingPageState createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@drawable/ic_stat_ic_notification',
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Order Update',
      'Our rider got your order. Your order is on the way!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Status'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(5.3817756191281525,
                  100.28105363017615), // Starting point marker
              zoom: 15.5,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(5.3817756191281525,
                          100.28105363017615), // Destination point
                      LatLng(5.381839708373829, 100.28058156139613),
                      LatLng(5.38205333914398, 100.28025969631886),
                      LatLng(5.382907861474153, 100.28036698467795),
                      LatLng(5.382843772341044, 100.27929410108702),
                      LatLng(5.384937347195075, 100.27916535505614),
                      LatLng(5.387714527200235, 100.27802809844974),
                      LatLng(5.389830, 100.281372),
                      LatLng(5.38813193954758, 100.28255566720297),
                      LatLng(5.388249435264118, 100.28265222672616),
                      LatLng(5.3883554130910705,
                          100.2826200402189), // Starting Point
                    ],
                    strokeWidth: 5.0,
                    color: Colors.orange,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(5.3817756191281525,
                        100.28105363017615), // Destination point marker
                    builder: (ctx) =>
                    const Icon(Icons.location_pin, color: Colors.red),
                  ),
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(5.3883554130910705,
                        100.2826200402189), // Starting marker
                    builder: (ctx) =>
                    const Icon(Icons.motorcycle, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFA4A5FF),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Getting your order",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Text(
                    "Arrives between 7:40 PM - 7:52 PM",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.motorcycle, color: Colors.white),
                      Expanded(
                        child: Slider(
                          value: 0.5,
                          onChanged: (value) {},
                          activeColor: Colors.white,
                          inactiveColor: Colors.white24,
                        ),
                      ),
                      const Icon(Icons.home, color: Colors.white),
                    ],
                  ),
                  const Text(
                    "Joynul is getting your order.",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      // Real implementation: Navigate to details page or show more details
                      showNotification(); //Test for UI screenshot only (not implemented here)
                    },
                    child: const Text(
                      "View all details",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
