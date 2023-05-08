import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/modules/project.dart';

class ProjectDetails extends StatelessWidget {
  final Project? project;
  const ProjectDetails({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              project!.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 5, 50, 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
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
