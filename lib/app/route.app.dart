import 'package:flutter/material.dart';
import 'package:quoteapp/pages/login.screen.dart';
import 'package:quoteapp/pages/quotes.screen.dart';

class MyRouter {
  static const String login = '/';
  static const String signup = '/signup';
  static const String quotes = '/quotes';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case quotes:
        return MaterialPageRoute(builder: (_) => const Quotes());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
