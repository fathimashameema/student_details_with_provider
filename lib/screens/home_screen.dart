import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_details/functions/student_provider.dart';
import 'package:student_details/screens/add_student.dart';
import 'package:student_details/screens/student_details.dart';
import 'package:student_details/widgets/add_students_field.dart';
import 'package:student_details/widgets/search_form_field.dart';
import 'package:student_details/widgets/student_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text(
                    'Student Details 📝',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const CustomSearchFormField(),
            const AddStudentsField(
              navigateTo: AddStudent(),
            ),

            FutureBuilder(
                future: studentProvider.getStudent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: studentProvider.students.length,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!);
                      },
                    );
                  } else if (studentProvider.students.isEmpty) {
                    return Center(
                      child: Text(
                        'No Students are added yet!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: studentProvider.students.length,
                      itemBuilder: (context, index) {
                        final student = studentProvider.students[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentDetails(
                                  name: student.name,
                                  batch: student.batch,
                                  age: student.age,
                                  phoneNo: student.phoneNo,
                                  email: student.email,
                                ),
                              ),
                            );
                          },
                          child: StudentCard(
                            name: student.name,
                          ),
                        );
                      },
                    );
                  }
                })
            // GestureDetector(
            //   child: const StudentCard(),
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (ctx) => StudentDetails(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
