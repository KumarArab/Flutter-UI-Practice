import 'package:flutter/material.dart';
import 'package:testapp/UIs/Staggered%20Grid%20View/data.dart';
import 'package:testapp/utils/size_config.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Meal> mealData = SData().mealData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meals",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: SizeConfig.width! / 2,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemCount: mealData.length,
            itemBuilder: (ctx, i) => Transform.translate(
                offset: Offset(0, i.isOdd ? 100 : 0),
                child: GridItem(meal: mealData[i]))),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Meal meal;
  const GridItem({Key? key, required this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black26,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(meal.assetPath),
            ),
            const SizedBox(height: 8),
            Text(
              meal.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(meal.description, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    meal.rating,
                    (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        )))
          ],
        ),
      ),
    );
  }
}
