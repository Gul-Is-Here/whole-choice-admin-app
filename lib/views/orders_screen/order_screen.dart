import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/views/orders_screen/order_detail_screen.dart';

import 'package:whole_choice_admin_pannel/views/widgets/appBar_widget.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart' as intl;

import '../widgets/style_text.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(orders),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                        20,
                        (index) => ListTile(
                              onTap: (() {
                                Get.to(() => OrderDetail());
                              }),
                              tileColor: textfieldGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              title: boldText(
                                  text: "8987667857556", color: purpleColor),
                              subtitle: Column(children: [
                                Row(children: [
                                  const Icon(Icons.calendar_month),
                                  10.widthBox,
                                  boldText(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(DateTime.now()),
                                      color: fontGrey)
                                ]),
                                Row(children: [
                                  const Icon(Icons.payment),
                                  10.widthBox,
                                  boldText(text: unPaid, color: red)
                                ])
                              ]),
                              trailing:
                                  normalText(text: "\$88", color: purpleColor),
                            )
                                .box
                                .margin(const EdgeInsets.only(bottom: 4))
                                .rounded
                                .make())))));
  }
}
