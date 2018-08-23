import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'video_card.dart';

class VideoList extends StatelessWidget {
  VideoList(this.items);

  final List items;

  Widget _buildItem(BuildContext context, int index) {
    Map<String, dynamic> data = Map<String, dynamic>.unmodifiable(items[index]);
    return VideoCard.fromData(data);
  }

  Widget _buildGrid(BuildContext context, Orientation orientation) {
    // Create a grid with 1 column in portrait mode, or 3 columns in landscape mode.
    int crossAxisCount = orientation == Orientation.portrait ? 1 : 3;

    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: items.length,
      itemBuilder: _buildItem,
      padding: EdgeInsets.all(8.0),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: _buildGrid);
  }
}
