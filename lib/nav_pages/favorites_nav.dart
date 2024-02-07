import 'package:flutter/material.dart';

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
  const FavoritePage({super.key});

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
    await Future.delayed(Duration(seconds: 1));
    final itemData = List.generate(
      5,
      (index) => MyItem(
        title: 'Item $index',
        description: 'This is a description for Item $index. Lorem ipsum...',
      ),
    );

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
            item: _favorites.firstWhere((item) => item.title == title)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Favorites',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.blue, // Set the background color here
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
        backgroundColor: Colors.blue, // Set the background color here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(item.description, textAlign: TextAlign.center),
            SizedBox(height: 20),
            Text('Details for ${item.title}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
