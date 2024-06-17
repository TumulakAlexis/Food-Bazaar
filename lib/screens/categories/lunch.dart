import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lunch extends StatefulWidget {
  const Lunch({Key? key}) : super(key: key);

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
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
                      'Lunch.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
              buildLunchItem('Sisig', 'assets/sisig.jpg', 99, 4.5),
              buildLunchItem('Adobo', 'assets/adobo.jpg', 130, 4.7),
              buildLunchItem('Lechon Kawali', 'assets/lechon.jpg', 250, 5.0),
              buildLunchItem('Sinigang', 'assets/sinigang.jpg', 135, 3.25),
              buildLunchItem('Chicken Inasal', 'assets/inasal.jpg', 130, 3.25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLunchItem(String name, String imagePath, double price, double rating) {
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
