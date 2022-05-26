import 'package:get/get.dart';
import 'package:marvel/pages/character_detail_page.dart';
import 'package:marvel/pages/character_list_page.dart';
import 'package:marvel/pages/home_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String characterList = "/character-list";
  static const String characterDetail = "/character-detail";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: characterList,
        page: () => const CharacterListPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: characterDetail,
        page: () => const CharacterDetailPage(),
        transition: Transition.fadeIn)
  ];
}
