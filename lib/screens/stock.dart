import 'package:construction_app/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/colors.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormat().headerText(
            text: 'Stock',
            colors: white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
               TextFormat().headerText(text: 'All Materials', colors: primaryColor),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                      itemCount: materials.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(" ${materials[index]}"),
                            trailing: Wrap(
                              spacing: 40, 
                              children:  [
    
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(color: green)),
                                  child: Center(child: Text('In', style: TextStyle(color: green, ),)),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(color: red)),
                                  child: Center(child: Text('Out',style: TextStyle(color: red, ))),
                                )
                                // Icon(Icons.inbox), 
                                // Icon(Icons.outbond),
                              ],
                            ));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> materials = ['Cememt', 'Steel', 'brick', 'Sand', 'M-Sand'];
