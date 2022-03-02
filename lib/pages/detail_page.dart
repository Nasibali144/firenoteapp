import 'package:firenoteapp/models/post_model.dart';
import 'package:firenoteapp/pages/home_page.dart';
import 'package:firenoteapp/services/db_service.dart';
import 'package:firenoteapp/services/rtdb_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const String id = "detail_page";
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();

  void _savePostDatabase() async {
    String title = controllerTitle.text.trim().toString();
    String content = controllerContent.text.trim().toString();
    if(title.isEmpty || content.isEmpty) {
      //error msg
      return;
    }
    String? userId = DBService.loadString(StorageKeys.UID);
    String? firstname = DBService.loadString(StorageKeys.FIRSTNAME);
    String? lastname = DBService.loadString(StorageKeys.LASTNAME);

    Post post = Post(userId!, firstname!, lastname!, content, DateTime.now().toString(), "assets/images/img.png");
    RTDBService.storePost(post).then((value) {
      if(value != null) {
        _goHomePage();
      } else {
        // error msg
      }
    });
  }

  _goHomePage() {
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
            child: Column(
              children: [
                // #image
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, blurRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset("assets/images/img.png", fit: BoxFit.cover,),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // #title
                _textField(text: "Title", controller: controllerTitle),
                const SizedBox(height: 20),

                // #content
                _textField(text: "Content", controller: controllerContent),
                const SizedBox(height: 10),

                // #add_button
                MaterialButton(
                  height: 50,
                  onPressed: _savePostDatabase,
                  child: const Text("Add"),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  minWidth: double.infinity,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          isLoading
              ? const LinearProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.amber,
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  TextField _textField({text, controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
