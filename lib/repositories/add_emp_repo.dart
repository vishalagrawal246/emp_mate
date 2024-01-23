import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddEmpRepo {
  Future<void> addEmp(
      {required String empName,
      required String empRole,
      required String from,
      required String to,
      String? keyy}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 4000), () async {
        if (to != 'No Date') {
          await Hive.openBox<Map>('previousEmp');
          final Box<Map> previousEmp = Hive.box<Map>('previousEmp');

          //List<dynamic>? existingList =
          //  previousEmp.get(empName, defaultValue: <dynamic>[]);

          // existingList
          //  ?.add({'name': empName, 'role': empRole, 'from': from, 'to': to});

          await previousEmp.put(keyy ?? empName, {
            'name': empName,
            'role': empRole,
            'from': from,
            'to': to,
            'keyy': keyy ?? empName
          });
        } else {
          await Hive.openBox<Map>('currentEmp');

          final Box<Map> currentEmp = Hive.box<Map>('currentEmp');

          //  List<dynamic>? existingList =
          //   currentEmp.get(empName, defaultValue: <dynamic>[]);

          //   existingList
          //  ?.add({'name': empName, 'role': empRole, 'from': from, 'to': to});

          await currentEmp.put(keyy ?? empName, {
            'name': empName,
            'role': empRole,
            'from': from,
            'to': to,
            'keyy': keyy ?? empName
          });
        }

        debugPrint('Data saved');
      });
    } catch (e) {
      debugPrint('Failed to save data');
      rethrow;
    }
  }
}
