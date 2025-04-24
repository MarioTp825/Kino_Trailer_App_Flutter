import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:my_movie_detail/domain/model/movie_ui.dart';
import 'package:my_movie_detail/main.dart';
import 'package:my_movie_detail/presenter/constants.dart';
import 'package:my_movie_detail/presenter/route_generator.dart';
import 'package:my_movie_detail/presenter/utils/native_bridge.dart';

class AndroidBridge extends StatefulWidget {
  const AndroidBridge({super.key});

  @override
  State<AndroidBridge> createState() => _AndroidBridgeState();
}

class _AndroidBridgeState extends State<AndroidBridge> with RouteAware {
  final _chanel = const MethodChannel(appChanel);
  var _isSelfPopBack = false;

  @override
  void initState() {
    super.initState();
    _chanel.setMethodCallHandler(_handleMethodCall);

    _getInitData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routerObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  Future<dynamic> _getInitData() async {
    Future.delayed(Duration(seconds: 4));
    try {
      String? result = await _chanel.invokeMethod<String>(movieMethodGet);
      if (result != null && result.isNotEmpty) {
        _navigateToMovieDetail(result);
      }
      result = await _chanel.invokeMethod<String>(movieInfoMethodGet);
      if (result != null && result.isNotEmpty) {
        _navigateToMovieInfo(result);
      }
    } catch (e) {
      // _navigateToError("Error getting data");
    }
  }

  //TODO Do a better implementation for managing navigation to not break
  // the Open/Close principle.
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case movieMethod:
        _navigateToMovieDetail(call.arguments as String);
        break;
      case movieInfoMethod:
        _navigateToMovieInfo(call.arguments as String);
        break;
      case meInfoMethod:
        _navigateToMeInfo();
        break;
      case selfPopBack:
        _isSelfPopBack = true;
        break;
      default:
        Navigator.pushReplacementNamed(
          context,
          RouteGenerator.error,
          arguments: "Unknown method",
        );
    }
  }

  @override
  void didPopNext() {
    if (_isSelfPopBack) {
      SystemNavigator.pop();
      _isSelfPopBack = false;
    }
    NativeBridge.instance.sendData("finish", "null");
  }

  void _navigateToMeInfo() {
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(RouteGenerator.meInfo);
      });
    } catch (e) {
      _navigateToError(e.toString());
    }
  }

  void _navigateToMovieDetail(String args) {
    try {
      final movie = MovieUI.fromJson(jsonDecode(args));

      SchedulerBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(
          RouteGenerator.movieDetail,
          arguments: movie,
        );
      });
    } catch (e) {
      _navigateToError(e.toString());
    }
  }

  void _navigateToMovieInfo(String args) {
    try {
      final movie = MovieUI.fromJson(jsonDecode(args));

      SchedulerBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.pushNamed(
          RouteGenerator.tempMovieInfo,
          arguments: movie,
        );
      });
    } catch (e) {
      _navigateToError(e.toString());
    }
  }

  void _navigateToError(String error) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed(
        RouteGenerator.error,
        arguments: error,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                ),
              ),
              const SizedBox(height: 16),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
