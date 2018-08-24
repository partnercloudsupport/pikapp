import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'video_card.dart';

class VideoList extends StatelessWidget {
  const VideoList(this.items);

  final List<Map> items;

  Widget _buildItem(BuildContext context, int index) {
    final data = Map<String, dynamic>.unmodifiable(items[index]);
    return VideoCard.fromData(data);
  }

  Widget _buildGrid(BuildContext context, Orientation orientation) {
    // Create a grid with 1 column in portrait mode,
    // or 3 columns in landscape mode.
    final crossAxisCount = orientation == Orientation.portrait ? 1 : 3;

    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: items.length,
      itemBuilder: _buildItem,
      padding: const EdgeInsets.all(8.0),
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 2.0,
      crossAxisSpacing: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(builder: _buildGrid);
}
