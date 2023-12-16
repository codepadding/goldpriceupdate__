import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

class GoldData {
  var bid;
  var ask;
  var min;
  var max;

  GoldData({
    required this.bid,
    required this.ask,
    required this.min,
    required this.max,
  });

  factory GoldData.fromJson(Map<String, dynamic> json) {
    return GoldData(
      bid: json['data']['today']['bid'],
      ask: json['data']['today']['ask'],
      min: json['data']['today']['min'],
      max: json['data']['today']['max'],
    );
  }
}

// hide GoldPriceAPI class from the public API
class GoldPrice extends ChangeNotifier {
  late IO.Socket socket_connection;
  var key = 'JUW0FexuguFLpsMNIdveXckJJwSraF61XYCdsfHsYX';

  connectPrice(String secretKey, Function cb) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // call api for token
    var token = await getToken(packageInfo.packageName,secretKey);

    print("token");
    print(token);

    socket_connection = IO.io(
        "https://api.goldpriceupdate.com",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setQuery({
          'secret_key': secretKey,
          'appPackage': packageInfo.packageName,
          'token': token,
          'type': 'app',
          'from': 'flutter-package',
          'key': key,
        })
            .build());
    socket_connection.connect();
    socket_connection.onConnect((_) async {
      print("connected_socket");
      socket_connection.emit('subscribe_gold_price');
      socket_connection.on("gold_price_update", (var data) {
        var gold_data = jsonDecode(data);
        GoldData goldPrice = GoldData.fromJson(gold_data);
        cb(goldPrice);
      });
    });

    socket_connection.onError((data) => print(data));

    socket_connection.onDisconnect((_) {
      print(_.toString());
      print('disconnect');
    });
    socket_connection.onConnectError((data) => print(data));
  }


  getToken(var packageName,var secretKey) async {
    final response = await http.post(
      Uri.parse('https://api.goldpriceupdate.com/user-socket-token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'appPackage': packageName,
        'type': 'app',
        'from': 'flutter-package',
        'key': key,
        'secret_key': secretKey,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    return 'error';
  }
}

// show GoldPriceProvider;
class GoldPriceProvider extends GoldPrice {
  @override
  connectPrice(String secretKey, Function cb) {
    // TODO: implement connectPrice
    return super.connectPrice(secretKey, cb);
  }
}
