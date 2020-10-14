import 'package:cloud_firestore/cloud_firestore.dart';

class ProvinceModel {
  final String province;
  final int views;
  final String imagelocation;

  ProvinceModel({
    this.province,
    this.views,
    this.imagelocation,
  });
}

class ArticleModal {
  final String header, paragraph, question;

  ArticleModal({this.header, this.paragraph, this.question});
}

class CardModel {
  final String title, location, thumbnail, opentime, id;
  final ratetotal;
  final double rating, pricefrom, pricetotal;
  final GeoPoint maplocation;

  CardModel({
    this.pricefrom,
    this.pricetotal,
    this.id,
    this.title,
    this.location,
    this.ratetotal,
    this.rating,
    this.opentime,
    this.maplocation,
    this.thumbnail,
  });
}

class PackageModel {
  final String title, location, thumbnail, date, id, refpath;
  final GeoPoint maplocation, buslocation;
  final int bookedspace, totalspace;
  final double price;

  PackageModel({
    this.id,
    this.title,
    this.location,
    this.thumbnail,
    this.date,
    this.maplocation,
    this.buslocation,
    this.bookedspace,
    this.totalspace,
    this.price,
    this.refpath,
  });
}

class Article {
  final String header, paragraph;
  Article({
    this.header,
    this.paragraph,
  });
}

class FoodMenu {
  final String thumbnail, title;
  final double price;

  FoodMenu({
    this.thumbnail,
    this.title,
    this.price,
  });
}

class CommentModel {
  final String name, uid, comment, profileimg;
  final int rating, useful, useless;
  final Timestamp date;

  CommentModel({
    this.name,
    this.uid,
    this.comment,
    this.profileimg,
    this.rating,
    this.useful,
    this.useless,
    this.date,
  });
}
