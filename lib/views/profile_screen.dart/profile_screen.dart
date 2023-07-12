import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/auth_controller.dart';
import 'package:whole_choice_admin_pannel/controller/profile_controller.dart';
import 'package:whole_choice_admin_pannel/services/store_services.dart';
import 'package:whole_choice_admin_pannel/views/auth_screen/login_screen.dart';
import 'package:whole_choice_admin_pannel/views/messages/messages_screen.dart';
import 'package:whole_choice_admin_pannel/views/profile_screen.dart/edit_profilescreen.dart';
import 'package:whole_choice_admin_pannel/views/shope_screen/shop_setting_screen.dart';
import 'package:whole_choice_admin_pannel/views/widgets/loading_indcator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(automaticallyImplyLeading: false, actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                    userName: controller.snapshotData['vendor_name']));
              },
              icon: const Icon(Icons.edit)),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: normalText(text: logout))
        ]),
        body: FutureBuilder(
          future: StoreService.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circleColor: white);
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(
                            imgProduct,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ).box.rounded.clip(Clip.antiAlias).make()
                        : Image.network(controller.snapshotData['imageUrl'],
                                width: 120, fit: BoxFit.contain)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    // leading: Image.asset(imgProduct)
                    //     .box
                    //     .roundedFull
                    //     .clip(Clip.antiAlias)
                    //     .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(
                    color: white,
                  ),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileButtonIcons.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopeSettings());
                                      break;
                                    case 1:
                                      Get.to(() => const MessagesScreen());
                                      break;

                                    default:
                                  }
                                },
                                leading: Icon(
                                  profileButtonIcons[index],
                                  color: white,
                                ),
                                title: normalText(
                                    text: profileBUttonTitles[index]),
                              )),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
