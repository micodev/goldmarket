import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({Key key, this.active}) : super(key: key);
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: active ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
