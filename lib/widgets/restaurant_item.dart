import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../screens/restaurant_page_screen.dart';

class RestaurantItem extends StatelessWidget {
///////////////////////////////////////////////////////////////////
  ///
  ///           Vars and consts
  final Restaurant currentRestaurant;
  const RestaurantItem(this.currentRestaurant);

  static const foodImagePath = 'assets/images/item-review-images/food.png';

  ///////////////////////////////////////////////////////////////////
  ///
  ///           Functions

  //select meal tap function handler
  void _selectRestaurant(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RestaurantPageScreen(restaurant: restaurant)));
  }
///////////////////////////////////////////////////////////////////
  ///
  ///           Build

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectRestaurant(context, currentRestaurant),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 7,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  /////////////////title
                  currentRestaurant.title,
                  style: Theme.of(context).textTheme.headline4,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.star_rounded,
                      color: Theme.of(context).colorScheme.primary),

                  /////////////////rating
                  Text(((currentRestaurant.quantityRating +
                              currentRestaurant.tasteRating +
                              currentRestaurant.serviceRating +
                              currentRestaurant.costRating) /
                          4)
                      .toString()),
                  const SizedBox(width: 10),
                  Icon(Icons.attach_money,
                      color: Theme.of(context).colorScheme.primary),

                  /////////////////rating
                  const Text("70-80"),
                ],
              ),
              // const Text('Location Data'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        currentRestaurant.imageUrl,
                        fit: BoxFit.cover,
                        height: 200,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, sad, asd) {
                          return Image.asset(foodImagePath, height: 150);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(1),
                        icon: const Icon(Icons.keyboard_arrow_right,
                            color: Colors.white),
                        color: Colors.white,
                        onPressed: () =>
                            _selectRestaurant(context, currentRestaurant),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
