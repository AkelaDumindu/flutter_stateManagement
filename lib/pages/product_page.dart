import 'package:flutter/material.dart';
import 'package:flutter_state_management/data/product_data.dart';
import 'package:flutter_state_management/model/product_model.dart';
import 'package:flutter_state_management/pages/favourite_page.dart';
import 'package:flutter_state_management/pages/shopping_page.dart';
import 'package:flutter_state_management/providers/cart_provider.dart';
import 'package:flutter_state_management/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Shop",
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),

// floatingActionButton

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritePage(),
                  ));
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "favourite",
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingPage(),
                  ));
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "shopping",
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            //we use provider add item aftr clicking button so we use consumer for listtile
            child: Consumer2<CartProvider, FavouriteProvider>(
              builder: (BuildContext context, CartProvider cartProvider,
                  FavouriteProvider favouriteProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(cartProvider.items.containsKey(product.id)
                          ? cartProvider.items[product.id]!.quantity.toString()
                          : "0"),
                    ],
                  ),
                  subtitle: Text("\$${product.price.toString()}"),

                  // right corner elements
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favouriteProvider.toggleFavourite(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                favouriteProvider.isFavourite(product.id)
                                    ? "Added to favourite"
                                    : "Remove From favourite",
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          favouriteProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favouriteProvider.isFavourite(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItem(
                              product.id, product.price, product.name);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange[700]
                              : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
