class ProvinceModel {
  final String province;
  final String location;
  final String imagelocation;

  ProvinceModel({this.province, this.location, this.imagelocation});
}

class CardModel {
  final String title, location, imageLocation, price, id;
  final double ratestar;

  CardModel({
    this.ratestar,
    this.price,
    this.title,
    this.location,
    this.imageLocation,
    this.id,
  });
}

class PackageModel {
  final String imagelocation;
  final int total;
  final int booked;
  final String title;
  final String location;
  final String date;
  final int price;

  PackageModel({
    this.imagelocation,
    this.total,
    this.booked,
    this.title,
    this.location,
    this.date,
    this.price,
  });
}
