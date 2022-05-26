import 'package:get/get.dart';
import 'package:marvel/api/api_client.dart';
import 'package:marvel/api/character_detail.dart';
import 'package:marvel/api/popular_characters.dart';
import 'package:marvel/controller/character_detail_controller.dart';
import 'package:marvel/controller/popular_character_controller.dart';

import 'package:marvel/utils/app_constants.dart';

bool isInit = false;

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularCharacters(apiClient: Get.find()));
  Get.lazyPut(() => CharacterDetail(apiClient: Get.find()));

  Get.lazyPut(() => PopularCharacterController(popularCharacters: Get.find()));
  Get.lazyPut(() => CharacterDetailController(detailCharacters: Get.find()));
  isInit = true;
}
