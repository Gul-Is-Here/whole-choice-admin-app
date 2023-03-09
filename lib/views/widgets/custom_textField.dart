import 'package:whole_choice_admin_pannel/const/const.dart';

Widget customTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    cursorColor: white,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        label: normalText(
          text: label,
        ),
        filled: true,
        fillColor: Colors.white24,
        isDense: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
