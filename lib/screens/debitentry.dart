import 'package:construction_app/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DebitEntry extends StatefulWidget {
  const DebitEntry({super.key});

  @override
  State<DebitEntry> createState() => _DebitEntryState();
}

class _DebitEntryState extends State<DebitEntry> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          
          onPressed: () {},
          child:  Icon(
            Icons.save,
            color: white,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: 350,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: ListTile(
                  title:  Text(
                    'Site Name',
                    style: TextStyle(fontSize: 25, color: black),
                  ),
                  subtitle: const Text('Login User'),
                  trailing: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: SvgPicture.asset('images/logout.svg')),
                          const SizedBox(width: 20,),
                           IconButton(
                          onPressed: () {}, icon: SvgPicture.asset('images/backsite.svg')),
                    ],
                  ), 
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      print('Expense ontap');
                    },
                    child: Container(
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 33,
                                width: 33,
                                child: SvgPicture.asset('images/expense.svg')),
                            const SizedBox(
                              width: 15,
                            ),
                             Text('Expenses',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Salary / beta onTap');
                    },
                    child: Container(
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 33,
                                width: 33,
                                child: SvgPicture.asset('images/salary.svg')),
                            const SizedBox(
                              width: 15,
                            ),
                             Text('Salary / Beta',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      print('Advance onTap');
                    },
                    child: Container(
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 33,
                                width: 33,
                                child: SvgPicture.asset('images/advance.svg')),
                            const SizedBox(
                              width: 15,
                            ),
                             Text('Advance',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Material Purchase ontap');
                    },
                    child: Container(
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 33,
                                width: 33,
                                child: SvgPicture.asset(
                                    'images/materialpurchase.svg')),
                            const SizedBox(
                              width: 15,
                            ),
                             Text('Material \n Purchase',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

