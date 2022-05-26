// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel/api/api_client.dart';
import 'package:marvel/api/popular_characters.dart';
import 'package:marvel/controller/popular_character_controller.dart';
import 'package:get/get.dart';
import 'package:marvel/main.dart';
import 'package:marvel/utils/app_constants.dart';

void main() {
  testWidgets("Golden test", (WidgetTester tester) async {
    Get.put(ApiClient(appBaseUrl: AppConstants.BASE_URL));
    Get.put(PopularCharacters(apiClient: Get.find()));
    final controller = PopularCharacterController(
        popularCharacters: Get.find<PopularCharacters>());
    Get.put(controller);
    await tester.pumpWidget(const MyApp());
    await expectLater(find.byType(MyApp), matchesGoldenFile('backgroud.webp'));
  });
}
