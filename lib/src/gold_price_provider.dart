import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class GoldPriceProvider extends ChangeNotifier {
  late IO.Socket socket;

  var gold_data = null;
  var gold_data_old = null;

  connectPrice(String secretKey,String appPackage) async {
    socket = IO.io(
        "https://api.goldpriceupdate.com",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
        .setQuery({
          'secret_key': secretKey,
          'appPackage':appPackage
        }).build());
    socket.connect();
    socket.onConnect((_) async {
      socket.emit('subscribe_gold_price');
      socket.on("gold_price_update", (var data) {
        gold_data_old = gold_data;
        gold_data = jsonDecode(data);
        notifyListeners();
      });
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.onConnectError((data) => print(data));
  }

  // init function
  init(String secretKey,String appPackage) async {
    connectPrice(secretKey,appPackage);
  }

}
