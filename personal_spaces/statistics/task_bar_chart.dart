import 'package:flutter/material.dart';
import 'package:collab/personal_spaces/statistics/styles.dart';
import 'package:fl_chart/fl_chart.dart';

class taskBarChart extends StatelessWidget {
  final List<double> covidCases;

  const taskBarChart({required this.covidCases});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:15, right:15),
      height: 350.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Task Archived Per Day',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 16.0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    margin: 10.0,
                    showTitles: true,
                    getTextStyles: (context, value){
                      return Styles.chartLabelsTextStyle;
                    },
                    rotateAngle: 35.0,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Jan 9';
                        case 1:
                          return 'Jan 10';
                        case 2:
                          return 'Jan 12';
                        case 3:
                          return 'Jan 13';
                        case 4:
                          return 'Jan 14';
                        case 5:
                          return 'Jan 15';
                        case 6:
                          return 'Jan 16';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      getTextStyles: (context, value){
                        return Styles.chartLabelsTextStyle;
                      },
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 3 == 0) {
                          return '${value ~/ 3 * 1}';
                        }
                        return '';
                      }),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 3 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black,
                    strokeWidth: 1.0,
                    dashArray: [5],
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: covidCases
                    .asMap()
                    .map((key, value) => MapEntry(
                        key,
                        BarChartGroupData(
                          x: key,
                          barRods: [
                            BarChartRodData(
                              y: value,
                              colors: [Colors.red],
                            ),
                          ],
                        )))
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
