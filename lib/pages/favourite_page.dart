import 'package:flutter/material.dart';
import 'package:flutter_state_management/data/product_data.dart';
import 'package:flutter_state_management/model/product_model.dart';
import 'package:flutter_state_management/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Page"),
      ),
      body: Consumer<FavouriteProvider>(
        builder: (BuildContext context, FavouriteProvider favouriteProvider,
            Widget? child) {
          // want get map data as list
          final favItem = favouriteProvider.favorite.entries
              .where((entry) => entry.value)
              .map((e) => e.key)
              .toList();

          return ListView.builder(
            itemCount: favItem.length,
            itemBuilder: (context, index) {
              final productId = favItem[index];
              final Product product = ProductData().products.firstWhere(
                    (element) => element.id == productId,
                  );

              return Card(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    onPressed: () {
                      favouriteProvider.toggleFavourite(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Remove From favourite",
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
