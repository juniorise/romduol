import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class WriteData {
  final instance = FirebaseFirestore.instance;

  Future<void> uploadToProvince(
      {CardModel data, String province, String category, String uid}) async {
    instance.doc('$province/$category/default_data/${data.id}/').set({
      "province": province,
      "category": category,
      "title": data.title,
      "location": data.location,
      "thumbnail": data.thumbnail,
      "id": data.id,
      "pricefrom": data.pricefrom,
      "pricetotal": data.pricetotal,
      "rating": data.rating,
      "ratetotal": data.ratetotal,
      "maplocation": data.maplocation,
      "images": FieldValue.arrayUnion(data.images),
      "articles": FieldValue.arrayUnion(data.articles),
      "authur": uid,
    });

    // await instance
    //     .collection("userData/$uid/provincedraft")
    //     .doc(data.id)
    //     .delete();
  }

  Future draftToProvince({
    CardModel data,
    String province,
    String category,
    String uid,
  }) async {
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
        "rating": data.rating,
        "ratetotal": data.ratetotal,
        "maplocation": data.maplocation,
        "images": FieldValue.arrayUnion(data.images),
        "articles": FieldValue.arrayUnion(data.articles),
        "authur": uid,
      },
    );
  }
}
