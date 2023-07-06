// import 'package:flutter/material.dart';
// class User {
//   String ?name;
//   String ?email;
//
//   User({this.name, this.email});
// }
//
// class Episode5 extends StatefulWidget {
//   @override
//   _Episode5State createState() => _Episode5State();
// }
//
// class _Episode5State extends State<Episode5> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//
//   final form = GlobalKey<FormState>();
//   static var _focusNode = new FocusNode();
//   bool update = false;
//
//   User user = User();
//
//   List<User> userList = [
//     User(name: "a", email: "a"),
//     User(name: "d", email: "b"),
//     User(name: "c", email: "c"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Widget bodyData() => DataTable(
//       onSelectAll: (b) {},
//       sortColumnIndex: 0,
//       sortAscending: true,
//       columns: <DataColumn>[
//         DataColumn(label: Text("Name"), tooltip: "To Display name"),
//         DataColumn(label: Text("Email"), tooltip: "To Display Email"),
//         DataColumn(label: Text("Update"), tooltip: "Update data"),
//         DataColumn(label: Text("Delete"), tooltip: "Delete data"),
//       ],
//       rows: userList
//           .map(
//             (user) => DataRow(
//           cells: [
//             DataCell(
//               Text(user.name.toString()),
//             ),
//             DataCell(
//               Text(user.email.toString()),
//             ),
//             DataCell(
//               IconButton(
//                 onPressed: () {
//                   this.user = user;
//                   _updateTextControllers(); // new function here
//                 },
//                 icon: Icon(
//                   Icons.edit,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             DataCell(
//               IconButton(
//                 onPressed: () {
//                   this.user = user;
//                   _deleteTextControllers(); // new function here
//                 },
//                 icon: Icon(
//                   Icons.delete,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//           .toList(),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Data add to List Table using Form"),
//       ),
//       body: Container(
//         child: Column(
//           children: <Widget>[
//             bodyData(),
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Form(
//                 key: form,
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       TextFormField(
//                         controller: nameController,
//                         focusNode: _focusNode,
//                         keyboardType: TextInputType.text,
//                         autocorrect: false,
//                         maxLines: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'This field is required';
//                           }
//                           return null;
//                         },
//                         decoration: new InputDecoration(
//                           labelText: 'Name',
//                           hintText: 'Name',
//                           labelStyle: new TextStyle(
//                               decorationStyle: TextDecorationStyle.solid),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         keyboardType: TextInputType.text,
//                         autocorrect: false,
//                         maxLines: 1,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'This field is required';
//                           }
//                           return null;
//                         },
//                         decoration: new InputDecoration(
//                             labelText: 'Email',
//                             hintText: 'Email',
//                             labelStyle: new TextStyle(
//                                 decorationStyle: TextDecorationStyle.solid)),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Column(
//                         // crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Center(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 TextButton(
//                                   child: Text("Add"),
//                                   onPressed: () {
//                                     if (validate() == true) {
//                                       form.currentState!.save();
//                                       addUserToList(
//                                         nameController.text,
//                                         emailController.text,
//                                       );
//                                       clearForm();
//                                     }
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: Text("Update"),
//                                   onPressed: () {
//                                     if (validate() == true) {
//                                       form.currentState!.save();
//                                       updateForm();
//                                       clearForm();
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void updateForm() {
//     setState(() {
//       //Code to update the list after editing
//       user.name = nameController.text;
//       user.email = emailController.text;
//     });
//   }
//
//   void _updateTextControllers() {
//     setState(() {
//       nameController.text = user.name!;
//       emailController.text = user.email!;
//     });
//   }
//
//   void _deleteTextControllers() {
//     setState(() {
//       //How to delete the list data on clicking Delete button?
//       int currentIndex = userList.indexOf(user);
//       userList.removeAt(currentIndex);
//     });
//   }
//
//   void addUserToList(name, email) {
//     setState(() {
//       userList.add(User(name: name, email: email));
//     });
//   }
//
//   clearForm() {
//     nameController.clear();
//     emailController.clear();
//   }
//
//   bool validate() {
//     var valid = form.currentState!.validate();
//     if (valid) form.currentState!.save();
//     return valid;
//   }
// }