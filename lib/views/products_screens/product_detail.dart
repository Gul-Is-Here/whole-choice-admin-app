import 'package:whole_choice_admin_pannel/const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;

  const ProductDetails({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkGrey),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "${data['p_name']}", color: darkGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemCount: data['p_imgs'].length,
                itemBuilder: (context, index) {
                  return Image.network(data['p_imgs'][index],
                      width: double.infinity, fit: BoxFit.fitHeight);
                }),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      10.heightBox,
                      boldText(
                          text: "${data['p_category']}",
                          color: darkGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}", color: darkGrey),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(
                      text: "\$${data['p_price']}", color: red, size: 18.0),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child: boldText(text: "color", color: fontGrey)),
                          Row(
                            children: List.generate(
                              data['p_color'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_color'][index]))
                                  // .color(Color(
                                  //       data['p_color'][index])
                                  //     .withOpacity(1.0))
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .make()
                                  .onTap(
                                    () {},
                                  ),
                            ),
                          )
                        ],
                      ),
                      10.heightBox,

                      //----->  Quantity Row <-------
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child:
                                  boldText(text: "Quantity", color: fontGrey)),
                          normalText(
                              text: "${data['p_quantity']}", color: fontGrey),
                          5.widthBox,
                          normalText(text: "items", color: fontGrey)
                        ],
                      )
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  normalText(text: "${data['p_desc']}", color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
