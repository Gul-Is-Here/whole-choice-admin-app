import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/product_controller.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/components/product_dropdown.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/components/product_images.dart';
import 'package:whole_choice_admin_pannel/views/widgets/custom_textField.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import 'components/products_colors.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    bool isFormValid() {
      if (controller.pnameController.text.isEmpty ||
          controller.pdescController.text.isEmpty ||
          controller.pdescController.text.length < 10 ||
          controller.ppriceController.text.isEmpty ||
          controller.pquantityController.text.isEmpty) {
        return false;
      }

      // Add additional validation checks as needed

      return true;
    }

    void onSavePressed() async {
      if (isFormValid()) {
        controller.isloading(true);
        await controller.UploadImages();
        // ignore: use_build_context_synchronously
        await controller.uploadProduct(context);
        Get.back();
      } else {
        Get.snackbar(
          'Form Error',
          'Please fill in all required fields',
          snackPosition: SnackPosition.BOTTOM,
          messageText: const Text(
            'Please fill all form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      }
    }

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
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: onSavePressed,
                    child: boldText(text: "Save", size: 16.0),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                valid: (value) {
                  if (value.isEmpty) {
                    return "Please enter a product price";
                  }
                  // Add additional validation for price format
                  return null;
                },
                hint: "eg. Beauty Box",
                label: "Product name",
                controller: controller.pnameController,
              ),
              10.heightBox,
              customTextField(
                valid: (value) {
                  if (value.isEmpty) {
                    return "Please enter a product price";
                  }
                  // Add additional validation for price format
                  return null;
                },
                hint: "eg. This is a very beautiful Product",
                label: "Description",
                isDesc: true,
                controller: controller.pdescController,
              ),
              10.heightBox,
              customTextField(
                valid: (value) {
                  if (value.isEmpty) {
                    return "Please enter a product price";
                  }
                  // Add additional validation for price format
                  return null;
                },
                hint: "eg. \$100",
                label: "Price",
                controller: controller.ppriceController,
              ),
              10.heightBox,
              customTextField(
                hint: "eg. 20",
                label: "Quantity",
                controller: controller.pquantityController,
              ),
              10.heightBox,
              productDropDown(
                "Category",
                controller.categoryList,
                controller.categoryvalue,
                controller,
              ),
              10.heightBox,
              productDropDown(
                "Subcategory",
                controller.subcategoryList,
                controller.subcategoryvalue,
                controller,
              ),
              10.heightBox,
              const Divider(color: white),
              boldText(text: "Choose Product Images"),
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
                          }),
                  ),
                ),
              ),
              5.heightBox,
              normalText(text: "First Image Will be your display image"),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose Product Colors"),
              10.heightBox,
              ColorSelector(),
            ],
          ),
        ),
      ),
    );
  }
}
