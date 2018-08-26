import 'package:flutter/material.dart';

import 'video_card.dart';

class VideoList extends StatelessWidget {
  const VideoList(this.items);

  final List<Map> items;

  Widget _buildItem(BuildContext context, int index) {
    final data = Map<String, dynamic>.unmodifiable(items[index]);
    return VideoCard.fromData(data);
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: items.length,
        itemBuilder: _buildItem,
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 240.0),
      );
}
