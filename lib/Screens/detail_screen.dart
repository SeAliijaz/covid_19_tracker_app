import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final String? totalCases;
  final String? totalDeaths;
  final String? totalRecovered;
  final String? active;
  final String? critical;
  final String? todayRecovered;
  final String? test;

  const DetailScreen({
    super.key,
    this.image,
    this.name,
    this.totalCases,
    this.totalDeaths,
    this.totalRecovered,
    this.active,
    this.critical,
    this.todayRecovered,
    this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.network(widget.image.toString()),
      ),
    );
  }
}
