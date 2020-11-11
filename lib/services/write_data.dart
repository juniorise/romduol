import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class CommentFirebase {
  final String comment, uid;
  final Timestamp date;
  final double rate;

  CommentFirebase({this.comment, this.uid, this.date, this.rate});
}

class WriteData {
  final instance = FirebaseFirestore.instance;

  Future<void> uploadRecommend(
      {String text, double rate, String ref, String uid}) async {
    Timestamp time = Timestamp.now();
    Map<String, dynamic> inputcomment = {
      'comment': text,
      'rate': rate,
      "date": time,
      "uid": uid
    };

    var list = [inputcomment];
    dynamic res = instance.doc(ref).update({
      "comments": FieldValue.arrayUnion(list),
    });

    return res;
  }

  Future<void> uploadToProvince(
      {CardModel data, String province, String category, String uid}) async {
    
    var comments = data.comments
        .map((e) => {
              'comment': e.comment,
              'rate': e.rating,
              "date": e.date,
              "uid": e.uid,
            })
        .toList();

    instance.doc('$province/$category/default_data/${data.id}/').set({
      "province": province,
      "category": category,
      "title": data.title,
      "location": data.location,
      "thumbnail": data.thumbnail,
      "id": data.id,
      "pricefrom": data.pricefrom,
      "pricetotal": data.pricetotal,
      "maplocation": data.maplocation,
      "images": FieldValue.arrayUnion(data.images),
      "articles": FieldValue.arrayUnion(data.articles),
      "authur": uid,
      "comments": comments != null ? FieldValue.arrayUnion(comments) : null,
    });
  }

  Future draftToProvince({
    CardModel data,
    String province,
    String category,
    String uid,
  }) async {
    var comments = data.comments
        .map((e) => {
              'comment': e.comment,
              'rate': e.rating,
              "date": e.date,
              "uid": e.uid,
            })
        .toList();
    await instance.collection("userData/$uid/provincedraft").doc(data.id).set(
      {
        "province": province,
        "category": category,
        "title": data.title,
        "location": data.location,
        "thumbnail": data.thumbnail,
        "id": data.id,
        "pricefrom": data.pricefrom,
        "pricetotal": data.pricetotal,
        "maplocation": data.maplocation,
        "images": FieldValue.arrayUnion(data.images),
        "articles": FieldValue.arrayUnion(data.articles),
        "authur": uid,
        "comments": FieldValue.arrayUnion(comments),
      },
    );
  }
}
