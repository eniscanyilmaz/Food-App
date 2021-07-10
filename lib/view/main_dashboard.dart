import 'package:flutter/material.dart';
import 'package:food_app/view-model/menus_view_model.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({ Key? key }) : super(key: key);

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

MenusViewModel _menusViewModel = MenusViewModel();


class _MainDashboardState extends State<MainDashboard> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: _menusViewModel.readJson(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: snapshot.data.menus[0].items.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(snapshot.data.menus[0].items[index].name),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                );
              });
              },
            ),
          ),
        ],
      ),
    );
  }
}