import 'package:cloud_firestore/cloud_firestore.dart';

import '../skadi_firebase.dart';

extension CollectionReferenceExtension on CollectionReference {
  Future<void> updateDocument(String id, Map<String, dynamic> data) async {
    await doc(id).update({
      ...data,
      "updated": nowUtcIso,
    });
  }

  Future<String> createDocument(
    Map<String, dynamic> data, {
    String? docId,
    DateTime? created,
    DateTime? updated,
  }) async {
    var dId = docId ?? doc().id;
    data.remove("id");
    data["created"] = created?.toIso8601String() ?? nowUtcIso;
    data["updated"] = updated?.toIso8601String() ?? nowUtcIso;
    await doc(dId).set({
      "id": dId,
      ...data,
    });
    return dId;
  }
}
