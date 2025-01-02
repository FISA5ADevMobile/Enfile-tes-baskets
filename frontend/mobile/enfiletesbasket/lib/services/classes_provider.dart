import 'dart:convert';

import 'package:enfiletesbasket/services/classes_service.dart';
import 'package:flutter/material.dart';
import '../model/course.dart';

class ClassesProvider extends ChangeNotifier {
  final ClassesService _classesService = ClassesService();

}
