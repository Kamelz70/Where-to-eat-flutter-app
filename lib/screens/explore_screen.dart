import 'package:flutter/material.dart';
import 'package:where_to_eat/data/dummy_data.dart';

//////////////////////////////////////////////
/// widgets
import 'package:where_to_eat/widgets/category_item.dart';

class ExploreScreen extends StatelessWidget {
  static const routeName = 'explore';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: GridView(
            padding: const EdgeInsets.all(25),
            children: DUMMY_CATEGORIES
                .map((item) => CategoryItem(item.id, item.title, item.icon))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              childAspectRatio: 12 / 13,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
      ),
    );
  }
}
