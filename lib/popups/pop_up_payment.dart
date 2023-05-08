import 'package:flutter/material.dart';

class PopUpPayment extends StatefulWidget {
  const PopUpPayment({super.key});

  @override
  State<PopUpPayment> createState() => _PopUpPaymentState();
}

class _PopUpPaymentState extends State<PopUpPayment> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Slider(
            value: value,
            min: 0,
            max: 1000,
            onChanged: (val) {
              setState(() {
                value = val;
              });
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, value);
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}
