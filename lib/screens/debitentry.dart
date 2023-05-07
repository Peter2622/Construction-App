import 'package:construction_app/components/colors.dart';
import 'package:construction_app/components/text.dart';
import 'package:construction_app/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DebitEntry extends StatefulWidget {
  const DebitEntry({super.key});

  @override
  State<DebitEntry> createState() => _DebitEntryState();
}

class _DebitEntryState extends State<DebitEntry> {
  int _selectedContainer = 0;
  String dropdownValue = type.first;
  bool checkBox = false;
  String tDropdown = transactorType.first;
  void _onContainerTap(int index) {
    setState(() {
      _selectedContainer = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        title: const Text(
                          'Site Name ',
                          style: TextStyle(fontSize: 22),
                        ),
                        subtitle: const Text('username'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 23,
                              width: 23,
                              child: SvgPicture.asset('images/backsite.svg'),
                            ),
                            const SizedBox(width: 30),
                            SizedBox(
                              height: 23,
                              width: 23,
                              child: SvgPicture.asset('images/logout.svg'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Expanded(
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
                                    bottomSheet(context);
                                  },
                                  icon: SvgPicture.asset(
                                    'images/transactor.svg',
                                    color: primaryColor,
                                  )),
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
                                lableText: 'Amount'),
                            const SizedBox(
                              height: 30,
                            ),
                            TextBox(
                                maxLines: 50,
                                width: 300,
                                height: 100,
                                controller: TextEditingController(),
                                lableText: 'Description')
                          ],
                        ),
                      )
                    : _selectedContainer == 1
                        ? Padding(
                            padding: const EdgeInsets.only(left: 20),
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
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: DropdownButton(
                                    hint: Text("Type"),
                                    value: dropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: type.map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                        bottomSheet(context);
                                      },
                                      icon: SvgPicture.asset(
                                        'images/transactor.svg',
                                        color: primaryColor,
                                      )),
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
                                    lableText: 'Amount'),
                                const SizedBox(
                                  height: 10,
                                ),
                                CheckboxListTile(
                                  title: const Text("Adjustment in Advance"),
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
                                      lableText: 'Advance Amount'),
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
                                    lableText: 'Salary'),
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
                                    width: 300,
                                    height: 100,
                                    controller: TextEditingController(),
                                    lableText: 'Description')
                              ],
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
                                            bottomSheet(context);
                                          },
                                          icon: SvgPicture.asset(
                                            'images/transactor.svg',
                                            color: primaryColor,
                                          )),
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
                                        lableText: 'Amount'),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextBox(
                                        maxLines: 50,
                                        width: 300,
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
                                                bottomSheet(context);
                                              },
                                              icon: SvgPicture.asset(
                                                'images/transactor.svg',
                                                color: primaryColor,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextBox(
                                            keyboardType: TextInputType.number,
                                            width: 200,
                                            height: 50,
                                            prefixIcon: const Icon(
                                                Icons.currency_rupee),
                                            controller: TextEditingController(),
                                            lableText: 'Amount'),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        TextBox(
                                            maxLines: 50,
                                            width: 300,
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
      ),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 500,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormat().headerText(
                          text: 'Transactor Type', colors: primaryColor),
                      DropdownButton(
                        hint: Text("Vendor Type"),
                        value: tDropdown,
                        onChanged: (String? newValue) {
                          setState(() {
                            tDropdown = newValue!;
                          });
                        },
                        items: transactorType
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
                      suffixIcon: Icon(Icons.search),
                      controller: TextEditingController(),
                      lableText: 'Search transactor'),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Expanded(
                //   child: ListView.builder(
                //       itemCount: transactor.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return ListTile(title: Text(" ${transactor[index]}"));
                //       }),
                // ),
              ],
            ),
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

List<String> type = ['Salary', 'Beta'];
List<String> transactorType = ['Worker', 'MD', 'Vendor'];

List<String> transactor = [
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name',
  'name'
];
