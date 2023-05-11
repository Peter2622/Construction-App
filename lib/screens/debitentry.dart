import 'dart:convert';

import 'package:construction_app/components/colors.dart';
import 'package:construction_app/components/text.dart';
import 'package:construction_app/components/textfield.dart';
import 'package:construction_app/services/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/accountModel.dart';
import '../services/sharedpreference.dart';

class DebitEntry extends StatefulWidget {
  const DebitEntry({super.key});

  @override
  State<DebitEntry> createState() => _DebitEntryState();
}

class _DebitEntryState extends State<DebitEntry> {
  final debitKey = GlobalKey<FormState>();

  final TextEditingController debitAmount = TextEditingController();
  final TextEditingController description = TextEditingController();

  final TextEditingController betaAmount = TextEditingController();
  final TextEditingController salaryAdvance = TextEditingController();
  final TextEditingController salary = TextEditingController();

  final TextEditingController materialAmount = TextEditingController();

  final TextEditingController transactor = TextEditingController();
  final TextEditingController adjustmentAmount = TextEditingController();

  final TextEditingController balanceAmount = TextEditingController();
  int _selectedContainer = 0;

  bool checkBox = false;
  var currentlySelected;
  List transactorType = ["WORKER", "MD", "VENDOR", "OTHERS"];

  var expense;
  List expenseType = ['Salary', 'Beta'];
  void _onContainerTap(int index) {
    setState(() {
      _selectedContainer = index;
    });
  }

  debitEntryPost() async {
    print('Debit entry ');
    print('Selected Container => $_selectedContainer');
    String select = "";
    String amount = "";
    String type = '';
    

    int index = 0;

    if (index >= 0 && index < transactorType.length) {
      String selectedValue = transactorType[index];
      print("Selected value: $selectedValue");

      if (selectedValue == "WORKER") {
        type = 'WORKER';
      } else if (selectedValue == "MD") {
        type = 'MD';
      } else if (selectedValue == "VENDOR") {
        type = 'VENDOR';
      } else if (selectedValue == "OTHERS") {
        type = 'OTHERS';
      }
    }

    var jsonData = {
      "accountType": select,
      "actualAmount": 0,
      "adjustmentAmount": adjustmentAmount.text,
      "advanceAdjustment": checkBox == true ? true : false,
      "description": description.text,
      "paidAmount": debitAmount.text,
      "siteId": UserEntrySingleton().userEntry!.siteId.toString(),
      "siteName": UserEntrySingleton().userEntry!.siteName.toString(),
      "transactionDate": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "transactionType": "DEBIT",
      "transactorId": TransactorSingleton().transactor!.transactorId.toString(),
      "transactorName": transactor.text,
      "transactorType": type
    };
    print(jsonData);

    var encodedJson = jsonEncode(jsonData);
    Token token = Token();
    String btoken = await token.getToken();
    print('userlist $btoken');
    var jsonRequest = await http.post(
      Uri.parse("http://89.116.231.138:8085/accounts"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,Authorization,Access-Control-Allow-Headers,X-Requested-With",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Authorization": "Bearer $btoken",
      },
      body: encodedJson,
    );

    print("Debit Entry Post Status code=> ${jsonRequest.statusCode}");
  }

  late Future<List<AccountModel>> debitEntryGet;

  Future<List<AccountModel>> debitEntryDetails(String transactorType) async {
    Token token = Token();
    String btoken = await token.getToken();
    print("http://89.116.231.138:8085/accounts?transactorType=$transactorType");
    var debitResponse = await http.get(
      Uri.parse(
          "http://89.116.231.138:8085/accounts?transactorType=$transactorType"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,Authorization,Access-Control-Allow-Headers,X-Requested-With",
        "Access-Control-Allow-Methods": "POST,OPTIONS",
        "Authorization": "Bearer $btoken",
      },
    );
    print('debit entry');
    final debitEntry = accountModelFromJson(debitResponse.body);
    print(debitResponse.statusCode);
    return debitEntry;
  }

