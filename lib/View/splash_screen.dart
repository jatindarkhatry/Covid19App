import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:covid_tracker/StatesOfWorld.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late final AnimationController controller= AnimationController(
    duration: const Duration(seconds: 7),
    vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const StatesOfWorld())));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
          AnimatedBuilder(
               animation: controller,
               child: Container(
                 height: 200,
                 width:  200,
                 child: const Center(
                   child: Image(image: AssetImage('images/virus.png')),
                 ),
               ),
               builder: (BuildContext context, Widget? child){
             return Transform.rotate(
                 angle: controller.value*2.0*math.pi,
               child: child,
             );
           }),

            SizedBox(height: MediaQuery.of(context).size.height*0.08,),


            const Align(
              alignment: Alignment.center,
              child: Text("  Covid-19\nTracker App",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 25,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
