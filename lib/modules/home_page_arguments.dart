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

  HomePageArguments(this.newest, this.oldest, this.lowHigh, this.highLow,
      this.likes, this.neededPrice, this.region, this.partnership);
}
