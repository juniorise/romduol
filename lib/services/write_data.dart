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

  String toID(String id) {
    String tmp = '';
    for (int i = 0; i < id.length; i++) {
      if (id[i] == ' ') {
        tmp += "_";
      } else
        tmp += id[i];
    }

    return tmp;
  }

  Future<void> uploadToProvince(
      {CardModel data, String province, String category, String uid}) async {
    var comments = List();
    comments = data.comments != null && data.comments.length > 0
        ? data.comments
            .map((e) => {
                  'comment': e.comment,
                  'rate': e.rating,
                  "date": e.date,
                  "uid": e.uid,
                })
            .toList()
        : List();

    String id = toID(data.id);
    print(id);
    instance.doc('$province/$category/default_data/${data.id}/').set({
      "province": province,
      "category": category,
      "title": data.title,
      "location": data.location,
      "thumbnail": data.thumbnail,
      "id": id,
      "pricefrom": data.pricefrom,
      "pricetotal": data.pricetotal,
      "maplocation": data.maplocation,
      "images": FieldValue.arrayUnion(data.images),
      "articles": FieldValue.arrayUnion(data.articles),
      "authur": uid,
      "lastmodified": Timestamp.now(),
      "comments": comments.length > 0 ? FieldValue.arrayUnion(comments) : null,
    });
  }

  Future draftToProvince({
    CardModel data,
    String province,
    String category,
    String uid,
  }) async {
    var comments = List();
    comments = data.comments
        .map((e) => {
              'comment': e.comment,
              'rate': e.rating,
              "date": e.date,
              "uid": e.uid,
            })
        .toList();

    String id = toID(data.id);
    print(id);
    await instance.collection("userData/$uid/provincedraft").doc(data.id).set(
      {
        "province": province,
        "category": category,
        "title": data.title,
        "location": data.location,
        "thumbnail": data.thumbnail,
        "id": id,
        "pricefrom": data.pricefrom,
        "pricetotal": data.pricetotal,
        "maplocation": data.maplocation,
        "images": FieldValue.arrayUnion(data.images),
        "articles": FieldValue.arrayUnion(data.articles),
        "authur": uid.trim(),
        "lastmodified": Timestamp.now(),
        "comments":
            comments.length > 0 ? FieldValue.arrayUnion(comments) : null,
      },
    );
  }
}
