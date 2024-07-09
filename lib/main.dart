import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(BitCoin());

class BitCoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Color(0xFFBFA0FD),),
      title:'BitCoin',

      debugShowCheckedModeBanner: false,
      home: PriceScreen(),
    );
  }
}