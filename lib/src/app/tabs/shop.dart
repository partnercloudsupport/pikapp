import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ShopTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        color: Colors.orangeAccent,
        fontSize: 24.0,
        fontWeight: FontWeight.bold);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Presto disponibile!',
            style: textStyle,
          ),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              'https://img0.etsystatic.com/site-assets/vesta-homepage-headers-v3/mothers_day_2018/MothersDay_HP_Primary_860x640.1.jpg',
          fit: BoxFit.fitWidth,
          fadeOutDuration: Duration(),
          fadeInDuration: Duration(milliseconds: 150),
        ),
      ],
    );
  }
}
