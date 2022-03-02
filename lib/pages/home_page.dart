import 'package:firenoteapp/main.dart';
import 'package:firenoteapp/models/post_model.dart';
import 'package:firenoteapp/pages/detail_page.dart';
import 'package:firenoteapp/services/auth_service.dart';
import 'package:firenoteapp/services/db_service.dart';
import 'package:firenoteapp/services/rtdb_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{
  late String userId;
  List<Post> list = [];

  void apiLoadPost() async {
    String? uid = DBService.loadString(StorageKeys.UID);
    RTDBService.loadPost(uid!).then((value) {
      _getList(value);
    });
  }

  void _getList(List<Post> post) {
    setState(() {
      list = post;
    });
  }




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiLoadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signOutUser(context);
              },
              icon: const Icon(Icons.replay)),
          const SizedBox(width: 10),
          IconButton(onPressed: () {
            AuthService.signOutUser(context);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                // onTap: (){
                //   Navigator.pushNamed(context, DetailPage.id);
                // },
                textColor: Colors.white,
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(list[index].imgUrl)
                ),
                title: Text(list[index].firstname),
                subtitle: Text(list[index].content),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, DetailPage.id);
        },
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
