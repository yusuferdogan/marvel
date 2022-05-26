import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel/controller/popular_character_controller.dart';
import 'package:marvel/helper/connection_helper.dart';
import 'package:marvel/helper/route_helper.dart';
import 'package:marvel/helper/dependencies.dart' as dep;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ConnectionHelper.haveConnection) {
      Get.find<PopularCharacterController>().getPopularCharacterList();
    }
    return Scaffold(
      backgroundColor: const Color(0xFF69C5DF),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/backgroud.webp"),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pick Your Favorite",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Character",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFFBC33E),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: const Color(0xFFFBC33E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    onPressed: () async {
                      if (ConnectionHelper.haveConnection) {
                        Get.toNamed(
                          RouteHelper.characterList,
                        );
                      } else {
                        await ConnectionHelper.checkInternetConnection();
                        if (ConnectionHelper.haveConnection) {
                          if (!dep.isInit) {
                            dep.init();
                          }
                          Get.find<PopularCharacterController>()
                              .getPopularCharacterList();
                          Get.toNamed(
                            RouteHelper.characterList,
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (content) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text("No internet connection"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text("OK"))
                                  ],
                                );
                              });
                        }
                      }
                    },
                    child: const Text(
                      "Get started",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
