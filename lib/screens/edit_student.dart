import 'dart:io';
import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/student_provider.dart';
import 'package:student_details/models/batch.dart';
import 'package:student_details/models/student_model.dart';
import 'package:student_details/widgets/custom_alert_dialogue.dart';
import 'package:student_details/widgets/custom_text_form_field.dart';

class EditStudent extends StatelessWidget {
  final Uint8List? profile;
  final int index;
  final String name;
  final int age;
  final String email;
  final int number;
  final String batch;
  const EditStudent(
      {super.key,
      required this.name,
      required this.age,
      required this.email,
      required this.number,
      required this.batch,
      required this.index,
      this.profile});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final ageController = TextEditingController(text: age.toString());
    final batchController = SingleSelectController<String>(batch);
    final numberController = TextEditingController(text: number.toString());
    final emailController = TextEditingController(text: email);
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
        title: const Text("Edit Student"),
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
                  // backgroundImage: studentProvider.selectedImage != null
                  //     ? FileImage(studentProvider.selectedImage!)
                  //     : (profile != null
                  //         ? MemoryImage(profile!)
                  //         : const AssetImage(
                  //                 'assets/images/avatar-3814049_1280.webp')
                  //             as ImageProvider),
                  child: ClipOval(
                    child: studentProvider.selectedImage != null
                        ? Image.file(studentProvider.selectedImage!)
                        : (profile != null
                            ? Image.memory(profile!)
                            : Image.asset(
                                'assets/images/avatar-3814049_1280.webp')),
                  ),
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
                  final student = StudentModel(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    batch: batchController.value!,
                    phoneNo: int.parse(numberController.text),
                    email: emailController.text,
                    profileImagePath: imageBytes,
                  );
                  await showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomAlertDialogue(
                        title: const Text('Edit Student'),
                        content: const Text(
                            'Are you sure you want to keep the changes?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              studentProvider.editStudent(index, student);
                              studentProvider
                                  .clearImage(); // Clear image after saving

                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

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
