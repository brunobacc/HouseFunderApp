import 'package:flutter/material.dart';
import 'package:projeto_computacao_movel/widgets/utils/bottom_navigation_bar_widget.dart';

class ProposalPage extends StatefulWidget {
  final String? token;
  const ProposalPage({required this.token, super.key});

  static const String routeName = '/proposal';

  @override
  _ProposalPageState createState() => _ProposalPageState();
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Partnership'),
              onChanged: (value) {
                setState(() {
                  partnership = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Category'),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Total Amount Needed'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  totalAmountNeeded = double.parse(value);
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                null;
              },
              child: Text('Submit Proposal'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: -1,
        token: widget.token,
      ),
    );
  }
}
