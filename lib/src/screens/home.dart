import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    boxAnimation = Tween(begin: 3.14 * 0.6, end: 3.14 * 0.67).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    catController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    catAnimation = Tween(begin: -30.0, end: -83.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeInOut,
      ),
    );

    catAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.stop();
      } else if (status == AnimationStatus.dismissed) {
        boxController.stop();
      }
    });
  }

  onTap() {
    boxController.forward();
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
              child: child,
              alignment: Alignment.topLeft,
              angle: boxAnimation.value);
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
              child: child,
              alignment: Alignment.topRight,
              angle: -boxAnimation.value);
        },
      ),
    );
  }
}
