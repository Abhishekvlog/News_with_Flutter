import 'dart:convert';
import 'package:api_calling/model/NewsResponseModel.dart';
import 'package:api_calling/utils/Utils.dart';
import 'package:http/http.dart' as http;

int _offset = 1;
int _limit = 15;

Future<NewsResponseModel?> fetchNews(String api) async{
  final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=a&from=2023-09-13&sortBy=publishedAt&apiKey=$api&pageSize=$_limit&page=$_offset"));
  var data = jsonDecode(response.body);
  if(response.statusCode == 200){
    return NewsResponseModel.fromJson(data);
  }
  else{
    return NewsResponseModel.fromJson(data);
  }
}

Future<NewsResponseModel?> fetchSearchNews(String api, String search) async{
  final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=$search&from=2023-09-13&sortBy=publishedAt&apiKey=$api&pageSize=25&page=1"));
  var data = jsonDecode(response.body);
  print(response.statusCode);
  if(response.statusCode == 200){
    print("data is -  -- $data");
    return NewsResponseModel.fromJson(data);
  }
  else{
    print("else block...");
    return NewsResponseModel.fromJson(data);
  }
}

Future<List<Articles>?> fetchNext20News(List<Articles>? existingList) async{
  if(_limit > 40){
    _offset ++ ;
    _limit = 15;
  }
  else{
    _limit += _limit;
  }
  try{
    print("enter in service - page = $_offset and newsSize = $_limit ");
    final NewsResponseModel? response = await fetchNews(Utils.API_KEY);
    if(response != null){
      existingList?.addAll(response.articles ?? []);
      return existingList;
    }
  }
  catch(e){
    print("response is getting error ");
  }
}
