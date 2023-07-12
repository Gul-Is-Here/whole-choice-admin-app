import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';

// ignore: camel_case_types
class orderController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
    print(orders);
  }

  changeStatus(title, status, docID) async {
    var store = firestore.collection(ordersCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
