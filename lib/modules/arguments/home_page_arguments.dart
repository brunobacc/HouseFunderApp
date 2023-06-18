import 'package:flutter/material.dart';

class HomePageArguments {
  // sort by variables
  final bool newest;
  final bool oldest;
  final bool lowHigh;
  final bool highLow;
  final bool likes;

  // filter by variables
  final RangeValues? neededPrice;
  final String? region;
  final String? partnership;

  // store the maxPrice for the rangeValue neededPrice
  final double maxPrice;

  // store the token
  final String? token;

  HomePageArguments(
    this.newest,
    this.oldest,
    this.lowHigh,
    this.highLow,
    this.likes,
    this.neededPrice,
    this.region,
    this.partnership,
    this.maxPrice,
    this.token,
  );
}
