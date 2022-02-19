import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String status = 'Waiting...';

  Connectivity _connectivity = Connectivity();
  late StreamSubscription stream;

  void check() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      status = 'Mobile Data';
    } else if (result == ConnectivityResult.wifi) {
      status = 'Wifi';
    } else {
      status = 'Not Connected ';
    }
    setState(() {});
  }

  void checkRealtime() async {
    stream = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = 'Mobile Data';
      } else if (event == ConnectivityResult.wifi) {
        status = 'Wifi';
      } else {
        status = 'Not ';
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRealtime();
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Connectivity'),
      ),
      body: Center(
        child: Text(
          status,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: check,
        child: Icon(Icons.wifi),
      ),
    );
  }
}
