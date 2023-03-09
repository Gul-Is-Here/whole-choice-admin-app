import 'package:whole_choice_admin_pannel/controller/home_contoller.dart';
import 'package:whole_choice_admin_pannel/views/home_screen/home_screen.dart';
import 'package:whole_choice_admin_pannel/views/orders_screen/order_screen.dart';
import 'package:whole_choice_admin_pannel/views/products_screens/products_screen.dart';
import 'package:whole_choice_admin_pannel/views/profile_screen.dart/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen()
    ];
    var bottonNavbar = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, width: 24, color: darkGrey),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, width: 24, color: darkGrey),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, width: 24, color: darkGrey),
          label: settings)
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottonNavbar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
