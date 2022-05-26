import 'package:get/get.dart';
import 'package:marvel/api/popular_characters.dart';
import 'package:marvel/model/character.dart';

class PopularCharacterController extends GetxController {
  final PopularCharacters popularCharacters;

  PopularCharacterController({required this.popularCharacters});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int offset = 0;

  final List<Character> _popularCharacterList = [];
  List<Character> get popularCharacterList => _popularCharacterList;

  Future<void> getPopularCharacterList() async {
    _isLoaded = false;

    Response response =
        await popularCharacters.getPopularCharacters(offset, 30);
    if (response.statusCode == 200) {
      CharacterData marvel = CharacterData.fromJson(response.body);
      _popularCharacterList.addAll(marvel.data!.results!);
      offset += 30;
      update();
      _isLoaded = true;
    } else {
      _isLoaded = true;
    }
  }
}
