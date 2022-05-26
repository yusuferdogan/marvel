import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/controller/character_detail_controller.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({Key? key}) : super(key: key);

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<CharacterDetailController>(
          builder: (controller) {
            return controller.isLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(controller.comicModel
                                      .first.character!.largeImageUrl!)))),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Text(
                              "${controller.comicModel.first.character!.name}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            controller.comicModel.first.character!.description!
                                    .isNotEmpty
                                ? Text(
                                    "${controller.comicModel.first.character!.description}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                : const Text(
                                    "(No description)",
                                    style: TextStyle(fontSize: 12),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 100,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              controller.comicModel.first.data!.results!.length,
                          itemBuilder: (context, index) {
                            var strs = controller
                                .comicModel.first.data!.results![index].title!
                                .split('#');
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              child: ListTile(
                                  title: Text(strs.first),
                                  tileColor: Colors.white,
                                  textColor: Colors.blueAccent,
                                  subtitle: Text(controller.comicModel.first
                                      .data!.results![index].dates![0].date!
                                      .split('T')[0]),
                                  leading: Image(
                                    image: NetworkImage(controller.comicModel
                                        .first.data!.results![index].imageUrl!),
                                  )),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
