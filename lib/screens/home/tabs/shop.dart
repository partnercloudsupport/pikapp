import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class _ShopItem extends StatelessWidget {
  const _ShopItem({
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
  Widget build(BuildContext context) => Card(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitWidth,
                fadeOutDuration: const Duration(milliseconds: 0),
                fadeInDuration: kThemeAnimationDuration,
              ),
            ),
            ExpansionTile(
              key: PageStorageKey<String>(id),
              title: Text(
                title ?? '',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    subtitle ?? '',
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class ShopTab extends StatelessWidget {
  Widget _buildGrid(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) return const LinearProgressIndicator();

    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) {
        final document = snapshot.data.documents[index];
        return _ShopItem(
          id: document.documentID,
          title: document['title'],
          subtitle: document['subtitle'],
          imageUrl: document['imageUrl'],
        );
      },
      padding: const EdgeInsets.all(8.0).copyWith(bottom: 240.0),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('products').snapshots(),
        builder: _buildGrid,
      );
}
