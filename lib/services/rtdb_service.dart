import 'package:firebase_database/firebase_database.dart';
import 'package:firenoteapp/models/post_model.dart';

class RTDBService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();
  static const String apiPost = "posts";

  static Future<Stream<DatabaseEvent>> storePost(Post post) async {
    _database.child(apiPost).push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> loadPost(String id) async {
    List<Post> items= [];
    Query query = _database.child(apiPost).orderByChild("userId").equalTo(id);
    DatabaseEvent response = await query.once();
    print("response: ${response.toString()}");
    items = response.snapshot.children.map((json) => Post.fromJson(Map<String, dynamic>.from(json.value as Map))).toList();
    return items;
  }

  // static Future<bool> updatePost(Post post) {}
  //
  // static Future<bool> deletePost(Post post) {}
}