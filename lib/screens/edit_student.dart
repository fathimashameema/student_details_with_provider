import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/student_provider.dart';
import 'package:student_details/models/batch.dart';
import 'package:student_details/models/student_model.dart';
import 'package:student_details/widgets/custom_text_form_field.dart';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key});

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
        title: const Text("Edit Student"),
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
