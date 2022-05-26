import 'package:get/get.dart';
import 'package:marvel/api/api_client.dart';
import 'package:marvel/utils/app_constants.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class CharacterDetail extends GetxService {
  final ApiClient apiClient;

  CharacterDetail({required this.apiClient});

  Future<Response> getCharacterDetail(int id, int offset, int count) async {
    var uri = '${AppConstants.DETAIL_URI}$id/comics?${_createUri(offset, count)}';

    return await apiClient.get(uri);
  }
// /v1/public/characters/1011334/ts=1653540190666&apikey=fd701d3876b45b67bec9210b2667e991&hash=8deafdf59bbfe6f0c1952d39dfee3926&offset=0&limit=10&dateRange=2005-01-01%2C2022-5-26&orderBy=-onsaleDate
  String _createUri(int offset, int count) {
    DateTime now = DateTime.now();
    String datetime = now.millisecondsSinceEpoch.toString();
    String public = AppConstants.PUBLIC_KEY;
    String private = AppConstants.PRIVATE_KEY;
    String data = '$datetime$private$public';
    List<int> content = utf8.encode(data);

    var digest = md5.convert(content);

    String till = "${now.year}-${now.month}-${now.day}";
    String from = "2005-01-01";

    return 'ts=$datetime&apikey=$public&hash=$digest&offset=$offset&limit=$count&dateRange=$from%2C$till&orderBy=-onsaleDate';
  }
}


/*
http://gateway.marvel.com/v1/public/characters/1011334/comics?ts=1653474065158&apikey=fd701d3876b45b67bec9210b2667e991&hash=b1ea26d9a78841bc005cbe6874b9f35d&offset=0&limit=10&dateRange=2005-01-01%2C2022-01-01&orderBy=-onsaleDate
*/