import 'package:flutter/material.dart';
import 'package:food_app/components/globals.dart';
import 'package:food_app/view/main_dashboard.dart';
import 'package:kartal/kartal.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2200), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainDashboard()),
          (Route<dynamic> route) => false);
    });
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          landing,
          width: context.width,
          height: context.height,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 17)],
            borderRadius: BorderRadius.circular(context.width * 0.3),
            color: Color(0xff050504),
          ),
          height: context.width * 0.6,
          width: context.width * 0.6,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(logo, height: context.height * 0.12)),
      ],
    );
  }
}
