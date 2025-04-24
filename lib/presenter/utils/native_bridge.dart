
import 'package:flutter/services.dart';
import 'package:my_movie_detail/presenter/constants.dart';

class NativeBridge {
  final _channel = MethodChannel(appChanel);
  static final NativeBridge _instance = NativeBridge._();

  NativeBridge._();

  static NativeBridge get instance => _instance;

  /// Sends data to Android project.
  Future<void> sendData(String method, String data ) async {
    try {
      await _channel.invokeMethod(method, {'data': data});
    } on PlatformException catch (e) {
      print("Error sending data: ${e.message}");
    }
  }

}