import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/widgets/notes_display.dart';
import '../providers/user_provider.dart';

class NotehubScreen extends StatefulWidget {
  static const String routeName = '/notehub';
  const NotehubScreen({Key? key}) : super(key: key);

  @override
  State<NotehubScreen> createState() => _NotehubScreenState();
}

class _NotehubScreenState extends State<NotehubScreen> {
  List<String> category = ["CS", "math", "physics"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      retrieveUserInfo();
    });
  }

  Future<void> retrieveUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.currentUser != null) {
      final userInfo = await userProvider.getUserInfo();
      if (userInfo != null) {
        category = List<String>.from(userInfo.category);
        //for (var element in userInfo.category) {category.add(element.toString());}
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.0),
              itemCount: category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Stack(alignment: Alignment.center, children: [
                      Icon(
                        Icons.folder,
                        size: 120,
                        color: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotesDisplay(
                                      category: category[index],
                                    )));
                          },
                          child: Text(
                            category[index],
                            style: TextStyle(color: Colors.black),
                          )),
                    ]),
                  ),
                );
              })),
    );
  }
}
