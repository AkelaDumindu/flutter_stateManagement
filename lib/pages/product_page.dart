import 'package:flutter/material.dart';
import 'package:flutter_state_management/data/product_data.dart';
import 'package:flutter_state_management/model/product_model.dart';
import 'package:flutter_state_management/pages/favourite_page.dart';
import 'package:flutter_state_management/pages/shopping_page.dart';

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
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Text("0"),
                ],
              ),
              subtitle: Text("\$${product.price.toString()}"),

              // right corner elements
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
