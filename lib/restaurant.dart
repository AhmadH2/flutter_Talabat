class Restaurant {
  int id;
  String name;
  String city;
  int rating;
  String image;

  Restaurant({this.name, this.city, this.rating, this.image, this.id});
  factory Restaurant.fromJson(dynamic jsonObject) {
    return Restaurant(
      name: jsonObject['name'] as String,
      city: jsonObject['city'] as String,
      rating: jsonObject['rating'] as int,
      image: jsonObject['image'] as String,
      id: jsonObject['id'] as int,
    );
  }
}
