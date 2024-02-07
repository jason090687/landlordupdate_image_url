class BoardingHouse {
  final String imageUrl;
  final String discount;
  final String rating;
  final String name;
  final String location;
  final String price;

  BoardingHouse({
    required this.imageUrl,
    required this.discount,
    required this.rating,
    required this.name,
    required this.location,
    required this.price,
  });
}

class Amenity {
  final String imgPath;
  final String aminity;
  final String internet;

  Amenity({
    required this.imgPath,
    required this.aminity,
    required this.internet,
  });
}

class Board {
  final String imagePath;
  final String bhname;
  final String bhdiscount;
  final String bhrating;
  final String reviews;
  final String bhlocation;
  final String description;
  final String contactname;
  final String bhprice;

  Board(
      {required this.imagePath,
      required this.bhdiscount,
      required this.bhlocation,
      required this.bhname,
      required this.bhprice,
      required this.bhrating,
      required this.contactname,
      required this.description,
      required this.reviews});
}
