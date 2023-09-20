import 'package:api_calling/model/NewsResponseModel.dart';
import 'package:api_calling/view/display_network_image.dart';
import 'package:flutter/material.dart';

class NewsItemView extends StatelessWidget {
  final Articles? item;
  const NewsItemView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.av_timer),
                      ),
                      Text(item!.publishedAt.toString())
                    ],
                  )
                ],
              ),
            ),
            DisplayNetworkImage(imageUrl: item!.urlToImage.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 6),
              child: Text(item!.title.toString()),
            )
          ],
        ),
      ),
    );
  }
}
