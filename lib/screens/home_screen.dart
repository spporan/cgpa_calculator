import 'package:cgpa_calculator/screens/cgpa_calculation.dart';
import 'package:cgpa_calculator/screens/sgpa_calculation.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class TabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabState();
  }
}

class _TabState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "University CGPA",
            style: TextStyle(fontSize: 25.0,fontWeight:FontWeight.bold),
          ),
          elevation: 15.0,
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: new BubbleTabIndicator(
                indicatorHeight: 25.0,
                indicatorColor: Colors.teal[500],
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              labelStyle: TextStyle(fontSize: 20.0),
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'Semester SGPA',
                ),
                Tab(
                  text: 'Total  CGPA',
                )
              ]),
        ),
        body: TabBarView(children: [
          SgpaCalculation(),
          CGPACalculation(),

        ]),
      ),
    );
  }
}
