// ignore_for_file: deprecated_member_use

import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/views/widgets/style_text.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          primary: color,
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0));
}
