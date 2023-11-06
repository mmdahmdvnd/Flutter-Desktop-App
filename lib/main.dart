import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double targetHeight = screenHeight * 0.55; // ارتفاع مورد نظر: 55% از ارتفاع صفحه نمایش

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('نقشه و آیکون‌ها'),
        ),
        body: Stack(
          children: [
            // نمایش نقشه از بالا تا وسط صفحه
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: targetHeight,
              child: Container(
                color: Colors.blue[50],
                child: Center(
                  child: Text('نقشه در اینجا قرار می‌گیرد'),
                ),
              ),
            ),
            // نمایش آیکون‌ها در دو ردیف با چهار آیکون در هر ردیف
            Positioned(
              top: targetHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return Icon(
                        Icons.star,
                        size: 50.0,
                        color: Colors.orange,
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return Icon(
                        Icons.star,
                        size: 50.0,
                        color: Colors.orange,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}