import 'package:flutter/material.dart';

import '../../modules/arguments/home_page_arguments.dart';

class PopUpInfo {
  BuildContext context;
  PopUpInfo(this.context);

  static void info(
      BuildContext context, String title, String message, String? token) {
    Navigator.of(context).pop();
    var popUp = AlertDialog(
      content: Info(title: title, message: message, token: token),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => popUp,
    );
  }
}

class Info extends StatelessWidget {
  final String title;
  final String message;
  final String? token;
  const Info(
      {required this.title,
      required this.message,
      required this.token,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 75,
            child: ElevatedButton(
              onPressed: () => title == 'Error'
                  ? Navigator.pop(context)
                  : Navigator.pushNamed(
                      context,
                      '/',
                      arguments: HomePageArguments(
                        false,
                        false,
                        false,
                        false,
                        false,
                        null,
                        null,
                        null,
                        0,
                        token,
                      ),
                    ),
              child: const Text(
                'OK',
              ),
            ),
          )
        ],
      ),
    );
  }
}
