import 'package:flutter/material.dart';

class ProvinceModel {
  final String province;
  final int views;
  final String imagelocation;

  ProvinceModel({this.province, this.views, this.imagelocation});
}

class CardModel {
  final String title, location, imageLocation, price, id;
  final double ratestar;
  final int ratetotal;

  CardModel({
    this.ratetotal,
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
  final String id;

  PackageModel({
    this.imagelocation,
    this.total,
    this.booked,
    this.title,
    this.location,
    this.date,
    this.price,
    this.id,
  });
}

class CommentModel {
  final String name, comment, imgProfile;
  final double ratestar;
  final int like, dislike;

  CommentModel({
    @required this.name,
    @required this.comment,
    @required this.imgProfile,
    @required this.ratestar,
    @required this.like,
    @required this.dislike,
  });
}
