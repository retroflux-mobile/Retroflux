import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/user_provider.dart';
import 'package:retroflux/style_guide.dart';

TextStyle tempStyle =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var infoBarMap = {
    'Posts': 10,
    'Tasks': 3,
    'Quizzes': 5,
  };

  var infoMap = {
    'Name': 'name',
    'avatar': "",
    'Username': 'username',
    'Pronouns': 'pronouns',
    'Website': 'website',
    'Bio': 'bio',
    'Email': 'email@gmail.com'
  };

  final settingsRoutes = {
    'Notifications': 'NotificationsSettingPage',
    'Security': 'SecuritySettingPage',
    'Dark mode': 'DarkModeSettingPage',
    'Language': 'LanguageSettingPage',
  };

  final fakeStat = {
    'total notes': 128,
    'reviewd today': 5,
    'reviewd this week': 14,
    'most viewed topic': "Philosphy",
    'most viewed note': "Meaning of Existence"
  };

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
        setState(() {
          // TODO: Kai, please map the userInfo to the infoMap as you need
          print(userInfo.name);
          infoMap['Name'] = userInfo.name;
          infoMap['avatar'] = userInfo.avatar;
          // infoMap['Username'] = userInfo.username;
          // infoMap['Pronouns'] = userInfo.pronouns;
          // infoMap['Website'] = userInfo.website;
          // infoMap['Bio'] = userInfo.bio;
          infoMap['Email'] = userInfo.email;
        });
      }
    }
  }

  String avatar =
      "https://avatars.dicebear.com/api/adventurer-neutral/random.png";
  @override
  Widget build(BuildContext context) {
    // if (infoMap["avatar"] != null) {
    //   avatar = infoMap["avatar"].toString();
    // }
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.2 * MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 3,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Stack(children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(avatar),
                        radius: 50,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_circle_outlined,
                              color: Colors.orange,
                              size: 40,
                            )))
                  ]),
                ),
                const SizedBox(height: 0),
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1))),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var key in infoBarMap.keys)
                      Column(
                        children: [
                          Text(
                            infoBarMap[key].toString(),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                          Text(key,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey)),
                        ],
                      )
                  ],
                )),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15), // Creates border
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black45,
                    tabs: const [
                      Tab(child: Text('Info')),
                      Tab(child: Text('Stats')),
                      Tab(child: Text('Settings')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: TabBarView(
                        children: [
                          UserInfoPanel(infoMap: infoMap),
                          StatTab(fakeStat: fakeStat,),
                          SettingsTab(settingsRoutes: settingsRoutes)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({
    Key? key,
    required this.settingsRoutes,
  }) : super(key: key);

  final Map<String, String> settingsRoutes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: settingsRoutes.length,
      itemBuilder: (BuildContext context, int index) {
        String key = settingsRoutes.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key,
                  style: tempStyle,
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserInfoPanel extends StatelessWidget {
  const UserInfoPanel({
    Key? key,
    required this.infoMap,
  }) : super(key: key);

  final Map<String, String> infoMap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var key in infoMap.keys)
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key,
                    //style: tempStyle,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        infoMap[key] == null ? 'None' : infoMap[key]!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                      )
                    ]),
                child: const Center(child: Text('Edit'))),
          ),
        )
      ],
    );
  }
}



class StatTab extends StatelessWidget {
  const StatTab({
    Key? key, this.fakeStat,
  }) : super(key: key);

  final fakeStat;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Image.asset("assets/sample_chart.png"),
        ),
        for (var key in fakeStat.keys)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: Text(
                key,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Text(
                fakeStat[key].toString(),
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}