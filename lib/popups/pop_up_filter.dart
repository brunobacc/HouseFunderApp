import 'package:flutter/material.dart';

class PopUpFilter {
  BuildContext context;
  PopUpFilter(this.context);

  static void filter(BuildContext context, double maxPrice) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height * 0.7;
    var popUp = AlertDialog(
      content: Filter(maxPrice: maxPrice, width: width, height: height),
      insetPadding: EdgeInsets
          .zero, // used to remove the space between the container and the edges of the screen
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      elevation: 3,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }
}

class Filter extends StatefulWidget {
  final double maxPrice;
  final width;
  final height;
  const Filter(
      {required this.maxPrice,
      required this.width,
      required this.height,
      super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool newest = false;
  bool oldest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Text(
            'SORT BY',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          CheckboxListTile(
            value: newest,
            onChanged: (_) => setState(() {
              newest = !newest;
            }),
            title: Text(
              'NEWEST',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            selected: newest,
            value: oldest,
            onChanged: (_) => setState(() {
              oldest = !oldest;
            }),
            title: Text(
              'OLDEST',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            selected: newest,
            value: oldest,
            onChanged: (_) => setState(() {
              oldest = !oldest;
            }),
            title: Text(
              'LOW € - HIGH €',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            selected: newest,
            value: oldest,
            onChanged: (_) => setState(() {
              oldest = !oldest;
            }),
            title: Text(
              'HIGH € - LOW €',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            selected: newest,
            value: oldest,
            onChanged: (_) => setState(() {
              oldest = !oldest;
            }),
            title: Text(
              'LIKES',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            'FILTER BY',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
