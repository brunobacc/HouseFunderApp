import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_computacao_movel/modules/financer.dart';
import 'package:projeto_computacao_movel/modules/financers.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/popups/pop_up_payment.dart';

class ProjectDetails extends StatefulWidget {
  late Project? project;
  ProjectDetails({super.key, this.project});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  late Financers financers;

  @override
  void initState() {
    super.initState();
    financers = Financers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          widget.project!.title,
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
                    'assets/images/${widget.project!.image}',
                  ),
                  fit: BoxFit.fill,
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
                              value: (widget.project!.financedValue /
                                  widget.project!.finalValue),
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
                                    '${widget.project!.financedValue.toString()}€',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    '${(widget.project!.finalValue - widget.project!.financedValue).toString()}€',
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
                      onPressed: () => null,
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
                      widget.project!.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${widget.project!.finalValue.toString()}€',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  widget.project!.description,
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
                child: financers.countFinancers > 0
                    ? GridView.builder(
                        itemCount: financers.countFinancers,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          Financer financer = financers.list[index];
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
                                    financer.image,
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
                                      financer.name,
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
