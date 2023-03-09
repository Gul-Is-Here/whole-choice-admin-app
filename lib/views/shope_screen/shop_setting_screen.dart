import 'package:whole_choice_admin_pannel/controller/profile_controller.dart';
import 'package:whole_choice_admin_pannel/views/widgets/custom_textField.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import "../../const/const.dart";

class ShopeSettings extends StatelessWidget {
  const ShopeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: boldText(
                text: shopSettings,
                size: 16.0,
              ),
              actions: [
                controller.isLoading.value
                    ? loadingIndicator(circleColor: white)
                    : TextButton(
                        onPressed: () async {
                          controller.isLoading(true);
                          await controller.updateShop(
                              shopaddress:
                                  controller.shopAddressController.text,
                              shopname: controller.shopNameController.text,
                              shopmobile: controller.shopMobileController.text,
                              shopwebsite:
                                  controller.shopWebsiteController.text,
                              shopdesc: controller.shopDescController.text);
                          VxToast.show(context, msg: "Shope Updated");
                          print(controller.nameController.text);
                          controller.isLoading(false);
                        },
                        child: normalText(text: save))
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                customTextField(
                    label: shopeName,
                    hint: nameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                customTextField(
                    label: shopeAddress,
                    hint: shopeAddressHint,
                    controller: controller.shopAddressController),
                10.heightBox,
                customTextField(
                    label: mobile,
                    hint: shopeMobileHint,
                    controller: controller.shopMobileController),
                10.heightBox,
                customTextField(
                    label: website,
                    hint: shopeWebsiteHint,
                    controller: controller.shopWebsiteController),
                10.heightBox,
                customTextField(
                    isDesc: true,
                    label: description,
                    hint: shopDescHint,
                    controller: controller.shopDescController),
              ],
            ),
          )),
    );
  }
}
