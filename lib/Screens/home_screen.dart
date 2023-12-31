import 'dart:async';
import 'package:covid_19_tracker_app/Constants/constants.dart';
import 'package:covid_19_tracker_app/Models/world_status_model.dart';
import 'package:covid_19_tracker_app/Screens/countries_list_screen.dart';
import 'package:covid_19_tracker_app/Services/status_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/re_usable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.linear,
  );

  ///A countdown timer that can be configured to fire once or repeatedly.s
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    StatusServices statusServices = StatusServices();
    return Scaffold(
      body: FutureBuilder(
        future: statusServices.fetchWorldStatusData(),
        builder:
            (BuildContext context, AsyncSnapshot<WorldStatusModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(
                child: Text(
              "Loading Data",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Center(
                    child: Text("Covid-19 World Status"),
                  ),
                ),

                PieChart(
                  ///data map of pie chart
                  dataMap: {
                    "Total Cases":
                        double.parse(snapshot.data!.cases!.toString()),
                    "Recovered":
                        double.parse(snapshot.data!.recovered!.toString()),
                    "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                  },

                  /// animationDuration for pie chart
                  chartRadius: size.height * 0.18,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  legendOptions: const LegendOptions(
                    showLegends: true,
                    legendPosition: LegendPosition.left,
                  ),
                  animationDuration: const Duration(milliseconds: 1200),
                  chartType: ChartType.ring,
                  colorList: AppColors.colorList,
                ),

                ///ReUsable Values
                Column(
                  children: [
                    ReUsableWidgets.reUsableRow(
                        "Cases", snapshot.data!.cases.toString()),
                    ReUsableWidgets.reUsableRow(
                        "Critical", snapshot.data!.critical.toString()),
                    ReUsableWidgets.reUsableRow(
                        "Deaths", snapshot.data!.deaths.toString()),
                    ReUsableWidgets.reUsableRow(
                        "Population", snapshot.data!.population.toString()),
                    ReUsableWidgets.reUsableRow(
                        "Today Cases", snapshot.data!.todayCases.toString()),
                    ReUsableWidgets.reUsableRow(
                        "Today Deaths", snapshot.data!.todayDeaths.toString()),
                    ReUsableWidgets.reUsableRow("Today Recovered",
                        snapshot.data!.todayRecovered.toString()),
                  ],
                ),

                MaterialButton(
                  height: size.height * 0.07,
                  minWidth: size.width,
                  color: AppColors.colorList[1],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Track Countries",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const CountriesListScreen();
                    }));
                  },
                ),
              ],
            );

            /*
Column(
              children: [
                PieChart(
                  ///data map of pie chart
                  dataMap: const {
                    "Total": 20,
                    "Recovered": 15,
                    "Deaths": 5,
                  },

                  /// animationDuration for pie chart
                  chartRadius: size.height * 0.18,
                  legendOptions: const LegendOptions(
                    showLegends: true,
                    legendPosition: LegendPosition.left,
                  ),
                  animationDuration: const Duration(milliseconds: 1200),
                  chartType: ChartType.ring,
                  colorList: AppColors.colorList,
                ),

                ///ReUsable Values
                Card(
                  child: Column(
                    children: [
                      ReUsableWidgets.reUsableRow("Total", "200"),
                      ReUsableWidgets.reUsableRow("Total", "200"),
                      ReUsableWidgets.reUsableRow("Total", "200"),
                      ReUsableWidgets.reUsableRow("Total", "200"),
                      ReUsableWidgets.reUsableRow("Total", "200"),
                    ],
                  ),
                ),

                MaterialButton(
                  height: size.height * 0.07,
                  minWidth: size.width,
                  color: AppColors.colorList[1],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Track Countries",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            );
            */
          }
        },
      ),
    );
  }
}
