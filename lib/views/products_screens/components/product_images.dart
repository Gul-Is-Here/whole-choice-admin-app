import 'package:whole_choice_admin_pannel/const/const.dart';

Widget productImages({required label, onpress}) {
  return "$label"
      .text
      .color(fontGrey)
      .bold
      .size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
