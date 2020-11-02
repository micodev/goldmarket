import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/core/product.dart';

class ItemViewWidget extends StatelessWidget {
  const ItemViewWidget({Key key, this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: product.isLocal
                                          ? (product.cover as Image).image
                                          : CachedNetworkImageProvider(
                                              product.cover))),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 2, left: 10, right: 10),
                                  height: 27,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: primaryColor),
                                  child: Center(
                                      child: Text(
                                    product.price,
                                    maxLines: 1,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 18, color: backgroundColor),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 5),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, top: 5.0),
                                    child: Text(
                                      product.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
