import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class EmpData {
  List<dynamic> currentEmpList;
  List<dynamic> previousEmpList;

  EmpData({required this.currentEmpList, required this.previousEmpList});
}

class FetchData {
  static Future<EmpData> fetchSavedData() async {
    List<dynamic> currentEmpList = [];
    List<dynamic> previousEmpList = [];
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final path = appDocumentDirectory.path;
    await BoxCollection.open(
      'ListOfEmp', // Name of your database
      {'currentEmp', 'previousEmp'},
      path: path, // Names of your boxes
    );
    await Hive.openBox<Map>('currentEmp');
    await Hive.openBox<Map>('previousEmp');
    final Box currentEmp = Hive.box<Map>('currentEmp');
    final Box previousEmp = Hive.box<Map>('previousEmp');
    //currentEmpList = currentEmp.get('qqq');
    for (var element in currentEmp.keys) {
      currentEmpList.add(currentEmp.get(element.toString()));
    }
    for (var element in previousEmp.keys) {
      previousEmpList.add(previousEmp.get(element.toString()));
    }

    print(currentEmpList + currentEmp.keys.toList());
    print('================================+');
    print(previousEmpList + previousEmp.keys.toList());
    return EmpData(
      currentEmpList: currentEmpList,
      previousEmpList: previousEmpList,
    );
  }
}
