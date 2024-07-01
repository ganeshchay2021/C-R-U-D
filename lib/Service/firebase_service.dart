import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference empDetails =
      FirebaseFirestore.instance.collection("Employee Details");

  
  //create
  Future<void> addEmpDetails(
      String name, String age, String location, String imageUrl) {
    return empDetails.add(
        {"Name": name, "Age": age, "Location": location, "Image": imageUrl});
  }

  //read
  Stream<QuerySnapshot> getEmpDetails() {
    final empDetailsStream = empDetails.orderBy("Name").snapshots();
    return empDetailsStream;
  }

  //delete
  Future<void> deleteEmpDetails(String docId) {
    return empDetails.doc(docId).delete();
  }

  //delete all
  Future<void> deleteAllEmpDetails() async {
    QuerySnapshot querySnapshot = await empDetails.get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  //update
  Future<void> updateEmpDetails(
      String docId, String newName, String newAge, String newLocation) {
    return empDetails.doc(docId).update({
      "Name": newName,
      "Age": newAge,
      "Location": newLocation,
    });
  }
}
