import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Snacks extends StatefulWidget {
  const Snacks({Key? key}) : super(key: key);

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(String itemName, String imageUrl, double price) async {
    try {
      await _firestore.collection('cart').add({
        'name': itemName,
        'image': imageUrl,
        'price': price,
        'quantity': 1,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$itemName added to cart')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add $itemName to cart')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      'Snacks.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
              buildSnackItem('Lumpia', 'assets/shanghai.jpg', 49, 4.5),
              buildSnackItem('Kwek-Kwek', 'assets/kwekkwek.jpg', 29, 4.7),
              buildSnackItem('Ensaymada', 'assets/ensaymada.jpg', 49, 5.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSnackItem(String name, String imagePath, double price, double rating) {
    return Column(
      children: [
        Container(
          width: 330,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(width: 60),
            Icon(Icons.star, color: Colors.red),
            Text(
              '$rating Reviews',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40),
            Text('P $price'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () => addToCart(name, imagePath, price),
            ),
            SizedBox(width: 40),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
