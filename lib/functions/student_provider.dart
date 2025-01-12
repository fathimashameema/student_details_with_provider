// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:student_details/models/student_model.dart';

// class StudentProvider extends ChangeNotifier {
//   Box<StudentModel>? _studentModelBox;

//   List<StudentModel> _students = [];
//   List<StudentModel> get students => _students;

//   Future<void> openBox() async {
//     if (_studentModelBox == null || !_studentModelBox!.isOpen) {
//       _studentModelBox = await Hive.openBox<StudentModel>('student box');
//     }
//     print(_studentModelBox!.name);
//   }

//   Future<void> addStudent(StudentModel student) async {
//     if (_studentModelBox == null ||! _studentModelBox!.isOpen) {
//       await openBox();
//     }
//     await _studentModelBox!.add(student);
//     notifyListeners();
//   }

//   Future<void> getStudent() async {
//     await openBox();
//     _students = _studentModelBox!.values.toList();
//     notifyListeners();
//   }

//   Future<void> editStudent(int index, StudentModel student) async {
//     await openBox();
//     _studentModelBox!.putAt(index, student);
//     notifyListeners();
//   }

//   Future<void> deleteStudent(int index) async {
//     await openBox();
//     _studentModelBox!.deleteAt(index);
//     notifyListeners();
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_details/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  Box<StudentModel>? _studentModelBox;

  List<StudentModel> _students = [];
  List<StudentModel> filteredStudents = [];
  List<StudentModel> get students => _students;
  bool isLoading = false;
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  void setImage(File? image) {
    _selectedImage = image;
    print('image is set');
    notifyListeners();
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  StudentProvider() {
    getStudent();
  }

  Future<void> openBox() async {
    try {
      if (_studentModelBox == null || !_studentModelBox!.isOpen) {
        _studentModelBox = await Hive.openBox<StudentModel>('student box');
      }
    } catch (e) {
      print("Error opening Hive box: $e");
    }
  }

  /// Adds a student to the Hive box
  Future<void> addStudent(StudentModel student) async {
    try {
      if (_studentModelBox == null || !_studentModelBox!.isOpen) {
        await openBox();
      }
      await _studentModelBox!.add(student);
      print('student added');
      await getStudent();
      // Refresh the local list
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  /// Retrieves all students from the Hive box
  Future<void> getStudent() async {
    try {
      await openBox();
      isLoading = true;
      notifyListeners();
      _students = _studentModelBox!.values.toList();
      filteredStudents = students;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents = students;
    } else {
      filteredStudents = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> editStudent(int index, StudentModel student) async {
    try {
      await openBox();
      await _studentModelBox!.putAt(index, student);
      await getStudent(); // Refresh the local list
    } catch (e) {
      print("Error editing student: $e");
    }
  }

  /// Deletes a student at a specific index
  Future<void> deleteStudent(int index) async {
    try {
      await openBox();
      await _studentModelBox!.deleteAt(index);
      print('student deleted');
      await getStudent(); // Refresh the local list
    } catch (e) {
      print("Error deleting student: $e");
    }
  }
}
