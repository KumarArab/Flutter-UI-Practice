import 'package:flutter/material.dart';
import 'package:testapp/UIs/crossSell/location_data.dart';

import 'location_list_item.dart';



class ParallaxRecipe extends StatelessWidget {
  const ParallaxRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingleChildScrollView(
        child: Column(
          children: [
            for (final location in dummyLocations)
              LocationListItem(
                imageUrl: location.imageUrl,
                name: location.name,
                country: location.place,
              ),
          ],
        ),
      ),
    );
  }
}
