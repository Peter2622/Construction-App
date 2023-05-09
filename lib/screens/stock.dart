import 'package:construction_app/components/text.dart';
import 'package:construction_app/components/textfield.dart';
import 'package:construction_app/services/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../components/colors.dart';
import '../model/allsitemodle.dart';
import '../model/stockmodel.dart';
import '../services/sharedpreference.dart';
import 'package:intl/intl.dart';


class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  late Future<List<StockModel>> stockDetails;
    TextEditingController _dateController = TextEditingController();
   
  DateTime? _selectedDate;
    final stocInKey = GlobalKey<FormState>();
    final stocOutKey = GlobalKey<FormState>();
  Future<List<StockModel>> getStockDetails() async {
    Token token = Token();
    String btoken = await token.getToken();
    print("http://89.116.231.138:8085/stocks");
    var stockResponse = await http.get(
      Uri.parse("http://89.116.231.138:8085/stocks"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,Authorization,Access-Control-Allow-Headers,X-Requested-With",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Authorization": "Bearer $btoken",
      },
    );
    print('stock list');
    final stockList = stockModelFromJson(stockResponse.body);
    print("Stock Status code => ${stockResponse.statusCode}");
    return stockList;
  }

  @override
  void initState() {
    super.initState();

    stockDetails = getStockDetails();
     _dateController = TextEditingController();
  }

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
              Container(
                height: 500,
                child: FutureBuilder(
                  future: stockDetails,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                        height: 1000,
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title:
                                      Text(snapshot.data![index].materialName),
                                  trailing: Wrap(
                                    spacing: 40,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          bottomSheetIn(context);
                                          StockSingleton().stock =
                                              snapshot.data![index];
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                          StockSingleton().stock =
                                              snapshot.data![index];
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                      );
                    } else {
                      return const Center(
                        child: Text('Error Loading....'),
                      );
                    }
                  },
                ),
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
                        child: Form(
                          key: stocInKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormat().headerText(
                                  text:
                                      '${StockSingleton().stock!.materialName} In',
                                  colors: green),
                              const SizedBox(
                                height: 40,
                              ),
                              TextBox(
                                  width: 200,
                                  height: 50,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                     _selectDate(context);
                                      },
                                      child:
                                          const Icon(Icons.calendar_month_sharp)),
                                  controller: TextEditingController(),
                                  lableText: 'Date',
                                   validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextBox(
                                  width: 200,
                                  height: 50,
                                  controller: TextEditingController(),
                                  lableText: 'Qty',
                                   validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
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
                                    onPressed: () {
                                       if (stocInKey.currentState!.validate()) {}
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: white),
                                    )),
                              )
                            ],
                          ),
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
                        child: Form(
                          key: stocOutKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormat().headerText(
                                  text:
                                      '${StockSingleton().stock!.materialName}  Out',
                                  colors: red),
                              const SizedBox(
                                height: 40,
                              ),
                              TextBox(
                                  width: 200,
                                  height: 50,
                                  suffixIcon:
                                      InkWell(
                                        onTap: () {
                                          
                                        _selectDate(context);
                                        },
                                        child: const Icon(Icons.calendar_month_sharp)),
                                  controller: TextEditingController(),
                                  lableText: 'Date',  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                } else {
                                  return null;
                                }
                              },),
                              const SizedBox(
                                height: 50,
                              ),
                              TextBox(
                                  width: 200,
                                  height: 50,
                                  controller: TextEditingController(),
                                  lableText: 'Qty',  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                } else {
                                  return null;
                                }
                              },),
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
                                    onPressed: () {
                                       if (stocOutKey.currentState!.validate()) {}
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: white),
                                    )),
                              )
                            ],
                          ),
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

   void _selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  if (pickedDate != null) {
    setState(() {
      _selectedDate = pickedDate;
      _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }
}

}



