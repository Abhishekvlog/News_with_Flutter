import 'package:flutter/material.dart';

class DisplayNetworkImage extends StatelessWidget {
  final String imageUrl;
  const DisplayNetworkImage({super.key ,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if(loadingProgress == null){
          return child;
        }
        else{
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        }
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        // Show an error message if the image fails to load
        return Text('image can not  loading');
      },
    );
  }
}
