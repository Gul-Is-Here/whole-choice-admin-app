import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/product_controller.dart';
import 'package:whole_choice_admin_pannel/services/store_services.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/add_product.dart';
import 'package:whole_choice_admin_pannel/views/widgets/appBar_widget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import 'product_detail.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();

            Get.to(() => const AddProduct());
          },
          child: const Icon(Icons.add),
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
          stream: StoreService.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) => ListTile(
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
                              subtitle: Row(children: [
                                normalText(
                                    text: "\$${data[index]['p_price']}",
                                    color: darkGrey),
                                10.widthBox,
                                normalText(
                                    text: data[index]['is_featured'] == true
                                        ? "Featured"
                                        : "",
                                    color: green),
                              ]),
                              trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                menuBuilder: () => Column(
                                  children: List.generate(
                                    popupMenuTitles.length,
                                    (i) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            popMenuIconsList[i],
                                            color: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? green
                                                : darkGrey,
                                          ),
                                          10.widthBox,
                                          boldText(
                                            text: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? 'Remove Featured'
                                                : popupMenuTitles[i],
                                            color: purpleColor,
                                          )
                                        ],
                                      ).onTap(() {
                                        switch (i) {
                                          case 0:
                                            if (data[index]['is_featured'] ==
                                                true) {
                                              controller.removeFeatured(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Removed");
                                            } else {
                                              controller
                                                  .addFeatured(data[index].id);
                                              VxToast.show(context,
                                                  msg: "Added");
                                            }

                                            break;
                                          case 1:
                                            break;
                                          case 2:
                                            controller
                                                .removeProduct(data[index].id);
                                            VxToast.show(context,
                                                msg: "Produuct Remove");
                                            break;
                                          default:
                                        }
                                      }),
                                    ),
                                  ),
                                ).box.white.rounded.width(200).make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded),
                              ),
                            )),
                  ),
                ),
              );
            }
          },
        ));
  }
}
