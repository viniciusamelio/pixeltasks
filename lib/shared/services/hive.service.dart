import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveService {

  Future<void> init() async {
    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    
  }

  Future<Box>openBox(String boxName) async{
    await init();
    Box box = await Hive.openBox(boxName);
    return box;
  }
}
