import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'stripeApikey.dart';
import 'package:flutter/material.dart';

abstract class Stripemangement {
static Future<void> makePayment(int amount,String currnecy)async{
  try{
String client_secret = await _get_client_secret((amount*100).toString(),currnecy);
await _initalizepaymentsheet(client_secret);
await Stripe.instance.presentPaymentSheet();

  }catch(e){
    print("Error making payment: $e");
  }

}
static Future<void> _initalizepaymentsheet(String client_secret) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: client_secret,
      style: ThemeMode.light,
      merchantDisplayName: 'Omar',
    ),
  );
}

}
 Future<String> _get_client_secret(String amount,String currency) async{
Dio dio = Dio();
final response = await dio.post( 'https://api.stripe.com/v1/payment_intents',
options: Options(
headers: {  
'Authorization': 'Bearer ${StripeApiKey.secretKey}',
'Content-Type': 'application/x-www-form-urlencoded',
},
),
data: {'amount': amount, // Amount in cents
'currency': currency,
},
);
return response.data['client_secret'];
}