  @override
  void initState() {
    super.initState();
    debitEntryGet = debitEntryDetails('WORKER');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: debitKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: double.infinity,
                height: 400,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                      color: white,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text(
                          '${UserEntrySingleton().userEntry?.siteName}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle:
                            Text('${UserEntrySingleton().userEntry?.city}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 23,
                              width: 23,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/selectsite');
                                  },
                                  child:
                                      SvgPicture.asset('images/backsite.svg')),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              height: 23,
                              width: 23,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: SvgPicture.asset('images/logout.svg')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 27,
                            mainAxisSpacing: 27,
                            childAspectRatio: 160 / 90,
                          ),
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => _onContainerTap(index),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: index == _selectedContainer
                                        ? primaryColor
                                        : white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(0, 1))
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      svgIcons[index],
                                      color: _selectedContainer == index
                                          ? white
                                          : black,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      title[index],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: _selectedContainer == index
                                            ? white
                                            : black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                _selectedContainer == 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormat().headerText(
                                text: 'Expenses', colors: primaryColor),
                            const SizedBox(
                              height: 30,
                            ),
                            TextBox(
                              width: 200,
                              height: 50,
                              controller: transactor,
                              lableText: 'Transactor Type',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      debitEntryGet =
                                          debitEntryDetails('WORKER');
                                    });
                                    bottomSheet(context);
                                  },
                                  icon: SvgPicture.asset(
                                    'images/transactor.svg',
                                    color: primaryColor,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextBox(
                              keyboardType: TextInputType.number,
                              width: 200,
                              height: 50,
                              prefixIcon: const Icon(Icons.currency_rupee),
                              controller: debitAmount,
                              lableText: 'Amount',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextBox(
                                maxLines: 30,
                                width: 250,
                                height: 100,
                                controller: description,
                                lableText: 'Description')
                          ],
                        ),
                      )
                    : _selectedContainer == 1
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 345,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormat().headerText(
                                        text: 'Salary / Beta',
                                        colors: primaryColor),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: DropdownButton(
                                        iconSize: 25,
                                        hint: const Text(
                                          "Select Type",
                                        ),
                                        isExpanded: true,
                                        // focusColor: colorPrimary,
                                        items: List.generate(expenseType.length,
                                            (index) {
                                          return DropdownMenuItem(
                                            value: expenseType[index],
                                            child: Text(
                                                "   ${expenseType[index]}"
                                                    .toUpperCase(),
                                                style: GoogleFonts.urbanist(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: black)),
                                          );
                                        }),
                                        onChanged: (newvalue) {
                                          setState(() {
                                            expense = newvalue;
                                          });
                                        },
                                        value: expense,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                      width: 200,
                                      height: 50,
                                      controller: transactor,
                                      lableText: 'Transactor Type',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              debitEntryGet =
                                                  debitEntryDetails("WORKER");
                                            });
                                            bottomSheet(context);
                                          },
                                          icon: SvgPicture.asset(
                                            'images/transactor.svg',
                                            color: primaryColor,
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                      keyboardType: TextInputType.number,
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                      controller: debitAmount,
                                      lableText: 'Amount',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      title:
                                          const Text("Adjustment in Advance"),
                                      value: checkBox,
                                      onChanged: (Value) {
                                        setState(() {
                                          checkBox = Value!;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    if (checkBox)
                                      TextBox(
                                        keyboardType: TextInputType.number,
                                        width: 200,
                                        height: 50,
                                        prefixIcon:
                                            const Icon(Icons.currency_rupee),
                                        controller: adjustmentAmount,
                                        lableText: 'Advance Amount',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                      keyboardType: TextInputType.number,
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                      controller: debitAmount,
                                      lableText: 'Salary',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                        keyboardType: TextInputType.number,
                                        width: 200,
                                        height: 50,
                                        prefixIcon:
                                            const Icon(Icons.currency_rupee),
                                        controller: balanceAmount,
                                        lableText: 'Balance to Pay'),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                        maxLines: 50,
                                        width: 250,
                                        height: 100,
                                        controller: description,
                                        lableText: 'Description')
                                  ],
                                ),
                              ),
                            ),
                          )
                        : _selectedContainer == 2
                            ? Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormat().headerText(
                                        text: 'Advance', colors: primaryColor),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                      width: 200,
                                      height: 50,
                                      controller: transactor,
                                      lableText: 'Transactor Type',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              debitEntryGet =
                                                  debitEntryDetails('WORKER');
                                            });
                                            bottomSheet(context);
                                          },
                                          icon: SvgPicture.asset(
                                            'images/transactor.svg',
                                            color: primaryColor,
                                          )),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                      keyboardType: TextInputType.number,
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                      controller: debitAmount,
                                      lableText: 'Amount',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                        maxLines: 50,
                                        width: 250,
                                        height: 100,
                                        controller: description,
                                        lableText: 'Description')
                                  ],
                                ),
                              )
                            : _selectedContainer == 3
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormat().headerText(
                                            text: 'Material Purchase',
                                            colors: primaryColor),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextBox(
                                          width: 200,
                                          height: 50,
                                          controller: transactor,
                                          lableText: 'Transactor Type',
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  debitEntryGet =
                                                      debitEntryDetails(
                                                          'WORKER');
                                                });
                                                bottomSheet(context);
                                              },
                                              icon: SvgPicture.asset(
                                                'images/transactor.svg',
                                                color: primaryColor,
                                              )),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextBox(
                                          keyboardType: TextInputType.number,
                                          width: 200,
                                          height: 50,
                                          prefixIcon:
                                              const Icon(Icons.currency_rupee),
                                          controller: debitAmount,
                                          lableText: 'Amount',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextBox(
                                            maxLines: 50,
                                            width: 250,
                                            height: 100,
                                            controller: description,
                                            lableText: 'Description')
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
              ],
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.save,
            color: white,
          ),
          onPressed: () {
            print('Debit entry success');

            if (debitKey.currentState!.validate()) {
              debitEntryPost();
            }
          },
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
                child: FutureBuilder<List<AccountModel>>(
              future: debitEntryGet,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('account if statement');
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  print('account else if statement');
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormat().headerText(
                                text: 'Transactor Type', colors: primaryColor),
                            SizedBox(
                              width: 150,
                              height: 45,
                              child: DropdownButton(
                                iconSize: 25,
                                hint: const Text(
                                  "Select Type",
                                ),
                                isExpanded: true,
                                // focusColor: colorPrimary,
                                items: List.generate(transactorType.length,
                                    (index) {
                                  return DropdownMenuItem(
                                    value: transactorType[index],
                                    child: Text(
                                        "   ${transactorType[index]}"
                                            .toUpperCase(),
                                        style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: const Color.fromRGBO(
                                                33, 33, 33, 1))),
                                  );
                                }),
                                onChanged: (newvalue) {
                                  setState(() {
                                    currentlySelected = newvalue;
                                    print(currentlySelected);
                                    debitEntryGet =
                                        debitEntryDetails(currentlySelected);
                                  });
                                },
                                value: currentlySelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextBox(
                            width: 400,
                            height: 50,
                            suffixIcon: const Icon(Icons.search),
                            controller: TextEditingController(),
                            lableText: 'Search transactor'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 300,
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: ListTile(
                                    onTap: () {
                                      setState(
                                        () {
                                          transactor.text = snapshot
                                              .data![index].transactorName;

                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    title: Text(
                                        snapshot.data![index].transactorName)),
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Error Loading'),
                  );
                }
              },
            )),
          );
        });
  }
}

List<String> svgIcons = [
  'images/expense.svg',
  'images/salary.svg',
  'images/advance.svg',
  'images/stock.svg'
];

List<String> title = [
  'Expenses',
  'Salary / Beta',
  'Advance',
  'Material \n Purchase'
];

// List<String> type = ['Salary', 'Beta'];
// List<String> transactorType = ['Worker', 'MD', 'Vendor'];

// List<String> transactor = [
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name',
//   'name'
// ];
