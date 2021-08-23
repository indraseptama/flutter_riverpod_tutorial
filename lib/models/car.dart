class Car {
  int id;
  String name;
  String urlImage;
  int rentalFeePerDay;
  bool isFavorite;
  String hexColor;

  Car(
      {required this.id,
      required this.name,
      required this.urlImage,
      required this.rentalFeePerDay,
      required this.isFavorite,
      required this.hexColor});

  Car.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        urlImage = json['urlImage'],
        rentalFeePerDay = json['rentalFeePerDay'],
        isFavorite = json['isFavorite'],
        hexColor = json['hexColor'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'urlImage': urlImage,
        'rentalFeePerDay': rentalFeePerDay,
        'isFavorite': isFavorite,
        'hexColor': hexColor
      };
}
