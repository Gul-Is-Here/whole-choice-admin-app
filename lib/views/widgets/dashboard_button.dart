import '../../const/const.dart';
import 'style_text.dart';

Widget dashBoardButton(context, {title, count, Icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        boldText(text: title, size: 16.0),
        10.heightBox,
        boldText(text: count, size: 20.0)
      ])),
      Image.asset(Icon, width: 40, color: white)
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * .9, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
