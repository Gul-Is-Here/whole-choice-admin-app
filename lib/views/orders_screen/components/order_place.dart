import 'package:whole_choice_admin_pannel/const/const.dart';

Widget orderPlaceDetail({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1", color: purpleColor),
            boldText(text: "$d1", color: red),
            // "$title1".text.fontFamily(semibold).make(),
            // "$d1".text.color(yellowColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "$title2".text.fontFamily(semibold).make(),
              // "$d2".text.fontFamily(semibold).make()
              boldText(text: "$title2", color: purpleColor),
              boldText(text: "$d2", color: purpleColor)
            ],
          ),
        )
      ],
    ),
  );
}
