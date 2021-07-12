import 'package:food_app/components/widgets.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';
import 'package:food_app/components/globals.dart';
import 'package:food_app/view-model/menus_view_model.dart';
import 'package:food_app/view/sub_menu_page.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

MenusViewModel _menusViewModel = MenusViewModel();

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      body: Column(
        children: [
          topArea(context),
          SizedBox(height: 20),
          Container(
            width: context.width * .95,
            height: 0.5,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: _menusViewModel.readJson(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    data = snapshot.data;
                    return gridView(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding topArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 15, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              avatar(context),
              cart(context),
            ],
          ),
          context.emptySizedHeightBoxLow,
          context.emptySizedHeightBoxLow,
          topTitle(),
        ],
      ),
    );
  }

  Row cart(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/shopping-cart.png',
          height: context.height * 0.05,
        ),
      ],
    );
  }

  Row avatar(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: context.height * 0.073,
              height: context.height * 0.073,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 3, color: Colors.white)],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.height * 0.0375)),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                context.height * 0.035,
              ),
              child: Image.asset(
                'assets/images/avatar.jpeg',
                height: context.height * 0.07,
              ),
            ),
          ],
        ),
        context.emptySizedWidthBoxLow3x,
        Text(
          'Enis Can YILMAZ',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ],
    );
  }

  Padding topTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: Text(
        'Gurme Dünyasına \nHoş Geldiniz!',
        style:
            TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 24),
      ),
    );
  }

  GridView gridView(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.83,
            crossAxisSpacing: 15,
            mainAxisSpacing: context.height * 0.045),
        itemCount: snapshot.data.menus[0].items.length,
        itemBuilder: (BuildContext ctx, index) {
          return gridViewBody(context, snapshot, index);
        });
  }

  Padding gridViewBody(
      BuildContext context, AsyncSnapshot<dynamic> snapshot, int index) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 0.035),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubMenuPage(
                title: snapshot.data.menus[0].items[index].name,
                menuData: snapshot.data.menus[0].items[index],
                mainIndex: index,
              ),
            ),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            cardFrame(),
            mainDashboardCardBody(snapshot, index, context),
            index == 0
                ? Positioned(
                    right: -5,
                    top: -53,
                    child: Image.asset(
                      'assets/images/discount.png',
                      color: ColorPallette.color3,
                      height: context.height * 0.063,
                    ),
                  )
                : SizedBox(),
            navigateButton(),
          ],
        ),
      ),
    );
  }

  Container cardFrame() {
    return Container(
      transform: Matrix4.skewY(-0.1),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorPallette.color2, borderRadius: BorderRadius.circular(15)),
    );
  }

  Positioned mainDashboardCardBody(
      AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
    return Positioned(
      top: -50,
      left: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainDashboardCardImage(snapshot, index, context),
          SizedBox(
            height: 15,
          ),
          mainDashboardCardTitle(snapshot, index),
        ],
      ),
    );
  }

  Text mainDashboardCardTitle(AsyncSnapshot<dynamic> snapshot, int index) {
    return Text(
      snapshot.data.menus[0].items[index].name,
      style: TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Container mainDashboardCardImage(
      AsyncSnapshot<dynamic> snapshot, int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(5, 5), color: Colors.black87),
      ], borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          snapshot.data.menus[0].items[index].image
              .toString()
              .replaceFirst('.', 'assets'),
          height: context.height * 0.14,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Positioned navigateButton() {
    return Positioned(
      bottom: 22,
      right: 5,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(35)),
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 24,
          color: Color(0xfff1f3f8),
        ),
      ),
    );
  }
}
