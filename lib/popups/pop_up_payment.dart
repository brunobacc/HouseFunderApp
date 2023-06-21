import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/finance_project.dart';
import 'package:projeto_computacao_movel/modules/project.dart';
import 'package:projeto_computacao_movel/popups/pop_up_info.dart';

import '../modules/user.dart';

class PopUpPayment {
  BuildContext context;
  PopUpPayment(this.context);

  static void payment(
      BuildContext context, Project project, String? token, User? user) {
    var popUp = AlertDialog(
      content: Finance(project: project, token: token, user: user),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }
}

class Finance extends StatefulWidget {
  final Project project;
  final String? token;
  final User? user;
  const Finance(
      {required this.project,
      required this.token,
      required this.user,
      super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  TextEditingController amountFinancedController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Financing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Amount:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountFinancedController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 5)
                          .toString();
                }),
                child: const Text('5€'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 10)
                          .toString();
                }),
                child: const Text('10€'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  amountFinancedController.text =
                      (double.parse(amountFinancedController.text) + 20)
                          .toString();
                }),
                child: const Text('20€'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Payment Methods:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  // create a new variable to store the bool received from the "DeletePlayer" function
                  Future<bool> financeStatus = FinanceProject.financeProject(
                    widget.project,
                    double.parse(amountFinancedController.text),
                    widget.token,
                    widget.user,
                  );
                  // when playerDeleted receives a bool value, it will present an information popUp
                  financeStatus.then(
                    (value) {
                      value
                          ? PopUpInfo.info(
                              context,
                              'Sucess',
                              'The project was financed!',
                              widget.token,
                            )
                          : PopUpInfo.info(
                              context,
                              'Error',
                              'Something happen when it was financing the project!',
                              widget.token,
                            );
                    },
                  );
                },
                child: Image.asset(
                  'assets/images/methods/multibanco.png',
                  height: 60,
                  width: 60,
                ),
              ),
              InkWell(
                onTap: () => null,
                child: Image.asset(
                  'assets/images/methods/mbWay.png',
                  height: 60,
                  width: 60,
                ),
              ),
              InkWell(
                onTap: () => null,
                child: Image.asset(
                  'assets/images/methods/PayPal.png',
                  height: 60,
                  width: 60,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
