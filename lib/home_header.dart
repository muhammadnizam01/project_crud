import 'package:flutter/material.dart';
import 'package:project_uas/size_config.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible, 
      alignment: Alignment.center,
      children: [
        Image.asset(
          "img/home_bg.png",
          height: getProportionateScreenWidth(315),
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(80)),
            Text(
              "NanjakBareng",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 0.5),
            ),
            Text(
              'Aplikasi Ndaki Bareng',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        // Positioned(
        //   bottom: getProportionateScreenWidth(-25),
        // ),
      ],
    );
  }
}
