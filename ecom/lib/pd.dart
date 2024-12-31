import 'package:ecommerce_app_ca_tdd/cart.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final List<Map<String, dynamic>> cart = [];
  int quantity = 1;

  void addToCart(Map<String, dynamic> product) {
    final existingProduct =
        cart.indexWhere((item) => item['id'] == product['id']);
    if (existingProduct != -1) {
      setState(() {
        cart[existingProduct]['quantity'] += quantity;
      });
    } else {
      setState(() {
        cart.add({...product, 'quantity': quantity});
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Cart')),
    );
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product['price']}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product['description'] ??
                  "Experience the ultimate in sound quality with our Wireless Bluetooth Headphones. Featuring crystal-clear audio, comfortable over-ear design, and up to 20 hours of battery life, these headphones are perfect for music lovers and gamers alike. Built-in noise cancellation ensures an immersive listening experience, while Bluetooth 5.0 technology provides a stable and fast connection to your devices. Lightweight and foldable for easy portability, these headphones are your ideal companion for travel, work, and relaxation.",
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: decrementQuantity,
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(widget.product);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cart: cart),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
