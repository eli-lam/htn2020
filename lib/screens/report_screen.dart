import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/config/palette.dart';
import 'package:mood_tracker/widgets/widgets.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

CollectionReference collectionReference =
    Firestore.instance.collection('emotions');

class _ReportScreenState extends State<ReportScreen> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(117, 119, 151, .1),
      100: Color.fromRGBO(117, 119, 151, .2),
      200: Color.fromRGBO(117, 119, 151, .3),
      300: Color.fromRGBO(117, 119, 151, .4),
      400: Color.fromRGBO(117, 119, 151, .5),
      500: Color.fromRGBO(117, 119, 151, .6),
      600: Color.fromRGBO(117, 119, 151, .7),
      700: Color.fromRGBO(117, 119, 151, .8),
      800: Color.fromRGBO(117, 119, 151, .9),
      900: Color.fromRGBO(117, 119, 151, 1),
    };
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Report'),
        backgroundColor: MaterialColor(0xFF757797, color),
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildWeeklyCards(screenHeight),
          _buildChart(screenHeight),
          _buildMostAndLeastMoods(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildWeeklyCards(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Mood',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            PastWeekCards(),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildChart(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How it changed throughout the week',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: false,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff68737d),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          margin: 8,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                            color: Color(0xff67727d),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 1:
                                return 'Bad';
                              case 3:
                                return 'Neutral';
                              case 5:
                                return 'Good';
                            }
                            return '';
                          },
                          reservedSize: 28,
                          margin: 13,
                        ),
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: const Color(0xff37434d), width: 1)),
                      minX: 1,
                      maxX: 7,
                      minY: 0,
                      maxY: 7,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, 5),
                            FlSpot(2, 2),
                            FlSpot(3, 2),
                            FlSpot(4, 4),
                            FlSpot(5, 3),
                            FlSpot(6, 6),
                            FlSpot(7, 1),
                          ],
                          isCurved: true,
                          colors: gradientColors,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMostAndLeastMoods(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: screenHeight * 0.25,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Most and Least Experienced Moods',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: <Widget>[
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard('MOST', 'bored'),
                      _buildStatCard('LEAST', 'relaxed'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildStatCard(String title, String emotion) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/' + emotion + '.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                emotion.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
