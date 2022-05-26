import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/controller/character_detail_controller.dart';
import 'package:marvel/controller/popular_character_controller.dart';
import 'package:marvel/helper/route_helper.dart';
import 'package:marvel/model/character.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key}) : super(key: key);

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PopularCharacterController>(
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(15.0),
              child: controller.isLoaded
                  ? Scrollbar(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: controller.popularCharacterList.length,
                        itemBuilder: (context, index) {
                          return characterListTile(
                              controller.popularCharacterList[index]);
                        },
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget characterListTile(Character character) {
    return GestureDetector(
      onTap: () {
        Get.find<CharacterDetailController>().getCharacterDetail(character);
        Get.toNamed(
          RouteHelper.characterDetail,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white38,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(character.imageUrl!))),
            ),
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      character.name!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_controller.position.extentAfter == 0) {
      Get.find<PopularCharacterController>().getPopularCharacterList();
    }
  }
}
