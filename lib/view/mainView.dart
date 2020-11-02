import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/service/local_storage.dart';
import 'package:goldmarket/model/service/locator.dart';
import 'package:goldmarket/provider/productProvider.dart';
import 'package:goldmarket/provider/userProvider.dart';
import 'package:goldmarket/view/components/itemViewWidget.dart';
import 'package:provider/provider.dart';

import 'components/sliderWidget.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Badge(
                  position: BadgePosition.topEnd(end: -6),
                  badgeColor: Colors.red[600],
                  badgeContent: Text(
                    '3',
                    style: TextStyle(color: backgroundColor),
                  ),
                  child: Icon(Icons.notifications, color: backgroundColor),
                ),
                onPressed: () {}),
            IconButton(
                icon:
                    RotatedBox(quarterTurns: 2, child: Icon(Icons.exit_to_app)),
                color: backgroundColor,
                onPressed: () {
                  var localStorage = locator<LocalStorageService>();
                  localStorage.saveToDisk<String>("role", null);
                  context
                      .read<UserProvider>()
                      .userChange(UserStatus.Initialize);
                })
          ],
          title: Text(
            "الصفحة الرئيسية",
            style:
                TextStyle(color: backgroundColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
        body: ListView(
          shrinkWrap: false,
          children: [
            Column(
              children: [
                SliderWidget(products: productProvider.products),
                itemsList("الموصى بها", productProvider),
                itemsList("قد تعجيك", productProvider)
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("الرئيسية")),
          BottomNavigationBarItem(
              icon: Icon(Icons.layers), title: Text("الأقسام")),
          BottomNavigationBarItem(
              icon: Badge(
                  position: BadgePosition.topStart(top: -10),
                  badgeColor: Colors.red[600],
                  badgeContent: Text(
                    '8',
                    style: TextStyle(color: backgroundColor),
                  ),
                  child: Icon(Icons.local_grocery_store)),
              title: Text("السلة"))
        ]),
      ),
    );
  }

  Widget itemsList(title, productProvider) {
    return Wrap(
      children: [
        /* recomanded text */
        Container(
          color: backgroundColor,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "المزيد",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          )
                        ],
                      ),
                    )
                  ])),
        ),
        /* Grid */
        Container(
          width: MediaQuery.of(context).size.width,
          height: 210,
          decoration: BoxDecoration(color: backgroundColor),
          padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 15),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productProvider.products.length,
              itemBuilder: (b, i) {
                return ItemViewWidget(
                  product: productProvider.products[i],
                );
              }),
        ),
      ],
    );
  }
}
