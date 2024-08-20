import 'package:flutter/material.dart';
import 'package:flutter_state_management/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart Page",
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        body: Consumer<CartProvider>(
            builder: (context, CartProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    //get all item valuse to add cart and convert it into list
                    final item = cartProvider.items.values.toList()[index];

                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber[100]),
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.id),
                            Text('\$${item.price} x ${item.quantity}')
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.oneItemRemove(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('One Item Remove from cart!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Item Remove successfully!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.remove_shopping_cart),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Total: \$${cartProvider.cartTotal.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.cartClear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart Cleared!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text("Cart Clear"),
                ),
              ),
            ],
          );
        }));
  }
}
