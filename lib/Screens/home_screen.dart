import 'dart:async';
import 'package:covid_19_tracker_app/Constants/constants.dart';
import 'package:covid_19_tracker_app/Models/world_status_model.dart';
import 'package:covid_19_tracker_app/Services/status_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FutureBuilder<WorldStatusModel>(
                  future: statusServices.fetchWorldStatusData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<WorldStatusModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return Column(
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
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: AppColors.colorList,
                          ),

                          ///Card
                          Card(
                            child: Column(
                              children: [
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
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
