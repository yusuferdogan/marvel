import 'package:get/get.dart';
import 'package:marvel/api/api_client.dart';
import 'package:marvel/utils/app_constants.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class PopularCharacters extends GetxService {
  final ApiClient apiClient;

  PopularCharacters({required this.apiClient});

  Future<Response> getPopularCharacters(int offset, int count) async {
    var uri = AppConstants.CHARACTER_URI + _createUri(offset, count);

    return await apiClient.get(uri);
  }

  String _createUri(int offset, int count) {
    String datetime = DateTime.now().millisecondsSinceEpoch.toString();
    String public = AppConstants.PUBLIC_KEY;
    String private = AppConstants.PRIVATE_KEY;
    String data = '$datetime$private$public';
    List<int> content = utf8.encode(data);

    var digest = md5.convert(content);
    

    return 'ts=$datetime&apikey=$public&hash=$digest&offset=$offset&limit=$count';
  }
}

