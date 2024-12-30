import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Product 1',
      'price': 20.0,
      'image':
          'https://img.freepik.com/free-photo/man-wearing-blank-shirt_23-2149347484.jpg?semt=ais_hybrid',
    },
    {
      'name': 'Product 2',
      'price': 30.0,
      'image':
          'https://img.freepik.com/free-photo/elegant-smartphone-composition_23-2149437106.jpg?semt=ais_hybrid',
    },
    {
      'name': 'Product 3',
      'price': 50.0,
      'image':
          'https://images.pexels.com/photos/1866149/pexels-photo-1866149.jpeg',
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                product['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '\$${product['price']}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () => addToCart(product),
                child: const Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class CartPage extends StatelessWidget {
//   final List<Map<String, dynamic>> cart;

//   const CartPage({Key? key, required this.cart}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cart'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_bag),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductListPage(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: cart.isEmpty
//           ? const Center(
//               child: Text(
//                 'Your cart is empty.',
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               itemCount: cart.length,
//               itemBuilder: (context, index) {
//                 final product = cart[index];
//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     leading: Image.network(
//                       product['image'],
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(
//                       product['name'],
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       '\$${product['price']}',
//                       style: const TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProductListPage(),
//             ),
//           );
//         },
//         child: const Icon(Icons.shopping_cart_checkout),
//       ),
//     );
//   }
// }

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void incrementQuantity(int index) {
    setState(() {
      widget.cart[index]['quantity']++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (widget.cart[index]['quantity'] > 1) {
        widget.cart[index]['quantity']--;
      } else {
        widget.cart.removeAt(index); // Remove item if quantity reaches zero
      }
    });
  }

  double calculateTotal() {
    return widget.cart.fold(0.0, (total, item) {
      return total + (item['price'] * item['quantity']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final product = widget.cart[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(
                            product['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${product['price']}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => decrementQuantity(index),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    product['quantity'].toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    onPressed: () => incrementQuantity(index),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                widget.cart.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Removed from Cart'),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${calculateTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle checkout logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checkout not implemented yet'),
                            ),
                          );
                        },
                        child: const Text('Checkout'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductListPage(), // Replace with actual product list page
            ),
          );
        },
        child: const Icon(Icons.shopping_cart_checkout),
      ),
    );
  }
}
