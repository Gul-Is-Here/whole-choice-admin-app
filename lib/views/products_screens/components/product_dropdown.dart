import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/controller/product_controller.dart';

Widget productDropDown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
          hint: normalText(text: "$hint", color: fontGrey),
          value: dropvalue.value == '' ? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem(
              value: e,
              child: e.toString().text.make(),
            );
          }).toList(),
          onChanged: (newValue) {
            if (hint == "Category") {
              controller.subcategoryvalue.value = '';
              controller.populateSubCategoryList(newValue.toString());
            }
            dropvalue.value = newValue.toString();
          }),
    )
        .box
        .roundedSM
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
