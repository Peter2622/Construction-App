// import 'package:flutter/material.dart';

// bottomSheetAdd() {
//     showModalBottomSheet(
//       useSafeArea: true,
//       elevation: 10,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
//       context: context,
//       builder: (context) {
//         var size = MediaQuery.of(context).size;
//         return StatefulBuilder(
//           builder: (context, setState) => SizedBox(
//             width: size.width,
//             height: size.height / 1.5,
//             child: FutureBuilder(
//               future: customerListData,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                       child: CircularProgressIndicator(
//                     color: primaryColor,
//                   ));
//                 } else if (snapshot.hasData) {
//                   return Padding(
//                       padding: const EdgeInsets.only(left: 15, right: 15),
//                       child: userList == false
//                           ? customerList(size, snapshot, setState)
//                           : createUser(size));
//                 } else {
//                   return Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 5,
//                       height: MediaQuery.of(context).size.height / 5,
//                       alignment: Alignment.center,
//                       child: const Text("No Data!..."),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
