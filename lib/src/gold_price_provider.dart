import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:package_info_plus/package_info_plus.dart';

// hide GoldPriceProvider;
class GoldPrice extends ChangeNotifier {
  late IO.Socket socket_connection;


  connectPrice(String secretKey,Function cb) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    socket_connection = IO.io(
        "https://api.goldpriceupdate.com",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setQuery({
          'secret_key': secretKey,
          'appPackage': packageInfo.packageName
        }).build());
    socket_connection.connect();
    socket_connection.onConnect((_) async {
      socket_connection.emit('subscribe_gold_price');
      socket_connection.on("gold_price_update", (var data) {
        cb(data);
      });
    });
    socket_connection.onDisconnect((_) => print('disconnect'));
    socket_connection.onConnectError((data) => print(data));
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