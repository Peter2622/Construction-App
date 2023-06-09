import 'package:construction_app/components/text.dart';
import 'package:construction_app/services/singleton.dart';

import 'package:flutter/material.dart';

import '../model/allsitemodle.dart';
import 'package:http/http.dart' as http;

import '../services/sharedpreference.dart';

class SelectSite extends StatefulWidget {
  const SelectSite({super.key});

  @override
  State<SelectSite> createState() => _SelectSiteState();
}

class _SelectSiteState extends State<SelectSite> {
  late Future<List<GetAllsiteModel>> siteListAll;

  Future<List<GetAllsiteModel>> getAllSites() async {
    Token token = Token();
    String btoken = await token.getToken();
    var siteResponse = await http.get(
      Uri.parse("http://89.116.231.138:8085/site"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,Authorization,Access-Control-Allow-Headers,X-Requested-With",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Authorization": "Bearer $btoken",
      },
    );
    print('select site');
    final siteList = getAllsiteModelFromJson(siteResponse.body);
    print(siteResponse.statusCode);
    return siteList;
  }

  String userName = '';
  String role = '';
  userProfile() async {
    var user = await UserDetails().getUsername();
    userName = user;
    var rol = await UserDetails().getUserRole();

    role = rol;

    print('username => $userName');
    print('Role => $role');
  }

  @override
  void initState() {
    userProfile();
    super.initState();

    print('init start');

    siteListAll = getAllSites();
    print('complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GetAllsiteModel>>(
        future: siteListAll,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('if statement');
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            print('else if statement');
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                      title: Container(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(role),
                          ],
                        ),
                      ),
                      toolbarHeight: 120,
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            icon: const Icon(Icons.logout))
                      ]),
                  body: Container(
                    height: 900,
                    child: Column(
                      children: [
                        ListTile(
                            title: TextFormat().headerText(text: 'All Sites')),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 400,
                          height: 56,
                          child: TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search)),
                                hintText: 'Search Site',
                                border: const OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 500,
                          child: ListView.builder(
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/homescreen');

                                    UserEntrySingleton().userEntry =
                                        snapshot.data![index];
                                  },
                                  child: ListTile(
                                      title:
                                          Text(snapshot.data![index].siteName)),
                                );
                              }),
                        ),
                      ],
                    ),
                  )),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Error loading....'),
              ),
            );
          }
        },
      ),
    );
  }
}

List siteNames = [
  'chennai',
  'kovilpatti',
  'covai',
  'mumbai',
  'usa',
  'dbcjds',
  'jcjhsavvc',
  'chennai',
  'kovilpatti',
  'covai',
  'chennai',
  'kovilpatti',
  'covai',
  'mumbai',
  'usa',
  'dbcjds',
  'jcjhsavvc',
  'chennai',
  'kovilpatti',
  'covai',
  'chennai',
  'kovilpatti',
  'covai',
  'mumbai',
  'usa',
  'dbcjds',
  'jcjhsavvc',
  'chennai',
  'kovilpatti',
  'covai',
  'chennai',
  'kovilpatti',
  'covai',
  'mumbai',
  'usa',
  'dbcjds',
  'jcjhsavvc',
  'chennai',
  'kovilpatti',
  'covai',
];
