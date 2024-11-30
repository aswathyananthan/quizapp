import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/utils/models/questionmodel.dart';
import 'package:quiz_app/utils/models/usermodel.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> read(String uid) {
    return _firestore
        .collection("questions")
        .snapshots();
  }

Future writeuser(Usermodel user) async {
    try {
      final res = await _firestore.collection("users").doc().set(user.toJSON());
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
}
Future<QueryDocumentSnapshot?> getUser(String id) async {
    try {
      final user = await _firestore.collection("users").where("userid", isEqualTo: id).get();
      return user.docs.single;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
Future add(Questionmodel question) async {
    try {
      final res = await _firestore.collection("questions").doc().set(question.toJSON());
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  Future<void> delete(String docId) async {
    await _firestore.collection("questions").doc(docId).delete();
  }
 
//  Future updateuser(String id, Usermodel user) async {
//     try {
//       final res = await _firestore.collection("users").doc().set(user.toJSON());
//       return res;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

  Future<void> updateUserCompletedQuestions(String userId, String questionId) async {
    final userDoc = _firestore.collection("users").doc(userId);
    await userDoc.update({
      "completed": FieldValue.arrayUnion([questionId]),
    });
  }

  createUserIfNotExists(String userId) {}


}



