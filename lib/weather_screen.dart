import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('300.67 °K', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Icon(Icons.cloud, size: 64,),
                          SizedBox(height: 10,),
                          Text('Rain', style: TextStyle(fontSize: 24),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // card row
            const Placeholder(
              fallbackHeight: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            // misc. info.
            const Placeholder(
              fallbackHeight: 150,
            ),
          ],
        ),
      ),
    );
  }

}