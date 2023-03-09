import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
      backgroundColor: white,
      title: boldText(text: title, color: fontGrey, size: 16.0),
      actions: [
        Center(
            child: normalText(
                text: intl.DateFormat('EEE,MM d,' 'yy').format(DateTime.now()),
                color: purpleColor)),
        10.widthBox,
      ]);
}
