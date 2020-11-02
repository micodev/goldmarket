import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:goldmarket/provider/bezierProvider.dart';
import 'package:goldmarket/provider/productProvider.dart';
import 'package:provider/provider.dart';
import 'pieChart_indecator.dart';

class PieChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: const Color(0xff0293ee),
                text: 'متبقي',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
              ),
              Indicator(
                color: const Color(0xff044d7c),
                text: 'خسارة',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
              ),
              Indicator(
                color: const Color(0xfff8b250),
                text: 'ربــح',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 12,
                    centerSpaceRadius: 0,
                    sections: showingSections()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      3,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: const Color(0xff0293ee).withOpacity(opacity),
              value: context.watch<ProductProvider>().products.length * 1.0,
              title: '',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff044d7c)),
              titlePositionPercentageOffset: 0.3,
            );
          case 2:
            return PieChartSectionData(
              color: const Color(0xfff8b250).withOpacity(opacity),
              value: context.watch<BezierProvider>().profit * 1.0,
              title: '',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff90672d)),
              titlePositionPercentageOffset: 0.3,
            );
          case 1:
            return PieChartSectionData(
              color: const Color(0xff044d7c).withOpacity(opacity),
              value: context.watch<BezierProvider>().loss * 1.0,
              title: '',
              radius: 80,
              titleStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff4c3788)),
              titlePositionPercentageOffset: 0.3,
            );

          default:
            return null;
        }
      },
    );
  }
}
