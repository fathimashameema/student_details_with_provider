// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:student_details/functions/student_provider.dart';
// import 'package:student_details/screens/add_student.dart';
// import 'package:student_details/screens/student_details.dart';
// import 'package:student_details/widgets/add_students_field.dart';
// import 'package:student_details/widgets/search_form_field.dart';
// import 'package:student_details/widgets/student_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late StudentProvider studentProvider;
//   @override
//   void initState() {
//     super.initState();
//     studentProvider = Provider.of<StudentProvider>(context, listen: false);
//     studentProvider.getStudent();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final studentProvider = Provider.of<StudentProvider>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Student Details 📝',
//                     style: GoogleFonts.lilitaOne(
//                       fontSize: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const CustomSearchFormField(),
//             const AddStudentsField(
//               navigateTo: AddStudent(),
//             ),

//             Expanded(
//               child: FutureBuilder(
//                   future: studentProvider.getStudent(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return ListView.builder(
//                         // shrinkWrap: true,
//                         itemCount: studentProvider.students.length,
//                         itemBuilder: (context, index) {
//                           return Shimmer.fromColors(
//                               baseColor: Colors.grey.withOpacity(0.2),
//                               highlightColor: Colors.grey.withOpacity(0.3),
//                               child: Container(
//                                 height: 80,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ));
//                         },
//                       );
//                     } else if (studentProvider.students.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No Students are added yet!',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       );
//                     } else {
//                       return ListView.builder(
//                         itemCount: studentProvider.students.length,
//                         itemBuilder: (context, index) {
//                           final student = studentProvider.students[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (ctx) => StudentDetails(
//                                     name: student.name,
//                                     batch: student.batch,
//                                     age: student.age,
//                                     phoneNo: student.phoneNo,
//                                     email: student.email,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: StudentCard(
//                               index: index,
//                               name: student.name,
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   }),
//             ),
//             // GestureDetector(
//             //   child: const StudentCard(),
//             //   onTap: () {
//             //     Navigator.of(context).push(
//             //       MaterialPageRoute(
//             //         builder: (ctx) => StudentDetails(),
//             //       ),
//             //     );
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  @override
  Widget build(BuildContext context) {
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
            Consumer<StudentProvider>(
              builder: (context, studentProvider, child) {
                return CustomSearchFormField(
                  onSearch: (query) => studentProvider.filterStudents(query),
                );
              },
            ),
            const AddStudentsField(
              navigateTo: AddStudent(),
            ),
            Expanded(
              child: Consumer<StudentProvider>(
                builder: (context, studentProvider, child) {
                  if (studentProvider.isLoading) {
                    return ListView.builder(
                      itemCount: studentProvider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.2),
                          highlightColor: Colors.grey.withOpacity(0.3),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (studentProvider.students.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Students are added yet!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (studentProvider.filteredStudents.isEmpty) {
                    return const Center(
                      child: Text(
                        'No matches found!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: studentProvider.filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = studentProvider.filteredStudents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentDetails(
                                  profile: student.profileImagePath,
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
                            index: index,
                            name: student.name,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
