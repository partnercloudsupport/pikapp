import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class _ShopItem extends StatelessWidget {
  _ShopItem({
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    Key key,
  }) : super(key: key);

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
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageUrl,
              fit: BoxFit.fitWidth,
              fadeOutDuration: Duration(milliseconds: 0),
              fadeInDuration: Duration(milliseconds: 150),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  title ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    subtitle ?? '',
                    style: TextStyle(color: Colors.black87, fontSize: 12.0),
                  ),
                ),
              ],
            ),
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

    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: documentsCount,
      itemBuilder: (BuildContext context, int index) {
        final DocumentSnapshot document = snapshot.data.documents[index];
        return _ShopItem(
          title: document['title'],
          subtitle: document['subtitle'],
          imageUrl: document['imageUrl'],
          // key: PageStorageKey(document),
        );
      },
      padding: EdgeInsets.all(8.0),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 40.0,
      crossAxisSpacing: 4.0,
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
