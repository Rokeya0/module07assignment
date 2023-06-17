import 'package:flutter/material.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Polo T-shirt', price: 550.0),
    Product(name: 'Shirt', price: 1580.0),
    Product(name: 'Pant', price: 1200.0),
  ];

  int cartItemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cartItemCount: cartItemCount)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: CounterButton(
              count: products[index].count,
              onCountReached: () {
                products[index].incrementCount();
                if (products[index].count == 5) {
                  _showDialog(products[index].name);
                }
                setState(() {
                  cartItemCount++;
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 $productName!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String name;
  final double price;
  int count = 0;

  Product({required this.name, required this.price});

  void incrementCount() {
    count++;
  }
}

class CounterButton extends StatelessWidget {
  final int count;
  final VoidCallback onCountReached;

  CounterButton({required this.count, required this.onCountReached});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {},
        ),
        Text(count.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onCountReached();
          },
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  final int cartItemCount;

  CartPage({required this.cartItemCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: $cartItemCount'),
      ),
    );
  }
}
