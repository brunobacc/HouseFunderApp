import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_computacao_movel/modules/queries/financer_query.dart';
import 'package:projeto_computacao_movel/data/queries/financers_query.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/popups/pop_up_payment.dart';

import '../modules/user.dart';

class ProjectDetails extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;
  const ProjectDetails(
      {required this.project,
      required this.token,
      required this.user,
      super.key});

  static const String routeName = '/projectDetails';

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late Future<List<FinancerQuery>> _financers;

  @override
  void initState() {
    super.initState();
    _financers = FinancersQuery.fetchNext(widget.project.projectId);
  }

  @override
  Widget build(BuildContext context) {
    print('User1: ${widget.user?.email}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          widget.project.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(
                    'assets/images/${widget.project.image}',
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33,
                      child: Stack(
                        children: [
                          SizedBox.expand(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black45,
                              value: (widget.project.totalFinanced /
                                  widget.project.finalValue),
                              valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF867563)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '${widget.project.totalFinanced.toStringAsFixed(2)}€',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '${(widget.project.finalValue - widget.project.totalFinanced).toStringAsFixed(2)}€',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => PopUpPayment.payment(
                          context, widget.project, widget.token, widget.user),
                      child: Text(
                        'Finance',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(
                        0), // used to make the icon with centered inside the button
                    icon:
                        SvgPicture.asset('assets/icons/heart.svg', height: 30),
                    onPressed: () => null,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.project.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${widget.project.finalValue.toStringAsFixed(2)}€',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.project.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Financers',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.5,
                child: FutureBuilder(
                  future: _financers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          snapshot.data![index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            snapshot.data![index].username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text('Zero financers to show!'),
                            );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
