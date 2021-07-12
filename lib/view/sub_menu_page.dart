import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/components/globals.dart';
import 'package:food_app/components/widgets.dart';
import 'package:kartal/kartal.dart';

class SubMenuPage extends StatelessWidget {
  final String title;
  final menuData;
  final mainIndex;
  const SubMenuPage(
      {Key? key,
      required this.title,
      required this.menuData,
      required this.mainIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.color1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTitleArea(context),
              context.emptySizedHeightBoxLow3x,
              Container(
                width: context.width * .95,
                height: 0.5,
                color: Colors.grey,
              ),
              context.emptySizedHeightBoxLow3x,
              gridView(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding topTitleArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 5,
        left: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.white,
                  ),),
              SizedBox(
                width: 5,
              ),
              topTitle(),
            ],
          ),
          Image.asset(
            'assets/images/shopping-cart.png',
            height: context.height * 0.052,
          ),
        ],
      ),
    );
  }

  Column topTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainIndex != 0
            ? Text(title, style: TextThemeData.titleTextStyleW)
            : Text(title + 'de', style: TextThemeData.titleTextStyleW),
        Text(
          'Kaçırılmayacak Fırsatlar!',
          style: TextThemeData.titleTextStyleW,
        ),
      ],
    );
  }

  Expanded gridView(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: context.height * 0.045),
          itemCount: menuData.items.length,
          itemBuilder: (BuildContext ctx, index) {
            return gridViewBody(context, index);
          }),
    );
  }

  Padding gridViewBody(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 0.066),
      child: InkWell(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            subMenuPageCard(),
            subMenuPageCardBody(index, context),
            mainIndex != 0
                ? SizedBox()
                : Positioned(
                    right: index % 2 != 0 ? 5 : 0,
                    top: -53,
                    child: Image.asset(
                      'assets/images/discount.png',
                      color: Colors.red[700],
                      height: context.height * 0.045,
                    ),
                  ),
            navigateButton(context, index),
          ],
        ),
      ),
    );
  }

  Positioned navigateButton(BuildContext context, int index) {
    return Positioned(
        bottom: 22,
        right: 5,
        child: InkWell(
          onTap: () {
            mainIndex == 0
                ? taskOperationBottomSheet(context, context.size, index)
                : null;
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.black87, borderRadius: BorderRadius.circular(35)),
            child: menuData.items[index].subMenus != null
                ? Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 20,
                    color: Color(0xfff1f3f8),
                  )
                : Icon(
                    FontAwesomeIcons.plus,
                    size: 20,
                    color: Color(0xfff1f3f8),
                  ),
          ),
        ));
  }

  Positioned subMenuPageCardBody(int index, BuildContext context) {
    return Positioned(
      top: -50,
      left: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5, offset: Offset(5, 5), color: Colors.black87),
            ], borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                menuData.items[index].image
                    .toString()
                    .replaceFirst('.', 'assets'),
                height: context.height * 0.14,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: context.width * 0.43),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuData.items[index].name.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(height: 5),
                starsWidget(context, index),
                SizedBox(
                  height: 5,
                ),
                menuData.items[index].subMenus != null
                    ? Text(
                        '+' +
                            menuData.items[index].subMenus.length.toString() +
                            ' seçenek',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    : SizedBox(),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      menuData.items[index].price.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Text(
                      ' ₺',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container subMenuPageCard() {
    return Container(
      transform: Matrix4.skewY(-0.1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorPallette.color2, borderRadius: BorderRadius.circular(15)),
    );
  }

  void taskOperationBottomSheet(context, size, index) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25))),
        isScrollControlled: true,
        backgroundColor: ColorPallette.color1,
        context: context,
        builder: (builder) {
          return bottomSheetBody(size, index);
        });
  }

  Container bottomSheetBody(size, index) {
    return Container(
      width: size.width,
      height: size.height * 0.83,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ColorPallette.color1, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                    color: ColorPallette.color2,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.menus![index + 1].orderTag.toString(),
                      style: TextThemeData.titleTextStyleW,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: size.width * 0.75,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    listViewArea(size, index),
                    SizedBox(height: 20),
                    Text(
                      data!.menus![7].orderTag.toString() + '-1',
                      style: TextThemeData.titleTextStyleW,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: size.width * 0.75,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    listViewArea(size, 6),
                    SizedBox(height: 20),
                    Text(
                      data!.menus![8].orderTag.toString() + '-2',
                      style: TextThemeData.titleTextStyleW,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: size.width * 0.75,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    listViewArea(size, 7),
                    SizedBox(height: 20),
                    Text(
                      data!.menus![9].key.toString(),
                      style: TextThemeData.titleTextStyleW,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: size.width * 0.75,
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    listViewArea(size, 8),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container listViewArea(size, index) {
    return Container(
      height: size.height * 0.23,
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: data?.menus?[index + 1].items?.length,
          itemBuilder: (BuildContext context, int listIndex) {
            return listViewBody(size, index, listIndex, context);
          },
        ),
      ),
    );
  }

  Padding listViewBody(size, index, int listIndex, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 34.0,
        right: 17,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          subMenusFrame(size),
          subMenusBody(index, listIndex, size, context),
        ],
      ),
    );
  }

  Container subMenusFrame(size) {
    return Container(
      transform: Matrix4.skewY(-0.05),
      width: size.width * 0.4,
      decoration: BoxDecoration(
          color: ColorPallette.color2, borderRadius: BorderRadius.circular(10)),
    );
  }

  Positioned subMenusBody(index, int listIndex, size, BuildContext context) {
    return Positioned(
      top: -40,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              data!.menus![index + 1].items![listIndex].image
                  .toString()
                  .replaceFirst('.', 'assets'),
              height: size.height * 0.12,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: size.width * 0.4),
            child: Text(
              data!.menus![index + 1].items![listIndex].name.toString(),
              style: TextThemeData.subTitleTextStyleD,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          starsWidget(context, index),
          SizedBox(
            height: 5,
          ),
          data!.menus![index + 1].items![listIndex].price.toString() != 'null'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '+' +
                          data!.menus![index + 1].items![listIndex].price
                              .toString(),
                      textAlign: TextAlign.center,
                      style: TextThemeData.subTitleTextStyleD,
                    ),
                    Text(
                      ' ₺',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }

  Container starsWidget(BuildContext context, index) {
    return Container(
      width: context.width * 0.25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            FontAwesomeIcons.solidStar,
            size: 17,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            size: 17,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            size: 17,
          ),
          Icon(
            FontAwesomeIcons.solidStar,
            size: 17,
          ),
          Text('($index)')
        ],
      ),
    );
  }
}
