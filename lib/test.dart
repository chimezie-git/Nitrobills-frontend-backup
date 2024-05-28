import 'package:flutter/material.dart';
import 'package:nitrobills/app/data/services/auth/custom_token_authentication.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await CustomTokenAuthentication.auth("customtoken");
                debugPrint("logged in");
              },
              child: const Text("login"))
        ],
      ),
    );
  }
}
