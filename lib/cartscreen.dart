// cart_screen.dart
import 'package:ecommrece_app_no_ai/stripemangement.dart';
import 'package:flutter/material.dart';
import "_shopping.dart";
class CartScreen extends StatefulWidget {
  final Map<Product, int> cart;
  final ValueChanged<Map<Product, int>> onCartUpdated;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onCartUpdated,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Map<Product, int> _cart;

  @override
  void initState() {
    super.initState();
    _cart = Map.from(widget.cart);
  }

  void _updateQuantity(Product p, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cart.remove(p);
      } else {
        _cart[p] = quantity;
      }
      widget.onCartUpdated(_cart);
    });
  }

  double get _totalPrice {
    return _cart.entries
        .map((e) => e.key.price * e.value)
        .fold(0.0, (sum, element) => sum + element);
  }
  Future<void>handlePayment()async{
        double amount = _totalPrice;
                      // Add your payment logic here using 'amount'
                      try{
                       await   Stripemangement.makePayment(amount.toInt() , 'usd');
                      }catch(e){
                        print(e);
                      } 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: _cart.isEmpty
          ? const Center(child: Text('No products in the cart'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      final p = _cart.keys.elementAt(index);
                      final qty = _cart[p] ?? 1;
                      return ListTile(
                        leading: Image.network(p.imageUrl, width: 50, height: 50),
                        title: Text(
                          p.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text('Price: \$${p.price.toStringAsFixed(2)}'),
                        trailing: SizedBox(
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => _updateQuantity(p, qty - 1),
                              ),
                              Text('$qty'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _updateQuantity(p, qty + 1),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _updateQuantity(p, 0),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${_totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 120,
                    height: 70,
                  child: MaterialButton(
                    onPressed: ()=>handlePayment(),
                    child: Text("Pay", style: TextStyle(color: Colors.white)),
                  ),
                  ),
                ),
             Container(
              width: 150,
              height: 100,
             )

              ],
            ),
    );
  }
}
