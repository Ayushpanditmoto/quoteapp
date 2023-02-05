import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quoteapp/pages/login.screen.dart';
import 'package:quoteapp/pages/quotes.screen.dart';
import 'package:quoteapp/providers/auth.provider.dart';
import './app/theme.data.dart';
import 'app/route.app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Quotes App',
          theme: CustomTheme.lightTheme(),
          home: auth.isAuth
              ? const Quotes()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const Login(),
                ),
          initialRoute: '/',
          onGenerateRoute: MyRouter.generateRoute,
        ),
      ),
    );
  }
}
