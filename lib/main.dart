import 'package:ecommrece_app_no_ai/stripeApikey.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import "_shopping.dart";
import 'package:flutter/material.dart';
void main() {
  Stripe.publishableKey = StripeApiKey.publishableKey;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: ShoppingScreen(),
    );
  }
}
