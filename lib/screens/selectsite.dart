import 'package:construction_app/components/text.dart';
import 'package:flutter/material.dart';

class SelectSite extends StatelessWidget {
  const SelectSite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              IconButton(onPressed: () {}, icon: Icon(Icons.logout))
            ]),
        body: Column(
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
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    hintText: 'Search Site',
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: siteNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(" ${siteNames[index]}"));
                  }),
            ),
          ],
        ));
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
