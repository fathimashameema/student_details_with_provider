import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/functions/student_provider.dart';
import 'package:student_details/screens/edit_student.dart';
import 'package:student_details/widgets/custom_alert_dialogue.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int index;

  const StudentCard({
    super.key,
    required this.name,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/6o6z8a.jpg'),
                // borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => EditStudent(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (ctx) {
                      return CustomAlertDialogue(
                        title: const Text('Delete Student'),
                        content: const Text(
                            'Are you sure you want to delete this Student?'),
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
                              studentProvider.deleteStudent(index);
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
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
