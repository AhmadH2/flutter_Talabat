class Dish {
  String title;
  String description;
  double price;
  double rating;
  String image;
  bool isFavorite;

  Dish(
      {this.title,
      this.description,
      this.price,
      this.image,
      this.rating,
      this.isFavorite});

  factory Dish.fromJson(dynamic jsonObject) {
    return Dish(
      title: jsonObject['name'],
      description: jsonObject['descr'],
      price: double.parse(jsonObject['price'].toString()),
      image: jsonObject['image'],
      rating: null,
      isFavorite: false,
    );
  }
}
