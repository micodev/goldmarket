import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/core/product.dart';

import 'dotWidget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  List<DotWidget> _listDots;
  List<bool> dots;

  @override
  void initState() {
    _listDots = List<DotWidget>();
    dots = List();
    widget.products.forEach((element) {
      dots.add(false);
    });
    if (dots.length > 0) dots[0] = true;
    _listDots = dots.map((e) {
      return DotWidget(active: e);
    }).toList();
    super.initState();
  }

  _lisdotBuilder() {
    if (dots.length == 0)
      widget.products.forEach((element) {
        dots.add(false);
      });
    _listDots = dots.map((e) {
      return DotWidget(
        active: e,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.2,
              viewportFraction: 1,
              onPageChanged: (i, r) {
                setState(() {
                  if (widget.products.length != dots.length) {
                    _lisdotBuilder();
                  }
                  dots[(i - 1) % widget.products.length] = false;
                  dots[i] = true;
                  _lisdotBuilder();
                });
              }),
          items: widget.products.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: i.isLocal
                                ? (i.cover as Image).image
                                : CachedNetworkImageProvider(i.cover)),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                stops: [
                              0.4,
                              0.9
                            ],
                                colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter))),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 2.0),
                        child: Text(
                          i.name,
                          style: TextStyle(fontSize: 18.0, color: primaryColor),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          child: Column(
            children: _listDots,
          ),
          bottom: 10,
          left: 10,
        )
      ],
    );
  }
}
