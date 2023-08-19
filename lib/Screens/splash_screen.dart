import 'dart:async';
import 'dart:math' as math;
import 'package:covid_19_tracker_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.linear,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const HomeScreen();
      }));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: animation.value * 2.0 * math.pi,
                    child: child,
                  );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(
                      image: AssetImage("assets/images/virus_image.png"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Text(
                "COVID-19\nTracker App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
