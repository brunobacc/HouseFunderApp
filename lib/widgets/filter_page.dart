import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/users.dart';
import 'package:projeto_computacao_movel/modules/arguments/home_page_arguments.dart';
import '../modules/partnership.dart';

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

class FilterPage extends StatefulWidget {
  final double maxPrice;
  final String? token;
  const FilterPage({required this.maxPrice, required this.token, super.key});

  static const String routeName = '/filter';

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool _newest = false,
      _oldest = false,
      _lowHigh = false,
      _highLow = false,
      _likes = false;
  late double _maxPrice;
  late RangeValues neededPrice = RangeValues(0, _maxPrice);
  String? selectedRegion;
  late Future<List<Partnership>> _partnerships;
  String? selectedPartnership;

  @override
  void initState() {
    super.initState();
    _maxPrice = widget.maxPrice;
    _partnerships = Users.fetchPartnerships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sort / Filter',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.brown,
                    ),
              ),
              const SizedBox(
                height: 10,
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
                'Filter By',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.brown,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration:
                    const BoxDecoration(border: Border(top: BorderSide())),
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
                    value: selectedRegion,
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
                      selectedRegion = value;
                    }),
                  ),
                ),
              ),
              FutureBuilder<List<Partnership>>(
                future: _partnerships,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
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
                          value: selectedPartnership,
                          items: snapshot.data!
                              .map((p) => DropdownMenuItem(
                                    value: p.name,
                                    child: Text(
                                      p.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedPartnership = value;
                          }),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/',
                    arguments: HomePageArguments(
                      _newest,
                      _oldest,
                      _lowHigh,
                      _highLow,
                      _likes,
                      neededPrice,
                      selectedRegion,
                      selectedPartnership,
                      _maxPrice,
                      null,
                    ),
                  ),
                  child: Text(
                    'Show Results',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
