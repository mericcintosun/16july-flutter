import 'dart:convert';
import 'package:apis/models/user.dart';
import 'package:flutter/material.dart';

class LocalApi extends StatefulWidget {
  const LocalApi({super.key});

  @override
  State<LocalApi> createState() => _LocalApiState();
}

class _LocalApiState extends State<LocalApi> {
  late Future<List<User>> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = jsonRead(); 
  }

  Future<List<User>> jsonRead() async {
    try {
      String readString =
          await DefaultAssetBundle.of(context).loadString("data/users.json");

      var jsonObject = jsonDecode(readString);
      List<User> allUsers = (jsonObject as List)
          .map((userMap) => User.fromJson(userMap))
          .toList();
      return allUsers;
    } catch (e) {
      throw Exception("Veri okunamadı: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local API's"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: userFuture, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> userList = snapshot.data!;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  User user = userList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      child: Text(user.username[0]),
                    ),
                    title: Text(user.username),
                    subtitle: Text(user.lastName),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Hata: ${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
