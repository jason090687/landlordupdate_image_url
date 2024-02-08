import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanle/booking_summary.dart';

class MyItem {
  String title;
  String description;
  bool isFavorite;

  MyItem(
      {required this.title,
      required this.description,
      this.isFavorite = false});
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MyItem> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    // Assuming you have a Firestore collection named 'Records'
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Records').get();

    final itemData = querySnapshot.docs.map((doc) {
      return MyItem(
        title: doc['Name'] ?? '',
        description: 'Price: \$${doc['Price'] ?? 'N/A'}',
      );
    }).toList();

    setState(() => _favorites = itemData);
  }

  void _toggleFavorite(int index) {
    setState(
        () => _favorites[index].isFavorite = !_favorites[index].isFavorite);
  }

  void _navigateToDetailPage(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          item: _favorites.firstWhere((item) => item.title == title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Favorites',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: _favorites.isEmpty
            ? Center(child: Text('No favorites yet!'))
            : ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  final item = _favorites[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      title: Text(item.title,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item.description),
                      trailing: GestureDetector(
                        onTap: () => _toggleFavorite(index),
                        child: Icon(
                          item.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item.isFavorite ? Colors.red : null,
                        ),
                      ),
                      onTap: () => _navigateToDetailPage(item.title),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final MyItem item;

  const DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Records').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No data available');
          } else {
            // Assuming there's only one document in the collection
            var data = snapshot.data!.docs[0].data() as Map<String, dynamic>;

            // Extracting data from Firebase
            final boardingHouseName = data['Name'] ?? '';

            final discount = data['Discount'] ?? '';
            final starRating = data['star_rating'] ?? '';
            final location = data['Location'] ?? '';
            final description = data['Description'] ?? '';
            final contactInfo = data['Contact_info'] ?? Map<String, dynamic>();
            final galleryImages = data['Gallery_images'] ?? [];
            final pricePerMonth = data['Price'] ?? '';

            // Now, you can use the fetched data to update your UI
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PageView.builder(
                          itemCount: galleryImages.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: galleryImages[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            boardingHouseName ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/images/navigation.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('$discount% Off',
                                  style: const TextStyle(color: Colors.blue)),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  Text('$starRating (120 Reviews)'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, size: 10),
                          const SizedBox(width: 8),
                          Text(
                            location ?? '',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                            description ?? '',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Text(contactInfo['ContactInfo'] ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            contactInfo['Name'] ?? '',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(Icons.call_sharp),
                          const SizedBox(width: 5),
                          const Icon(Icons.mail),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '$pricePerMonth/ Months',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookSummaryPage()),
                            );
                          },
                          child: const Text(
                            'BOOK NOW',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
