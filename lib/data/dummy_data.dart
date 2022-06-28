import 'package:flutter/material.dart';
import 'package:where_to_eat/models/category.dart';
import 'package:where_to_eat/models/restaurant.dart';
import 'package:where_to_eat/models/review.dart';

import '../models/review_item.dart';

// ignore: non_constant_identifier_names
var DUMMY_Reviews = [
  Review(
      id: 'r1',
      serviceRating: 4.5,
      tasteRating: 4.0,
      costRating: 4.5,
      quantityRating: 4.5,
      totalRating: 6.5,
      authorId: 'as',
      authorName: 'Kamool',
      restaurantName: 'Kentucky',
      isLiked: true,
      branchtId: '',
      authorImage: '',
      isUpvoted: false,
      isDownvoted: false,
      reviewText:
          'This is Not the best place in terms of cost, but still liked the experience',
      upVotes: 13,
      downVotes: 3,
      restaurantId: '',
      location: 'Nasr City',
      reviewItems: [
        const ReviewItem(
            id: 'm',
            title: 'Rizo',
            foodType: FoodType.FOOD,
            price: 40,
            rating: 4,
            description:
                "the rice was good, but the chikcen pieces wasn't the best")
      ]),
  Review(
      id: 'r1',
      serviceRating: 8.5,
      tasteRating: 8.0,
      isUpvoted: false,
      isDownvoted: false,
      costRating: 6.5,
      quantityRating: 7.5,
      totalRating: 8.5,
      authorId: 'as',
      authorName: 'Kamool',
      restaurantName: 'Hardees',
      isLiked: true,
      branchtId: '',
      authorImage: '',
      reviewText:
          'Great Prices, Good service overall, and the new offer was awesome',
      upVotes: 12,
      downVotes: 1,
      restaurantId: '',
      location: 'Merghany',
      reviewImages: [
        'https://i0.wp.com/www.theimpulsivebuy.com/wordpress/wp-content/uploads/2022/04/hardfrisco1.jpeg'
      ],
      reviewItems: [
        const ReviewItem(
            id: 'm',
            title: 'Double Hardy',
            foodType: FoodType.FOOD,
            price: 55,
            rating: 4,
            description: 'Good,juicy, tasty')
      ]),
  Review(
    id: 'r2',
    isUpvoted: false,
    isDownvoted: false,
    serviceRating: 3.5,
    tasteRating: 2.0,
    costRating: 1.5,
    authorId: 'as',
    authorName: 'Kamel',
    restaurantName: 'Hamada',
    isLiked: true,
    branchtId: '',
    location: 'sad',
    authorImage: '',
    quantityRating: 3.5,
    totalRating: 7.5,
    reviewText: 'Prices are high, worst service, worst experience',
    upVotes: 3,
    downVotes: 0,
    restaurantId: '',
  ),
  Review(
    id: 'r3',
    serviceRating: 5,
    tasteRating: 4.5,
    costRating: 5,
    quantityRating: 5,
    totalRating: 7.5,
    isUpvoted: false,
    isDownvoted: false,
    authorId: 'as',
    authorName: 'Kamel',
    restaurantName: 'Hamada',
    isLiked: true,
    branchtId: '',
    location: 'sad',
    authorImage: '',
    reviewText: 'Best place for your family gatherings, great prices',
    upVotes: 2,
    downVotes: 1,
    restaurantId: '',
  ),
  Review(
    id: 'r4',
    serviceRating: 4.5,
    tasteRating: 4.0,
    costRating: 4.5,
    quantityRating: 4.5,
    isUpvoted: false,
    isDownvoted: false,
    totalRating: 7.5,
    reviewText:
        'This is Not the best place in terms of cost, but still liked the experience',
    upVotes: 40,
    downVotes: 20,
    restaurantId: '',
    authorId: 'as',
    authorName: 'Kamel',
    restaurantName: 'Hamada',
    isLiked: true,
    branchtId: '',
    authorImage: '',
    location: 'sad',
  ),
  Review(
    id: 'r5',
    isUpvoted: false,
    isDownvoted: false,
    serviceRating: 3.5,
    tasteRating: 3.0,
    costRating: 4.5,
    restaurantId: '',
    authorId: 'as',
    authorName: 'Kamel',
    restaurantName: 'Hamada',
    isLiked: true,
    branchtId: '',
    authorImage: '',
    quantityRating: 3.5,
    totalRating: 7.5,
    reviewText:
        'An Average Experience with an acceptable service, would come again another time, But not soon',
    upVotes: 40,
    downVotes: 20,
    location: 'Branch F',
  ),
];
const DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Italian',
    icon: Icons.food_bank,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
  ),
  Category(
    id: 'c2',
    title: 'Tasty',
    icon: Icons.rotate_right_rounded,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
  ),
  Category(
    id: 'c3',
    title: 'Hamburgers',
    icon: Icons.food_bank_sharp,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
  ),
  Category(
    id: 'c4',
    title: 'German',
    icon: Icons.flag,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
  ),
  Category(
    id: 'c5',
    title: 'Light & Lovely',
    icon: Icons.light_mode,
    imageUrl:
        'https://img.jamieoliver.com/jamieoliver/recipe-database/2qnhNmtM4pc9NlAYOSSF9J.jpg?tr=w-330',
  ),
  Category(
    id: 'c6',
    title: 'Exotic',
    icon: Icons.fireplace,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
  ),
  Category(
    id: 'c7',
    title: 'Breakfast',
    icon: Icons.settings,
    imageUrl:
        'https://cdn.tatlerasia.com/asiatatler/i/ph/2021/05/07105034-gettyimages-1257260385_cover_1280x764.jpg',
  ),
  Category(
    id: 'c8',
    title: 'Asian',
    icon: Icons.settings,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
  ),
  Category(
    id: 'c9',
    title: 'French',
    icon: Icons.settings,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
  ),
  Category(
      id: 'c10',
      title: 'Summer',
      icon: Icons.settings,
      imageUrl:
          'https://img.jamieoliver.com/jamieoliver/recipe-database/2qnhNmtM4pc9NlAYOSSF9J.jpg?tr=w-330'),
];

const DUMMY_RestaurantS = [
  Restaurant(
    totalRating: 5,
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Spaghetti House',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'Toast Hawaii',
    serviceRating: 4.3,
    tasteRating: 3.3,
    costRating: 6.5,
    quantityRating: 2.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Hamburger Heaven',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Wiener Schnitzel',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm5',
    categories: [
      'c2'
          'c5',
      'c10',
    ],
    title: 'Salad with Smoked Salmon',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm6',
    categories: [
      'c6',
      'c10',
    ],
    title: 'Delicious Orange Mousse',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/pastry-2274750_asda1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm7',
    categories: [
      'c7',
    ],
    title: 'Pancakes',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm8',
    categories: [
      'c8',
    ],
    title: 'Creamy Indian Chicken Curry',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm9',
    categories: [
      'c9',
    ],
    title: 'Chocolate Souffle',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
  ),
  Restaurant(
    totalRating: 5,
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c10',
    ],
    title: 'Asparagus Salad with Cherry Tomatoes',
    serviceRating: 4.3,
    tasteRating: 4.3,
    costRating: 3.5,
    quantityRating: 4.5,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
  ),
];
