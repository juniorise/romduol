class CardModal {
  final String title, location, imageLocation, price, id;
  final double ratestar;

  CardModal({
    this.ratestar,
    this.price,
    this.title,
    this.location,
    this.imageLocation,
    this.id,
  });
}

class Package {
  final String imagelocation;
  final int total;
  final int booked;
  final String title;
  final String location;
  final String date;
  final int price;

  Package({
    this.imagelocation,
    this.total,
    this.booked,
    this.title,
    this.location,
    this.date,
    this.price,
  });
}
