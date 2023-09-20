import 'package:api_calling/model/ApiService.dart';
import 'package:api_calling/model/NewsResponseModel.dart';
import 'package:api_calling/utils/Utils.dart';
import 'package:api_calling/view/news_item_view.dart';
import 'package:api_calling/viewModel/news_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NewsController newsController = Get.put(NewsController());
  Future<NewsResponseModel?>? dataList;


  void callApi(){
    dataList = fetchSearchNews(Utils.API_KEY, newsController.searchText.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ᆞkᆞᆞhᆞᆞoᆞᆞjᆞᆞoᆞ"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * .05,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TextFormField(
              onChanged: (value) {
                newsController.searchText.value = value;
                // newsController.callNewsApi();
                callApi();
                setState(() {});
              },
              decoration: const InputDecoration(
                  hintText: 'Search here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Expanded(
            child: FutureBuilder<NewsResponseModel?>(
              future: dataList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display loading message while data is being fetched
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle error case if the request fails
                  return Center(child: Text("An error occurred"));
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  if(data != null){
                    return ListView.builder(itemCount: data.articles?.length,itemBuilder: (context, index) {
                      var item = data.articles?[index];
                      if(item != null){
                        return NewsItemView(item: item);
                      }
                    },);
                  }
                  else{
                    return const Center(child: Text("Search Here"),);
                  }
                }
                return const Center(child: Text("Search Here"),);
              },
            )
            ,
          )
        ],
      ),
    );
  }
}
