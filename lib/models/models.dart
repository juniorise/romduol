import 'package:cloud_firestore/cloud_firestore.dart';

class ProvinceModel {
  final String province, id, enprovince;
  final int views;
  final String imagelocation;

  ProvinceModel({
    this.id,
    this.enprovince,
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
  final String title, location, thumbnail, opentime, id, refpath;
  final int ratetotal;
  final double rating, pricefrom, pricetotal;
  final GeoPoint maplocation;
  final List<dynamic> images;
  final List<dynamic> articles;
  final String authur;
  final List<FoodMenu> foodmenu;

  CardModel({
    this.images,
    this.articles,
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
    this.refpath,
    this.authur,
    this.foodmenu,
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

class FoodMenu {
  final String thumbnail, title;
  final String price;

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

class WhyTourPackage {
  final String imageLocation, title, des, link;

  WhyTourPackage({this.imageLocation, this.title, this.des, this.link});
}

class UsefulPackParent {
  final String path, title;

  UsefulPackParent({this.path, this.title});
}
