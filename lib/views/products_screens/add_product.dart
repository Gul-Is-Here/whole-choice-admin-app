import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/product_controller.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/components/product_dropdown.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/components/product_images.dart';
import 'package:whole_choice_admin_pannel/views/widgets/custom_textField.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import 'components/products_colors.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: "Add Poduct", size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.UploadImages();
                      // ignore: use_build_context_synchronously
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: "save", size: 16.0))
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                  hint: "eg. Beauty Box",
                  label: "Product name",
                  controller: controller.pnameController),
              10.heightBox,
              customTextField(
                  hint: "eg. This is very beatuiful Product",
                  label: "Description",
                  isDesc: true,
                  controller: controller.pdescController),
              10.heightBox,
              customTextField(
                  hint: "eg. \$100",
                  label: "Price",
                  controller: controller.ppriceController),
              10.heightBox,
              customTextField(
                  hint: "eg. 20",
                  label: "Quantity",
                  controller: controller.pquantityController),
              10.heightBox,
              productDropDown("Category", controller.categoryList,
                  controller.categoryvalue, controller),
              10.heightBox,
              productDropDown("Subcategory", controller.subcategoryList,
                  controller.subcategoryvalue, controller),

              10.heightBox,
              const Divider(
                color: white,
              ),

              boldText(text: "Choose Product images"),
              10.heightBox,

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            })),
                ),
              ),

              5.heightBox,
              normalText(text: "First Image Will be your display image"),

              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose Products Colors"),
              10.heightBox,
              const ColorSelector(),
              // Wrap(
              //   spacing: 8.0,
              //   runSpacing: 8.0,
              //   children: List.generate(
              //       colors.length,
              //       (index) => Stack(
              //             alignment: Alignment.center,
              //             children: [
              //               VxBox()
              //                   .color(Vx.randomPrimaryColor)
              //                   .roundedFull
              //                   .size(50, 50)
              //                   .make()
              //                   .onTap(() {
              //                 controller.selectedColorIndex.value = index;
              //               }),
              //               controller.selectedColorIndex.value == index
              //                   ? const Icon(
              //                       Icons.done,
              //                       color: white,
              //                     )
              //                   : const SizedBox()
              //             ],
              //           )),
              // ),

              10.heightBox,
              // MultipleChoiceBlockPicker(
              //         pickerColors: [Colors.black, Colors.white],
              //         onColorsChanged: (List<Color> colors) {})
              //     .box
              //     .white
              //     .makeCentered()
            ],
          ),
        ),
      ),
    );
  }
}
