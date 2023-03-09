import 'package:whole_choice_admin_pannel/const/const.dart';

class StoreService {
  static getProfile(uid) {
    return firestore.collection("vendors").where('id', isEqualTo: uid).get();
  }

  static getAllMessages(uid) {
    return firestore
        .collection(chatsCollection)
        .where(
          'toId',
        )
        .snapshots();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection("products")
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore
  //       .collection(productsCollection)
  //       .where("vendor_id", isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
