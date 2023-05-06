import 'package:construction_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/colors.dart';
import '../components/text.dart';

class WorkLog extends StatefulWidget {
  const WorkLog({super.key});

  @override
  State<WorkLog> createState() => _WorkLogState();
}

class _WorkLogState extends State<WorkLog> {
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

  String dropdownValue = vendorType.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextFormat().headerText(
            text: 'Work Log',
            colors: white,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const SizedBox(
                  height: 30,
                ),
                TextBox(
                  lableText: 'Date',
                  suffixIcon: Icon(Icons.calendar_month_rounded),
                  width: 200,
                  height: 50,
                  controller: TextEditingController(),
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
                          TextFormat()
                              .headerText(text: 'Labor', colors: primaryColor),
                          const SizedBox(
                            height: 30,
                          ),
                          TextBox(
                            lableText: 'Work Type',
                            width: 200,
                            height: 50,
                            controller: workType,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextBox(
                              lableText: 'Count',
                              width: 200,
                              height: 50,
                              controller: count),
                          const SizedBox(
                            height: 30,
                          ),
                          TextBox(
                            lableText: 'OD Amount',
                            prefixIcon: Icon(Icons.currency_rupee),
                            width: 200,
                            height: 50,
                            controller: odAmount,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextBox(
                            lableText: 'Total Amount',
                            prefixIcon: Icon(Icons.currency_rupee),
                            width: 200,
                            height: 50,
                            controller: totalAmount,
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
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextBox(
                                controller: runningVehicleNumber,
                                lableText: 'Vehicle Number',
                                width: 200,
                                height: 50,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextBox(
                                      suffixIcon: Icon(
                                        Icons.timer,
                                        color: primaryColor,
                                      ),
                                      width: 150,
                                      height: 50,
                                      controller: rstartTime,
                                      lableText: 'Start Time'),
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
                                      controller: rendTime,
                                      lableText: 'End Time')
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
                                width: 200,
                                height: 100,
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
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextBox(
                                    controller: loadingVehicleNumber,
                                    lableText: 'Vehicle Number',
                                    width: 200,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextBox(
                                          suffixIcon: Icon(
                                            Icons.timer,
                                            color: primaryColor,
                                          ),
                                          width: 150,
                                          height: 50,
                                          controller: lstartTime,
                                          lableText: 'Start Time'),
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
                                          lableText: 'End Time')
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
                                    width: 200,
                                    height: 100,
                                  ),
                                ],
                              )
                            : SizedBox()
              ])),
        ),
      ),
    );
  }
}

List<String> vendorType = [
  'Labor',
  'Running Vehicle',
  'Loading Vehicle',
];
