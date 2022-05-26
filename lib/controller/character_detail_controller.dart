import 'package:get/get.dart';
import 'package:marvel/api/character_detail.dart';

import 'package:marvel/model/character.dart';
import 'package:marvel/model/comic_model.dart';

class CharacterDetailController extends GetxController {
  final CharacterDetail detailCharacters;

  final List<ComicModel> _comicModel = [];
  List<ComicModel> get comicModel => _comicModel;

  CharacterDetailController({required this.detailCharacters});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int offset = 0;
  
  Future<void> getCharacterDetail(Character ch) async {
    _isLoaded = false;

    Response response =
        await detailCharacters.getCharacterDetail(ch.id!, offset, 10);
    if (response.statusCode == 200) {
      _comicModel.clear();
      var model = ComicModel.fromJson(response.body);
      model.character = ch;
      _comicModel.add(model);
      update();
      _isLoaded = true;
    } else {
      _isLoaded = true;
    }
  }
}
