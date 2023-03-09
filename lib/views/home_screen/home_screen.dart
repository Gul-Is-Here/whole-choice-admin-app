import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/services/store_services.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/product_detail.dart';
import 'package:whole_choice_admin_pannel/views/widgets/appBar_widget.dart';
import 'package:whole_choice_admin_pannel/views/widgets/dashboard_button.dart';
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreService.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

//  data = data.sortedBy((a, b) =>
//                 a['p_wishlist'].lenght.compareTo(b['p_wishlist'].lenght));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashBoardButton(context,
                            title: products,
                            count: "${data.length}",
                            Icon: icProducts),
                        dashBoardButton(context,
                            title: orders, count: "88", Icon: icOrders)
                      ]),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashBoardButton(context,
                          title: rating, count: "88", Icon: icStar),
                      dashBoardButton(context,
                          title: totalSale, count: "88", Icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  const Divider(
                    thickness: 2,
                  ),
                  10.heightBox,
                  boldText(text: popular, color: darkGrey, size: 16.0),
                  20.heightBox,
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: (() {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  }),
                                  leading: Image.network(
                                    data[index]['p_imgs'][0],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: normalText(
                                      text: "\$${data[index]['p_price']}",
                                      color: darkGrey),
                                )),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
