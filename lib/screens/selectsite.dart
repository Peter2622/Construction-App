import 'package:construction_app/components/text.dart';
import 'package:construction_app/config/appurl.dart';
import 'package:flutter/material.dart';

import '../model/allsitemodle.dart';
import 'package:http/http.dart' as http;

class SelectSite extends StatefulWidget {
  const SelectSite({super.key});

  @override
  State<SelectSite> createState() => _SelectSiteState();
}

class _SelectSiteState extends State<SelectSite> {
  late Future<AllsiteModle> allSites;

  Future<AllsiteModle> allSiteDetails() async {
    var allSiteResponse = await http.get(
      Uri.parse(AppUrl.siteUrl),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,Authorization,Access-Control-Allow-Headers,X-Requested-With",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Authorization": "Bearer ",
      },
    );
    final siteList = allsiteModleFromJson(allSiteResponse.body);
    print(allSiteResponse.statusCode);
    return allSites;
  }

  @override
  void initState() {
    super.initState();
    allSites = allSiteDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: allSites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == 200) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Login User Name',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Site Name'),
                      ],
                    ),
                    toolbarHeight: 120,
                    actions: <Widget>[
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.logout))
                    ]),
                body: Column(
                  children: [
                    ListTile(title: TextFormat().headerText(text: 'All Sites')),
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
                    Expanded(
                      child: ListView.builder(
                          itemCount: siteNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Text(" ${siteNames[index]}"));
                          }),
                    ),
                  ],
                )),
          );
        } else {
          return const Center(
            child: Text('Error loading'),
          );
        }
      },
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
