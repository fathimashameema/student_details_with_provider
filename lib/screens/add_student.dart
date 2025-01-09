import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:student_details/widgets/custom_text_form_field.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
              ),
              ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 120,
                      bottom: 30,
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const CustomTextFormField(
                    hintText: 'Name',
                  ),
                  const CustomTextFormField(
                    hintText: 'Age',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30,
                      top: 10,
                    ),
                    child: CustomDropdown(
                      hintText: 'Batch',
                      items: const [
                        'BCR61',
                        'BCR60',
                        'BCR62',
                        'BCR63', 
                      ],
                      onChanged: (value) {},
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.grey.withOpacity(0.2),
                        expandedFillColor:
                            const Color.fromARGB(255, 43, 42, 42),
                      ),
                    ),
                  ),
                  const CustomTextFormField(
                    hintText: 'Phone number',
                  ),
                  const CustomTextFormField(
                    hintText: 'Email',
                  ),
                  // Text('hey you'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
