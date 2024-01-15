// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        home: ProductListScreen(),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              var product = provider.products[index];
              return ListTile(
                leading: Image.asset(product.image),
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: product.addedToCart
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              provider.removeFromCart(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              provider.removeFromCart(index);
                            },
                          ),
                        ],
                      )
                    : IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          provider.addToCart(index);
                        },
                      ),
              );
            },
          );
        },
      ),
    );
  }
}

// main.dart (updated CartScreen)
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) {
                    var product = provider.cartProducts[index];
                    return ListTile(
                      leading: Image.asset(product.image),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Total: \$${provider.totalCartPrice.toStringAsFixed(2)}'),
                        ElevatedButton(
                          onPressed: () {
                            provider.clearCart();
                          },
                          child: Text('BUY'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Perform the action when the BUY button is clicked
                        // For now, it just clears the cart
                        provider.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Purchase completed!'),
                          ),
                        );
                      },
                      child: Text('BUY NOW'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
