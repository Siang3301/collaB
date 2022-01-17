import 'package:flutter/material.dart';
import 'package:collab/personal_spaces/statistics/data.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:collab/personal_spaces/statistics/display_widgets.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
        centerTitle: true,
        title : const Text("Project Statistics", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/images/personalspaces-ui.webp'),
              fit: BoxFit.cover)),
        child: Container(
        padding: EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
        Colors.black.withOpacity(0.8),
        Colors.black.withOpacity(0.7)
        ])),
        child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          _buildHeader(),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: taskBarChart(covidCases: covidUSADailyNewCases),
            ),
          ),
        ],
      ),))
    );
  }
}

SliverPadding _buildHeader() {
  return SliverPadding(
    padding: const EdgeInsets.only(left:20, right: 20, bottom: 10, top: 20),
    sliver: SliverToBoxAdapter(
      child: Text(
        'Project Graph',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          decoration: TextDecoration.underline,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
