import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class _ShopItem extends StatelessWidget {
  _ShopItem({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitWidth,
              fadeOutDuration: Duration(milliseconds: 0),
              fadeInDuration: kThemeAnimationDuration,
            ),
          ),
          ExpansionTile(
            key: PageStorageKey<String>(id),
            title: Text(
              title ?? '',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  subtitle ?? '',
                  style: TextStyle(color: Colors.black87, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShopTab extends StatelessWidget {
  Widget _buildGrid(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) return LinearProgressIndicator();

    final int documentsCount = snapshot.data.documents.length;

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return StaggeredGridView.countBuilder(
          // Create a grid with 2 columns in portrait mode, or 4 columns in landscape mode.
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          itemCount: documentsCount,
          itemBuilder: (BuildContext context, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            return _ShopItem(
              id: document.documentID,
              title: document['title'],
              subtitle: document['subtitle'],
              imageUrl: document['imageUrl'],
            );
          },
          padding: EdgeInsets.all(8.0),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          mainAxisSpacing: 40.0,
          crossAxisSpacing: 4.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: _buildGrid,
    );
  }
}
