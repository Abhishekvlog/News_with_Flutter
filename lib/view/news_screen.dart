import 'package:api_calling/model/ApiService.dart';
import 'package:api_calling/model/NewsResponseModel.dart';
import 'package:api_calling/utils/Utils.dart';
import 'package:api_calling/view/news_item_detail_screen.dart';
import 'package:api_calling/view/news_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController _scrollController = ScrollController();
  Future<NewsResponseModel?>? _dataList;
  List<Articles> articlesList = [];

  @override
  void initState() {
    super.initState();
    _dataList = fetchNews(Utils.API_KEY);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("enter in pixel loop");
        fetchNext20News(articlesList).then((newArticles){
          if(newArticles != null){
            setState(() {
              articlesList = newArticles;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("N͟e͟w͟s͟"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<NewsResponseModel?>(
              future: _dataList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  articlesList = data?.articles ?? [];
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: articlesList.length,
                    itemBuilder: (context, index) {
                      var item = articlesList[index];
                      return InkWell(
                        onTap:() {
                          Get.to(NewsItemDetailScreen(item: item));
                        },
                          child: NewsItemView(item: item)
                      );
                    },
                  );
                } else {
                  print("error is occoured");
                }
                return SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
