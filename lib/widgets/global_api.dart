import 'package:apis/models/global_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GlobalApi extends StatefulWidget {
  const GlobalApi({super.key});

  @override
  State<GlobalApi> createState() => _GlobalApiState();
}

class _GlobalApiState extends State<GlobalApi> {
  late Future<List<User>> userList;
  @override
  void initState() {
    super.initState();
    userList = getUserList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global API's"),
        backgroundColor: Color(0xff11585c),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: userList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.id.toString())),
                    title: Text(user.name),
                    subtitle: Text("${user.email} • ${user.address.city}"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List<User>> getUserList() async {
    try {
      var response = await Dio().get(
        "https://jsonplaceholder.typicode.com/users",
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((userMap) => User.fromJson(userMap))
            .toList();
      } else {
        throw Exception("Veri alınamadı. Kod: ${response.statusCode}");
      }
    } catch (e) {
      return Future.error("Hata oluştu: $e");
    }
  }
}
