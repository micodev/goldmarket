import 'dart:async';
import 'package:badges/badges.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/core/bezier_data.dart';
import 'package:goldmarket/model/core/product.dart';
import 'package:goldmarket/model/service/local_storage.dart';
import 'package:goldmarket/model/service/locator.dart';
import 'package:goldmarket/model/service/nav_services/navigationService.dart';
import 'package:goldmarket/provider/bezierProvider.dart';
import 'package:goldmarket/provider/productProvider.dart';
import 'package:goldmarket/provider/userProvider.dart';
import 'package:goldmarket/view/components/customTextField.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

import 'components/chartWidget.dart';

class DashBoardView extends StatefulWidget {
  DashBoardView({Key key}) : super(key: key);

  @override
  _DashBoardViewState createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final context = locator<NavigationService>().navigatorKey.currentContext;

  @override
  void initState() {
    context.read<BezierProvider>().fetchBezier();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: primaryColor,
            expandedHeight: 300.0,
            floating: true,
            snap: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      chart(context),
                      Positioned.fill(
                          left: 10,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundColor: backgroundColor,
                              child: IconButton(
                                  icon: RotatedBox(
                                      quarterTurns: 2,
                                      child: Icon(Icons.exit_to_app)),
                                  color: primaryColor,
                                  onPressed: () {
                                    var localStorage =
                                        locator<LocalStorageService>();
                                    localStorage.saveToDisk<String>(
                                        "role", null);
                                    context
                                        .read<UserProvider>()
                                        .userChange(UserStatus.Initialize);
                                  }),
                            ),
                          ))
                    ],
                  ),
                )),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Column(
                  children: [
                    dashBoardItemsBuilder(
                        context.watch<BezierProvider>().totalUsers.toString(),
                        "المسخدمين"),
                    _cutomDivider(),
                    dashBoardItemsBuilder(
                        context
                            .watch<ProductProvider>()
                            .products
                            .length
                            .toString(),
                        "المنتجات المتبقية"),
                    _cutomDivider(),
                    dashBoardItemsBuilder(
                        context
                            .watch<BezierProvider>()
                            .selledProducts
                            .toString(),
                        "المنتجات المباعة"),
                    _cutomDivider(),
                    PieChartSample1()
                  ],
                ),
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          showAddedDialog(context);
          context.read<ProductProvider>().addProduct(initiate: true);
        }),
        tooltip: "أضافة منتج جديد",
        child: Icon(Icons.add),
      ),
    );
  }

  TextEditingController productName = TextEditingController();
  TextEditingController productWeight = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  void showAddedDialog(c) async {
    productName.clear();
    productWeight.clear();
    productDescription.clear();

    await showAnimatedDialog(
      context: c,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomDialogWidget(
            minWidth: MediaQuery.of(context).size.width,
            backgroundColor: backgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "أضف منتج",
                style: TextStyle(color: backgroundColor),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            titlePadding: EdgeInsets.only(),
            contentPadding: EdgeInsets.only(bottom: 10, top: 10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        text: productName,
                        edgePadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "أسم المنتج",
                      ),
                    ),
                  ],
                ),
                _cutomDivider(height: 0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        text: productWeight,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        edgePadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "وزن المنتج",
                      ),
                    ),
                  ],
                ),
                _cutomDivider(height: 0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 5 * 24.0,
                        child: CustomTextField(
                          text: productDescription,
                          maxLines: 5,
                          edgePadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "...وصف المنتج",
                        ),
                      ),
                    ),
                  ],
                ),
                _cutomDivider(height: 0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Badge(
                          badgeColor: primaryColor,
                          position: BadgePosition.topEnd(end: 0),
                          badgeContent: Text(
                            "${context.watch<ProductProvider>().resultList.length}",
                            style: TextStyle(color: backgroundColor),
                          ),
                          child: OutlineButton(
                            highlightedBorderColor: primaryColor,
                            borderSide: BorderSide(color: primaryColor),
                            onPressed: () {
                              loadAssets();
                            },
                            shape: StadiumBorder(
                                side: BorderSide(color: primaryColor)),
                            color: backgroundColor,
                            child: Text(
                              "أضافة صور للمنتج",
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Ink(
                          width: 40,
                          height: 40,
                          decoration: const ShapeDecoration(
                            color: primaryColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            splashRadius: 25,
                            iconSize: 20,
                            icon: Icon(
                              Icons.save,
                              color: backgroundColor,
                            ),
                            onPressed: () async {
                              Image img = await assetThumbToImage(context
                                  .read<ProductProvider>()
                                  .resultList[0]);
                              context.read<ProductProvider>().addProduct(
                                    product: Product(
                                        name: productName.text,
                                        description: productDescription.text,
                                        cover: img,
                                        isLocal: true,
                                        price:
                                            "${int.parse(productWeight.text) * 1000}د.ع"),
                                  );
                              locator.get<NavigationService>().goBack();
                            },
                          ),
                        ),
                      ]),
                )
              ],
            ));
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
    );
  }

  Widget dashBoardItemsBuilder(String number, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            backgroundColor: primaryColor,
            child: Center(
              child: Text(
                number,
                style: TextStyle(fontSize: 18, color: backgroundColor),
              ),
            )),
        Text(label,
            style: TextStyle(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl)
      ],
    );
  }

  Widget _cutomDivider({double height = 0.4}) => Padding(
        padding: height == 0
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: height,
          color: primaryColor,
        ),
      );

  Widget chart(BuildContext context) {
    var bezierData = context
        .select<BezierProvider, List<BezierData>>((value) => value.bezierData);
    final fromDate = DateTime.now().subtract(Duration(days: bezierData.length));
    final toDate = DateTime.now().subtract(Duration(days: 1));
    int days = 1;
    final points = bezierData.map((e) {
      return DataPoint<DateTime>(
          value: e.value,
          xAxis: DateTime.now().subtract(Duration(days: days++)));
    }).toList();
    return Center(
      child: Container(
          color: primaryColor,
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: (bezierData.length != 0
              ? BezierChart(
                  fromDate: fromDate,
                  bezierChartScale: BezierChartScale.WEEKLY,
                  toDate: toDate,
                  selectedDate: toDate,
                  series: [
                    BezierLine(
                      label: "الزوار",
                      onMissingValue: (dateTime) {
                        return 1;
                      },
                      data: points,
                    ),
                  ],
                  config: BezierChartConfig(
                    verticalIndicatorColor: Colors.black12,
                    showVerticalIndicator: true,
                    verticalIndicatorFixedPosition: false,
                    footerHeight: 40.0,
                    backgroundColor: primaryColor,
                  ),
                )
              : Center(
                  child: Container(
                      color: primaryColor,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(backgroundColor),
                        backgroundColor: primaryColor,
                      )),
                ))),
    );
  }

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      List<Asset> images = context.read<ProductProvider>().resultList;
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        // enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          statusBarColor: "#dab854",
          actionBarColor: "#dab854",
          actionBarTitle: "أختر صور للمنتج",
          allViewTitle: "كل الصور",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      context.read<ProductProvider>().clearImage();
      resultList.forEach((element) {
        context.read<ProductProvider>().addImage(element);
      });
    } on Exception catch (e) {
      context.read<ProductProvider>().clearImage();
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
