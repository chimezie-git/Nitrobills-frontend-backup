import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nitrobills/app/ui/utils/nb_json.dart';

class BallLoader extends StatefulWidget {
  const BallLoader({super.key});

  @override
  State<BallLoader> createState() => _BallLoaderState();
}

class _BallLoaderState extends State<BallLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      NbLottie.ballLoaderV2,
      height: 80.r,
      width: 80.r,
      // alignment: Alignment(0, -1),
      alignment: Alignment.topCenter,
      fit: BoxFit.fitWidth,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
