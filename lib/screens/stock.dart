import 'package:construction_app/components/text.dart';
import 'package:construction_app/components/textfield.dart';
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
              TextFormat()
                  .headerText(text: 'All Materials', colors: primaryColor),
              const SizedBox(
                height: 20,
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: materials.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(" ${materials[index]}"),
                          trailing: Wrap(
                            spacing: 40,
                            children: [
                              InkWell(
                                onTap: () {
                                  bottomSheetIn(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(color: green)),
                                  child: Center(
                                      child: Text(
                                    'In',
                                    style: TextStyle(
                                      color: green,
                                    ),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  bottomSheetOut(context);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(color: red)),
                                  child: Center(
                                      child: Text('Out',
                                          style: TextStyle(
                                            color: red,
                                          ))),
                                ),
                              )
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetIn(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 400,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormat().headerText(text: 'In', colors: green),
                            const SizedBox(
                              height: 40,
                            ),
                            TextBox(
                                width: 200,
                                height: 50,
                                suffixIcon:
                                    const Icon(Icons.calendar_month_sharp),
                                controller: TextEditingController(),
                                lableText: 'Date'),
                            const SizedBox(
                              height: 50,
                            ),
                            TextBox(
                                width: 200,
                                height: 50,
                                controller: TextEditingController(),
                                lableText: 'Qty'),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 350,
                              height: 50,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueGrey[800])),
                                  onPressed: () {},
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: white),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> bottomSheetOut(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 400,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormat().headerText(text: 'Out', colors: red),
                            const SizedBox(
                              height: 40,
                            ),
                            TextBox(
                                width: 200,
                                height: 50,
                                suffixIcon:
                                    const Icon(Icons.calendar_month_sharp),
                                controller: TextEditingController(),
                                lableText: 'Date'),
                            const SizedBox(
                              height: 50,
                            ),
                            TextBox(
                                width: 200,
                                height: 50,
                                controller: TextEditingController(),
                                lableText: 'Qty'),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 350,
                              height: 50,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueGrey[800])),
                                  onPressed: () {},
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: white),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }
}

List<String> materials = ['Cememt', 'Steel', 'brick', 'Sand', 'M-Sand'];
