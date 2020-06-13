import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/home/widgets/board_dialog.dart';
import 'package:pixeltasks/home/widgets/board_tile.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/user.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserController _userController;

  @override
  void initState() {
    _userController = UserController.to;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("Boards de ${_userController.user.name}"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: InkWell(
              child: Icon(Icons.exit_to_app,size: 30),
              onTap: _logOut,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        child: IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () => Get.toNamed('/board/add'),
        ),
        backgroundColor: green,
        onPressed: () {},
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          if (controller.user.boards == null ||
              controller.user.boards.length < 1) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.close, color: Colors.red, size: 70),
                    const Text("Você ainda não possui nenhum board criado",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.user.boards.length,
            itemBuilder: (context, index) {              
              return BoardTile(
                  onTap: ()=> Get.toNamed('/board',arguments:index),
                  board: _userController.user.boards[index],
                  button: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    iconSize: 30,
                    onPressed: () {
                      Get.dialog(BoardDialog(board: controller.user.boards[index], index: index,));
                    },
                  ));
            },
          );
        },
      ),
    );
  }

  void _logOut(){
    Get.offNamedUntil('/login', ModalRoute.withName('/login'));
    UserController.to.user = User();
  }
}
