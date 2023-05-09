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

import '../model/accountModel.dart';
import '../services/sharedpreference.dart';

class DebitEntry extends StatefulWidget {
  const DebitEntry({super.key});

  @override
  State<DebitEntry> createState() => _DebitEntryState();
}

class _DebitEntryState extends State<DebitEntry> {
  final debitKey = GlobalKey<FormState>();
  final TextEditingController expenseTransactor = TextEditingController();
  final TextEditingController expenseAmount = TextEditingController();

  final TextEditingController salaryTransactor = TextEditingController();
  final TextEditingController salaryAmount = TextEditingController();
  final TextEditingController salaryAdvance = TextEditingController();
  final TextEditingController salary = TextEditingController();

  final TextEditingController advanceTransactor = TextEditingController();
  final TextEditingController advanceAmount = TextEditingController();

  final TextEditingController materialTransactor = TextEditingController();
  final TextEditingController materialAmount = TextEditingController();
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
    var jsonData = {
      {
        "accountType": "Advance",
        "actualAmount": 0,
        "adjustmentAmount": 0,
        "advanceAdjustment": true,
        "description": "string",
        "paidAmount": 0,
        "siteId": "string",
        "siteName": "string",
        "transactionDate": "2023-05-09",
        "transactionType": "CREDIT",
        "transactorId": "string",
        "transactorName": "string",
        "transactorType": "MD"
      }
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

  late Future<List<AccountModel>> accountDetails;

  Future<List<AccountModel>> getAccountDetails(String transactorType) async {
    Token token = Token();
    String btoken = await token.getToken();
    print("http://89.116.231.138:8085/accounts?transactorType=$transactorType");
    var accountResponse = await http.get(
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
    print('get account');
    final accountList = accountModelFromJson(accountResponse.body);
    print(accountResponse.statusCode);
    return accountList;
  }

  @override
  void initState() {
    super.initState();
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
                              controller: TextEditingController(),
                              lableText: 'Transactor Type',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      accountDetails =
                                          getAccountDetails('WORKER');
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
                              controller: TextEditingController(),
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
                                controller: TextEditingController(),
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
                                      controller: TextEditingController(),
                                      lableText: 'Transactor Type',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              accountDetails =
                                                  getAccountDetails('WORKER');
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
                                      controller: TextEditingController(),
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
                                        controller: TextEditingController(),
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
                                      controller: TextEditingController(),
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
                                        controller: TextEditingController(),
                                        lableText: 'Balance to Pay'),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                        maxLines: 50,
                                        width: 250,
                                        height: 100,
                                        controller: TextEditingController(),
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
                                      controller: TextEditingController(),
                                      lableText: 'Transactor Type',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              accountDetails =
                                                  getAccountDetails('WORKER');
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
                                      controller: TextEditingController(),
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
                                        controller: TextEditingController(),
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
                                          controller: TextEditingController(),
                                          lableText: 'Transactor Type',
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  accountDetails =
                                                      getAccountDetails(
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
                                          controller: TextEditingController(),
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
                                            controller: TextEditingController(),
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
            if (debitKey.currentState!.validate()) {}
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
              future: accountDetails,
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
                                    accountDetails =
                                        getAccountDetails(currentlySelected);
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
                              return ListTile(
                                  title: Text(
                                      snapshot.data![index].transactorName));
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
