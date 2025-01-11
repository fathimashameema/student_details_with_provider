// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:student_details/functions/student_provider.dart';
// import 'package:student_details/models/batch.dart';
// import 'package:student_details/models/student_model.dart';
// import 'package:student_details/widgets/custom_text_form_field.dart';

// class AddStudent extends StatelessWidget {
//   const AddStudent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController ageController = TextEditingController();
//     SingleSelectController batchController =
//         SingleSelectController<Batch>((batches[0]));
//     TextEditingController numberController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     final studentProvider = Provider.of<StudentProvider>(context);
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(
//                         top: 100,
//                         bottom: 30,
//                       ),
//                       child: CircleAvatar(
//                         radius: 80,
//                         backgroundColor: Colors.grey,
//                       ),
//                     ),
//                     CustomTextFormField(
//                       controller: nameController,
//                       hintText: 'Name',
//                     ),
//                     CustomTextFormField(
//                       controller: ageController,
//                       keyboardType: TextInputType.number,
//                       hintText: 'Age',
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 30.0,
//                         right: 30,
//                         top: 10,
//                       ),
//                       child: CustomDropdown(
//                         validator: (value) =>
//                             value == null ? "Batch can not be null" : null,
//                         controller: batchController,
//                         hintText: 'Batch',
//                         items: batches,
//                         onChanged: (value) {},
//                         decoration: CustomDropdownDecoration(
//                           closedFillColor: Colors.grey.withOpacity(0.2),
//                           expandedFillColor:
//                               const Color.fromARGB(255, 43, 42, 42),
//                         ),
//                       ),
//                     ),
//                     CustomTextFormField(
//                       controller: numberController,
//                       keyboardType: TextInputType.phone,
//                       hintText: 'Phone number',
//                     ),
//                     CustomTextFormField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       hintText: 'Email',
//                       validator: (value) {
//                         final emailRegex =
//                             RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
//                         if (!emailRegex.hasMatch(emailController.text)) {
//                           return 'Email is not valid';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: InkWell(
//                   splashColor: Colors.black,
//                   onTap: () {
//                     onTap:
//                     () {
//                       if (nameController.text.isEmpty ||
//                           ageController.text.isEmpty ||
//                           batchController.value == null ||
//                           numberController.text.isEmpty ||
//                           emailController.text.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Please fill all fields')),
//                         );
//                         return;
//                       }

//                       final student = StudentModel(
//                         name: nameController.text,
//                         age: int.parse(ageController.text),
//                         batch: batchController.value!,
//                         phoneNo: int.parse(numberController.text),
//                         email: emailController.text,
//                       );

//                       studentProvider.addStudent(student);
//                       Navigator.of(context).pop();
//                     };
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(30),
//                     width: 80,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.withOpacity(0.2),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Save',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/student_provider.dart';
import 'package:student_details/models/batch.dart';
import 'package:student_details/models/student_model.dart';
import 'package:student_details/widgets/custom_text_form_field.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final batchController = SingleSelectController<Batch>(batches[0]);
    final numberController = TextEditingController();
    final emailController = TextEditingController();
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                controller: nameController,
                hintText: 'Name',
              ),
              CustomTextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                hintText: 'Age',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomDropdown(
                  decoration: CustomDropdownDecoration(
                    closedFillColor: Colors.grey.withOpacity(0.2),
                    expandedFillColor: const Color.fromARGB(255, 43, 42, 42),
                  ),
                  onChanged: (v) {},
                  validator: (value) =>
                      value == null ? "Batch cannot be null" : null,
                  controller: batchController,
                  hintText: 'Batch',
                  items: batches,
                ),
              ),
              CustomTextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                validator: (value) {
                  final emailRegex =
                      RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                  if (value == null || !emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.grey.withOpacity(0.3),
                  ),
                ),
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final student = StudentModel(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    batch: batchController.value!.name,
                    phoneNo: int.parse(numberController.text),
                    email: emailController.text,
                  );

                  studentProvider.addStudent(student);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
