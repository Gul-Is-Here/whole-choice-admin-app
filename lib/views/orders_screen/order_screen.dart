import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/order_controller.dart';
import 'package:whole_choice_admin_pannel/services/store_services.dart';
import 'package:whole_choice_admin_pannel/views/orders_screen/order_detail_screen.dart';

import 'package:whole_choice_admin_pannel/views/widgets/appBar_widget.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart' as intl;
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import '../widgets/style_text.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(orderController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreService.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: (() {
                        Get.to(() => OrderDetail(
                              data: data[index],
                            ));
                      }),
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
                      subtitle: Column(children: [
                        Row(children: [
                          const Icon(Icons.calendar_month),
                          10.widthBox,
                          boldText(
                              text: intl.DateFormat().add_yMd().format(time),
                              color: fontGrey)
                        ]),
                        Row(children: [
                          const Icon(Icons.payment),
                          10.widthBox,
                          boldText(text: unPaid, color: red)
                        ])
                      ]),
                      trailing: normalText(
                          text: "\$${data[index]['total_amount']}",
                          color: purpleColor),
                    )
                        .box
                        .margin(const EdgeInsets.only(bottom: 4))
                        .rounded
                        .make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
