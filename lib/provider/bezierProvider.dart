import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:goldmarket/model/core/bezier_data.dart';
import 'package:goldmarket/model/helper/bezierHelper.dart';

class BezierProvider extends ChangeNotifier {
  List<BezierData> bezierData;
  int totalUsers = 20;
  int selledProducts = 56;
  int profit = 28;
  int loss = 20;
  BezierHelper _bezierHelper = BezierHelper();
  BezierProvider() {
    this.bezierData = List();
  }
  Future fetchBezier() async {
    await Future.delayed(Duration(seconds: 3));
    bezierData = await _bezierHelper.fetchBezier();

    notifyListeners();
  }

  void addBezier() {
    bezierData.add(BezierData(day: 5, value: 20));
    notifyListeners();
  }
}
