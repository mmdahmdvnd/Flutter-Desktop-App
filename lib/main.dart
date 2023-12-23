import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:riverpod/riverpod.dart';
import 'AllCollectionRequest.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() => runApp(const MyApp());
void main() => runApp(
  ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => MyApp());
            case '/all_collection_request':
              return MaterialPageRoute(builder: (context) => AllCollectionRequest());
            default:
              return null;
          }
        },
      ),
  )
);

final targetHeightProvider = Provider<double>((_) => 0.55);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(51.5, -0.09),
                      zoom: 13.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                        "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}",
                        additionalOptions: {
                          'accessToken':
                          'pk.eyJ1IjoibW1kYWhtZHZuZCIsImEiOiJjbGFwMzlkaXgweGUzM3JuMDhyczNweWdyIn0.B5EDELTbtX58N3rDzOuPhw',
                          'id': 'mapbox.streets',
                        },
                      )
                    ],
                  ),
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
                      return Expanded(
                        child: InkWell(
                          // onTap: () {
                          //   if (index == 0) {
                          //     // اگر کلیک بر روی اولین تصویر از ردیف اول باشد
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(
                          //         builder: (context) => AllCollectionRequest(),
                          //       ),
                          //     );
                          //   }
                          // },
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).pushNamed('/all_collection_request');
                            }
                          },
                          child: Image.asset(
                            'assets/images/title_image_$index.png',
                            width: double.infinity,
                            height: targetHeight / 5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Image.asset(
                          'assets/images/title_image_$index.png',
                          width: double.infinity,
                          height: targetHeight / 5,
                          fit: BoxFit.cover,
                        ),
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

