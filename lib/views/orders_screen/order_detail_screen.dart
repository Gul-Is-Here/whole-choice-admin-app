import 'package:intl/intl.dart';
import 'package:whole_choice_admin_pannel/views/orders_screen/components/order_place.dart';
import 'package:whole_choice_admin_pannel/views/widgets/ourButton.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: orderDetail, size: 16.0, color: fontGrey),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          width: context.safePercentWidth,
          child: ourButton(
              color: Colors.green, onPress: () {}, title: "Confirm Order")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Visibility(
                visible: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: "Order status", color: fontGrey, size: 16.0),
                    SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Confirmed", color: fontGrey)),
                    SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey)),
                    SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "OnDelivery", color: fontGrey)),
                    SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Deliverd", color: fontGrey)),
                  ],
                )
                    .box
                    .outerShadowMd
                    .color(white)
                    .padding(const EdgeInsets.all(8))
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetail(
                      d1: "data['order_code']",
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetail(
                      d1: DateTime.now(),
                      d2: "data['payment_method']",
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlaceDetail(
                      d1: "Unpiad",
                      d2: 'Order Placed',
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "Shipping Address".text.fontFamily(semibold).make(),
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            "{data['order_by_name']}".text.make(),
                            "{data['order_by_email']}".text.make(),
                            "{data['order_by_country']}".text.make(),
                            "{data['order_by_state']}".text.make(),
                            "{data['order_by_city']}".text.make(),
                            "{data['order_by_address']}".text.make(),
                            "{data['order_by_postalcode']}".text.make(),
                            "{data['order_by_phone']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Total amount", color: purpleColor),
                              boldText(text: "\$300.0", color: red)
                              // "Total Amount".text.fontFamily(semibold).make(),
                              // "${data['total_amount']}"
                              //     .numCurrencyWithLocale()
                              //     .text
                              //     .color(redColor)
                              //     .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .outerShadowMd
                  .color(white)
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetail(
                          title1: "data['orders'][index]['title']",
                          title2: " data['orders'][index]['tprice']",
                          d1: "{data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .color(white)
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
