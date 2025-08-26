🛒 Ecommerce Flutter App
A simple Flutter-based e-commerce app built as a practice project to learn how to integrate Stripe payment.
The app demonstrates a mini shopping flow from browsing products to checkout and payment.
✨ Features
Fetch products from an external API.

Search for products.

Add products to the shopping cart.

Automatically calculate total price.

Secure payment integration with Stripe.
🚀 Getting Started
1. Clone the repository
git clone https://github.com/your-username/ecommerce-flutter-app.git
cd ecommerce-flutter-app

2. Install dependencies
flutter pub get

3. Stripe Setup

Create an account on Stripe
.

Enable Test Mode.

Generate your Publishable key and Secret key.

In your stripemangement.dart, configure the payment logic with your keys:

class Stripemangement {
  static Future<void> makePayment(int amount, String currency) async {
    try {
      // Implement your Stripe payment logic here
      // 'amount' is in the smallest currency unit (e.g., cents for USD)
    } catch (e) {
      print("Payment failed: $e");
    }
  }
}


⚠️ Important:

Never expose your Secret Key in the mobile app.

For production, you must use a secure backend server to handle the payment process safely.

This project uses a simplified approach for learning purposes only.

4. Run the app
flutter run

📦 Packages Used

http → Fetch product data from the API.

flutter_stripe (or custom payment logic) → Stripe integration.

material → Flutter Material UI components.

📌 Notes

This project is for learning purposes only and not production-ready.

Possible improvements:

User authentication.

Order storage in a database.

Better UI/UX.

