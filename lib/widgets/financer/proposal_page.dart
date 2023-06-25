import 'package:flutter/material.dart';

class ProposalPage extends StatefulWidget {
  final String? token;
  const ProposalPage({required this.token, super.key});

  static const String routeName = '/proposal';

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  String partnership = '';
  String title = '';
  String description = '';
  String location = '';
  String category = '';
  double totalAmountNeeded = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Partnership'),
              onChanged: (value) {
                setState(() {
                  partnership = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Total Amount Needed'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  totalAmountNeeded = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: const Text('Submit Proposal'),
            ),
          ],
        ),
      ),
    );
  }
}
