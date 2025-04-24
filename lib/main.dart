import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_movie_detail/presenter/route_generator.dart';
import 'package:my_movie_detail/presenter/ui/style/movie_theme.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final routerObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: movieTheme.primaryColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      theme: movieTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: [routerObserver],
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.home,
    );
  }
}
