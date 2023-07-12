import 'package:intl/intl.dart';
import 'package:whole_choice_admin_pannel/controller/order_controller.dart';
import 'package:whole_choice_admin_pannel/views/orders_screen/components/order_place.dart';
import 'package:whole_choice_admin_pannel/views/widgets/ourButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/const.dart';

class OrderDetail extends StatefulWidget {
  final dynamic data;
  const OrderDetail({super.key, this.data});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var controller = Get.find<orderController>();
  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.confirmed.value = widget.data['order_on_delivered'];
    controller.confirmed.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: darkGrey),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: orderDetail, size: 16.0, color: fontGrey),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
              height: 60,
              width: context.safePercentWidth,
              child: ourButton(
                  color: Colors.green,
                  onPress: () {
                    controller.confirmed(true);
                    controller.changeStatus(
                        "order_confirmed", true, widget.data.id);
                  },
                  title: "Accept or Declined")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(
                          text: "Order status", color: fontGrey, size: 16.0),
                      SwitchListTile(
                          activeColor: green,
                          value: true,
                          onChanged: (value) {},
                          title: boldText(
                              text: "Receive Inquire", color: fontGrey)),
                      SwitchListTile(
                          activeColor: green,
                          value: controller.confirmed.value,
                          onChanged: (value) {
                            controller.confirmed.value = value;
                          },
                          title: boldText(text: "Checked", color: fontGrey)),
                      SwitchListTile(
                          activeColor: green,
                          value: controller.ondelivery.value,
                          onChanged: (value) {
                            controller.ondelivery.value = value;
                            controller.changeStatus(
                                "order_on_delivered", value, widget.data.id);
                          },
                          title: boldText(text: "Declined", color: fontGrey)),
                      SwitchListTile(
                          activeColor: green,
                          value: controller.delivered.value,
                          onChanged: (value) {
                            controller.delivered.value = value;
                            controller.changeStatus(
                                "order_delivered", value, widget.data.id);
                          },
                          title: boldText(text: "Shipped", color: fontGrey)),
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
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetail(
                        d1: intl.DateFormat()
                            .add_yM()
                            .format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
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
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_country']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_postalcode']}"
                                  .text
                                  .make(),
                              "${widget.data['order_by_phone']}".text.make(),
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
                                boldText(
                                    text: "\$${widget.data['total_amount']}",
                                    color: red)
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
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        "${controller.orders[index]['title']}"
                            .text
                            .bold
                            .color(purpleColor)
                            .make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            "Amount".text.bold.make(),
                            "${controller.orders[index]['tprice']}"
                                .numCurrencyWithLocale()
                                .text
                                .color(red)
                                .make(),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Quantity".text.bold.make(),
                            "${controller.orders[index]['qty']}x".text.make(),
                          ],
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              "Color".text.bold.make(),
                              Container(
                                width: 30,
                                height: 20,
                                color: Color(controller.orders[index]['color']),
                              ),
                            ],
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
      ),
    );
  }
}
