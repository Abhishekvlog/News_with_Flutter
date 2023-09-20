import 'package:api_calling/model/NewsResponseModel.dart';
import 'package:api_calling/view/display_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemDetailScreen extends StatefulWidget {
  final Articles item;

  const NewsItemDetailScreen({super.key, required this.item});

  @override
  State<NewsItemDetailScreen> createState() => _NewsItemDetailScreenState();
}

class _NewsItemDetailScreenState extends State<NewsItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          DisplayNetworkImage(imageUrl: widget.item.urlToImage.toString()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 10),
                          child: Text(
                            widget.item.title.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 10),
                          child: RichTextView("Posted By: ", widget.item.author.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 10),
                          child: Text(widget.item.description.toString()),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 10),
                          child: Text(widget.item.content.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 10),
                          child: TextToUrl(widget.item.url.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 6),
                          child : RichTextView("Source: ", widget.item.source!.name.toString())
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 10),
                            child : RichTextView("Posted At: ", widget.item.publishedAt.toString())
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText RichTextView(String startText, String endText ){
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style, // Default text style
        children: <TextSpan>[
          TextSpan(
            text: startText,
            style: const TextStyle(
                fontWeight: FontWeight.normal, // Make this part bold
                fontSize: 16, // Set the font size to 18
                color: Colors.black,
                decoration: TextDecoration.none// Set the text color to red
            ),
          ),
          TextSpan(
            text: endText,
            style: const TextStyle(
                fontWeight: FontWeight.bold, // Make this part bold
                fontSize: 16, // Set the font size to 18
                color: Colors.black,
                decoration: TextDecoration.none// Set the text color to red
            ),
          ),
        ],
      ),
    );
  }

  Text TextToUrl(String link){
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'For more info: ',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: link,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue, // Use a color that indicates a link
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final Uri uri = Uri(scheme: 'http', host: link);
                if (!await launchUrl(uri, mode: LaunchMode.inAppWebView) ) {
                  print("cant open this url");
                }
              },
          ),
        ],
      ),
    );
  }
}
