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
  List<String> category = [];

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
      decoration: BoxDecoration(
        color: Colors.black87
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,30,0,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.file_copy,size: 40,color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(" NoteHub",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,

              ),
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
                          const Icon(
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
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
