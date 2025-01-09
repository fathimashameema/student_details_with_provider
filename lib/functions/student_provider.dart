import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_details/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  Box<StudentModel>? _studentModelBox;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;

  Future<void> openBox() async {
    if (_studentModelBox == null || !_studentModelBox!.isOpen) {
      _studentModelBox = await Hive.openBox<StudentModel>('student box');
    }
    print(_studentModelBox!.name);
  }

  Future<void> addStudent(StudentModel student) async {
    if (_studentModelBox == null || _studentModelBox!.isEmpty) {
      await openBox();
    }
    await _studentModelBox!.add(student);
    notifyListeners();
  }

  Future<void> getStudent() async {
    await openBox();
    _students = _studentModelBox!.values.toList();
    notifyListeners();
  }

  Future<void> editStudent(int index, StudentModel student) async {
    await openBox();
    _studentModelBox!.putAt(index, student);
    notifyListeners();
  }

  Future<void> deleteStudent(int index) async {
    await openBox();
    _studentModelBox!.deleteAt(index);
    notifyListeners();
  }
}
