import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/popups/pop_up_payment.dart';

class ProjectDetails extends StatelessWidget {
  final Project? project;
  ProjectDetails({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          project!.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(
                      'assets/images/${project!.image}',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                heightFactor: 8.2,
                alignment: const Alignment(0, 1),
                child: ElevatedButton(
                  onPressed: () async {
                    double? val = await showDialog(
                      context: context,
                      builder: (context) => const PopUpPayment(),
                    );
                  },
                  child: const Text(
                    "Financiar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue,
                  value: (project!.financedValue / project!.finalValue),
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  minHeight: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        '${project!.financedValue.toString()}€',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                        '${(project!.finalValue - project!.financedValue).toString()}€',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Text(
                  project!.location,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                child: Text(
                  '${project!.finalValue.toString()}€',
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
            child: Text(
              project!.description,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
            child: Text(
              'Financers',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
