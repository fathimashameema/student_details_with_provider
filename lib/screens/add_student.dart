import 'dart:io';
import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    final batchController = SingleSelectController<String>(batches[0]);
    final numberController = TextEditingController();
    final emailController = TextEditingController();
    final studentProvider = Provider.of<StudentProvider>(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    


    Future<void> pickImage() async {
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnImage != null) {
        studentProvider.setImage(File(returnImage.path));
      }
    }

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
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  backgroundImage: studentProvider.selectedImage != null
                      ? FileImage(File(studentProvider.selectedImage!.path))
                      : const AssetImage(
                              'assets/images/avatar-3814049_1280.webp')
                          as ImageProvider,
                ),
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
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  Uint8List? imageBytes;
                  if (studentProvider.selectedImage != null) {
                    imageBytes =
                        await studentProvider.selectedImage!.readAsBytes();
                  }
                  print(imageBytes);
                  final student = StudentModel(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      batch: batchController.value!,
                      phoneNo: int.parse(numberController.text),
                      email: emailController.text,
                      profileImagePath: imageBytes);
                  // print(student.profileImagePath);

                  studentProvider.addStudent(student);
                  studentProvider.clearImage(); // Clear image after saving

                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
