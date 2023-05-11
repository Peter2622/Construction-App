import 'dart:convert';

import 'package:construction_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../components/colors.dart';
import '../components/text.dart';
import '../services/sharedpreference.dart';

class WorkLog extends StatefulWidget {
  const WorkLog({super.key});

  @override
  State<WorkLog> createState() => _WorkLogState();
}

class _WorkLogState extends State<WorkLog> {
  final worklogKey = GlobalKey<FormState>();
  //Labour Controllers
  TextEditingController workType = TextEditingController();
  TextEditingController count = TextEditingController();
  TextEditingController wages = TextEditingController();
  TextEditingController odAmount = TextEditingController();
  TextEditingController totalAmount = TextEditingController();

  //Running vehicle controller
  TextEditingController runningVehicleType = TextEditingController();
  TextEditingController runningVehicleNumber = TextEditingController();
  TextEditingController rstartTime = TextEditingController();
  TextEditingController rendTime = TextEditingController();
  TextEditingController ramount = TextEditingController();
  TextEditingController rbeta = TextEditingController();
  TextEditingController rtotal = TextEditingController();
  TextEditingController rdescription = TextEditingController();

  //Loading vehicle controller
  TextEditingController loadingVehicleType = TextEditingController();
  TextEditingController loadingVehicleNumber = TextEditingController();
  TextEditingController lstartTime = TextEditingController();
  TextEditingController lendTime = TextEditingController();
  TextEditingController lamount = TextEditingController();
  TextEditingController lbeta = TextEditingController();
  TextEditingController ltotal = TextEditingController();
  TextEditingController ldescription = TextEditingController();
  TextEditingController currentDate = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  String dropdownValue = vendorType.first;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  workLogPost() async {
    var jsonData = {
      
        "createdBy": "string",
        "createdDateTime": "2023-05-11T06:41:06.935Z",
        "id": "string",
        "progressDate": currentDate.text,
        "siteId": "string",
        "siteName": "string",
        "vendorId": "string",
        "vendorName": "string",
        "vendorType": vendorType == 0
            ? 'Labor'
            : vendorType == 1
                ? "Running Vehicle"
                : vendorType == 2
                    ? "Loading Vehicle"
                    : "",
        "wagesAttribute": {}
      
    };
    print(jsonData);

    var encodedJson = jsonEncode(jsonData);
    Token token = Token();
    String btoken = await token.getToken();
    print('userlist $btoken');
    var jsonRequest = await http.post(
      Uri.parse("http://89.116.231.138:8085//workProgress"),
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

    print("worklog post => ${jsonRequest.statusCode}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextFormat().headerText(
            text: 'Work Log',
            colors: white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SingleChildScrollView(
              child: Form(
            key: worklogKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextBox(
                    suffixIcon: InkWell(
                        onTap: () {
                          _showDatePicker(context, currentDate);
                        },
                        child: const Icon(Icons.calendar_month_rounded)),
                    width: 200,
                    height: 50,
                    controller: currentDate,
                    lableText: 'Date',
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton(
                      hint: Text("Vendor Type"),
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: vendorType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "    $value",
                            // style: TextStyle(fontSize: 22),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  dropdownValue == 'Labor'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormat().headerText(
                                text: 'Labor', colors: primaryColor),
                            const SizedBox(
                              height: 30,
                            ),
                            TextBox(
                              lableText: 'Work Type',
                              width: 200,
                              height: 50,
                              controller: workType,
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
                              lableText: 'Count',
                              width: 200,
                              height: 50,
                              controller: count,
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
                              lableText: 'OD Amount',
                              prefixIcon: const Icon(Icons.currency_rupee),
                              width: 200,
                              height: 50,
                              controller: odAmount,
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
                              lableText: 'Total Amount',
                              prefixIcon: const Icon(Icons.currency_rupee),
                              width: 200,
                              height: 50,
                              controller: totalAmount,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ) //Running Vehicle >>>>>>>!
                      : dropdownValue == 'Running Vehicle'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormat().headerText(
                                    text: 'Running Vehicle',
                                    colors: primaryColor),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: runningVehicleType,
                                  lableText: 'Vehicle Type',
                                  width: 200,
                                  height: 50,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: runningVehicleNumber,
                                  lableText: 'Vehicle Number',
                                  width: 200,
                                  height: 50,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextBox(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        child: Icon(
                                          Icons.timer,
                                          color: primaryColor,
                                        ),
                                      ),
                                      width: 150,
                                      height: 50,
                                      controller: startTime,
                                      lableText:
                                          '${_selectedTime.hour}:${_selectedTime.minute}',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TextBox(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        child: Icon(
                                          Icons.timer,
                                          color: primaryColor,
                                        ),
                                      ),
                                      width: 150,
                                      height: 50,
                                      controller: endTime,
                                      lableText:
                                          '${_selectedTime.hour}:${_selectedTime.minute}',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: ramount,
                                  lableText: 'Amount',
                                  width: 200,
                                  height: 50,
                                  prefixIcon: const Icon(Icons.currency_rupee),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: rbeta,
                                  lableText: 'Beta Amount',
                                  width: 200,
                                  height: 50,
                                  prefixIcon: const Icon(Icons.currency_rupee),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: rtotal,
                                  lableText: 'Total Amount',
                                  width: 200,
                                  height: 50,
                                  prefixIcon: const Icon(Icons.currency_rupee),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextBox(
                                  controller: rdescription,
                                  lableText: 'Description',
                                  width: 300,
                                  height: 100,
                                  maxLines: 20,
                                ),
                              ],
                            ) //Loading Vehicle >>>>>>>!
                          : dropdownValue == 'Loading Vehicle'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormat().headerText(
                                        text: 'Loading Vehicle',
                                        colors: primaryColor),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: loadingVehicleType,
                                      lableText: 'Vehicle Type',
                                      width: 200,
                                      height: 50,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: loadingVehicleNumber,
                                      lableText: 'Vehicle Number',
                                      width: 200,
                                      height: 50,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextBox(
                                          suffixIcon: Icon(
                                            Icons.timer,
                                            color: primaryColor,
                                          ),
                                          width: 150,
                                          height: 50,
                                          controller: lstartTime,
                                          lableText: 'Start Time',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextBox(
                                          suffixIcon: Icon(
                                            Icons.timer,
                                            color: primaryColor,
                                          ),
                                          width: 150,
                                          height: 50,
                                          controller: lendTime,
                                          lableText: 'End Time',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: lamount,
                                      lableText: 'Amount',
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: lbeta,
                                      lableText: 'Beta Amount',
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: ltotal,
                                      lableText: 'Total Amount',
                                      width: 200,
                                      height: 50,
                                      prefixIcon:
                                          const Icon(Icons.currency_rupee),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextBox(
                                      controller: ldescription,
                                      lableText: 'Description',
                                      width: 300,
                                      height: 100,
                                      maxLines: 20,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                ]),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (worklogKey.currentState!.validate()) {}
            workLogPost();
          },
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(
      BuildContext context, TextEditingController date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      if (picked.isAfter(DateTime.now())) {
        currentDate.text = DateFormat("yyyy-MM-dd").format(picked);
      }

      print(DateFormat("dd-MM-yyyy").format(picked));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}

List<String> vendorType = [
  'Labor',
  'Running Vehicle',
  'Loading Vehicle',
];
