import 'dart:io';

import 'package:whole_choice_admin_pannel/controller/profile_controller.dart';
import 'package:whole_choice_admin_pannel/views/widgets/custom_textField.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

import '../../const/const.dart';

class EditProfileScreen extends StatefulWidget {
  final String? userName;
  const EditProfileScreen({super.key, this.userName});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.userName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
            title: boldText(
              text: editProfile,
              size: 16.0,
            ),
            actions: [
              controller.isLoading.value
                  ? loadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isLoading(true);

                        //if image is not selected

                        controller.isLoading(true);

                        //if image is not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink =
                              controller.snapshotData['imageUrl'];
                        }
                        // if old password matche database

                        if (controller.snapshotData['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                              email: controller.snapshotData['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text);
                          await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text);

                          VxToast.show(context, msg: "Updated");
                        } else if (controller
                                .oldpassController.text.isEmptyOrNull &&
                            controller.newpassController.text.isEmptyOrNull) {
                          await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.snapshotData['password']);
                          VxToast.show(context, msg: "Some error occured...");
                        } else {
                          VxToast.show(context, msg: "Some error occured");
                          controller.isLoading(false);
                        }
                      },
                      child: normalText(text: save))
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                controller.snapshotData['imageUrl'] == '' &&
                        controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProduct,
                        width: 200,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(controller.snapshotData['imageUrl'],
                                width: 200, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.file(File(controller.profileImgPath.value),
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: white, foregroundColor: darkGrey),
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    child: const Text("Change image")),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                customTextField(
                    label: name,
                    hint: "e.g Gul Faraz Ahmed",
                    controller: controller.nameController),
                30.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: "Change Your Password", size: 16.0)),
                10.heightBox,
                customTextField(
                    label: password,
                    hint: passwordHint,
                    controller: controller.oldpassController),
                10.heightBox,
                customTextField(
                    label: " New Password",
                    hint: passwordHint,
                    controller: controller.newpassController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
