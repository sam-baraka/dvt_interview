import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      context.replace('/main-home-page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            style: FlutterLogoStyle.stacked,
            textColor: Colors.purple,
            size: 100,
          ),
          SizedBox(height: 20),
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
