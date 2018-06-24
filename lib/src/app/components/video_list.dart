import 'package:flutter/material.dart';

import 'video_card.dart';

// class _ListError extends StatefulWidget {
//   @override
//   _ListErrorState createState() => _ListErrorState();
// }

// class _ListErrorState extends State<_ListError>
//     with AfterLayoutMixin<_ListError> {

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Center(
//       child: Icon(
//         Icons.mood_bad,
//         color: theme.textTheme.caption.color,
//         size: 48.0,
//       ),
//     );
//   }

class VideoList extends StatelessWidget {
  VideoList(this.items);

  final List items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: kMaterialListPadding,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) =>
            VideoCard.fromData(items[index]));
  }
}
