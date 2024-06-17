import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({Key? key}) : super(key: key);

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
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

  Future<void> toggleFavorite(String itemName, String imageUrl, double price, bool isFavorite) async {
    final favoritesCollection = _firestore.collection('favorites');
    if (isFavorite) {
      await favoritesCollection.doc(itemName).delete();
    } else {
      await favoritesCollection.doc(itemName).set({
        'name': itemName,
        'image': imageUrl,
        'price': price,
        'isFavorite': true,
      });
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
                      'Breakfast.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
              buildBreakfastItem('Tapsilog', 'assets/tapsilog.jpg', 130, 5.0),
              buildBreakfastItem('Tocino', 'assets/tocino.png', 130, 4.7),
              buildBreakfastItem('Arrozcaldo', 'assets/arrozcaldo.jpg', 130, 4.25),
              buildBreakfastItem('Tortang Talong', 'assets/torta.jpg', 130, 3.25),
              buildBreakfastItem('Bangsilog', 'assets/bangsilog.jpg', 130, 3.25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBreakfastItem(String name, String imagePath, double price, double rating) {
    return FutureBuilder<bool>(
      future: isFavorite(name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        bool isFav = snapshot.data ?? false;

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
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                  onPressed: () => toggleFavorite(name, imagePath, price, isFav),
                ),
                SizedBox(width: 20),
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
      },
    );
  }

  Future<bool> isFavorite(String itemName) async {
    final favoritesCollection = _firestore.collection('favorites');
    final doc = await favoritesCollection.doc(itemName).get();
    return doc.exists;
  }
}
