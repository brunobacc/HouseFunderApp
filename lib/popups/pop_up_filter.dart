import 'dart:ffi';

import 'package:flutter/material.dart';

class PopUpFilter {
  BuildContext context;
  PopUpFilter(this.context);

  static void filter(BuildContext context, double maxPrice) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height * 0.75;
    var popUp = AlertDialog(
      content: Filter(maxPrice: maxPrice, width: width, height: height),
      insetPadding: EdgeInsets
          .zero, // used to remove the space between the container and the edges of the screen
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

List<String> regions = [
  'Aveiro',
  'Beja',
  'Braga',
  'Bragança',
  'Castelo Branco',
  'Coimbra',
  'Évora',
  'Faro',
  'Guarda',
  'Leiria',
  'Lisboa',
  'Portalegre',
  'Porto',
  'Santarém',
  'Setúbal',
  'Viana do Castelo',
  'Vila Real',
  'Viseu',
];

class Filter extends StatefulWidget {
  final double maxPrice;
  final double width;
  final double height;
  const Filter(
      {required this.maxPrice,
      required this.width,
      required this.height,
      super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _newest = false,
      _oldest = false,
      _lowHigh = false,
      _highLow = false,
      _likes = false;
  late double _maxPrice;
  late RangeValues neededPrice = RangeValues(0, _maxPrice);
  String? region;

  @override
  void initState() {
    super.initState();
    _maxPrice = widget.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SORT BY',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          CheckboxListTile(
            shape: const Border(
              top: BorderSide(),
            ),
            value: _newest,
            onChanged: (_) => setState(() {
              _newest = !_newest;
            }),
            title: Text(
              'NEWEST',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            shape: const Border(
              top: BorderSide(),
            ),
            value: _oldest,
            onChanged: (_) => setState(() {
              _oldest = !_oldest;
            }),
            title: Text(
              'OLDEST',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            shape: const Border(
              top: BorderSide(),
            ),
            value: _lowHigh,
            onChanged: (_) => setState(() {
              _lowHigh = !_lowHigh;
            }),
            title: Text(
              'LOW € - HIGH €',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            shape: const Border(
              top: BorderSide(),
            ),
            value: _highLow,
            onChanged: (_) => setState(() {
              _highLow = !_highLow;
            }),
            title: Text(
              'HIGH € - LOW €',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CheckboxListTile(
            shape: const Border(
              top: BorderSide(),
              bottom: BorderSide(),
            ),
            selected: _likes,
            value: _likes,
            onChanged: (_) => setState(() {
              _likes = !_likes;
            }),
            title: Text(
              'LIKES',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'FILTER BY',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(border: Border(top: BorderSide())),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRICE NEEDED',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  RangeSlider(
                    values: neededPrice,
                    min: 0,
                    max: widget.maxPrice,
                    divisions: 100,
                    labels: RangeLabels(
                        '${neededPrice.start}€', '${neededPrice.end}€'),
                    onChanged: (value) => setState(() {
                      neededPrice = value;
                    }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  'REGION',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: region,
                items: regions
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  region = value;
                }),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  'PARTNERSHIP',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: region,
                items: regions
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  region = value;
                }),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: null,
              child: Text(
                'Show Results',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
