import 'package:flutter/material.dart';
import 'package:whats_app/core/routes/route_constants.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              "Welcome To WatsApp",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Expanded(child: Image.asset("assets/images/landing_screen.png")),
            Text(
              "Read our Privacy Policy, Tap \"Agree and continue\" to accept the Terms of Service.",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteList.login);
                },
                child: const Text("Agree And Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
