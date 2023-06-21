import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/data/finance_project.dart';
import 'package:projeto_computacao_movel/modules/project.dart';

class PopUpPayment {
  BuildContext context;
  PopUpPayment(this.context);

  static void payment(BuildContext context, Project project, String? token) {
    var popUp = AlertDialog(
      content: Finance(project: project, token: token),
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
  const Finance({required this.project, required this.token, super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  TextEditingController amountFinancedController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  decoration: InputDecoration(),
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
                onTap: () => FinanceProject.financeProject(widget.project,
                    double.parse(amountFinancedController.text), widget.token),
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
