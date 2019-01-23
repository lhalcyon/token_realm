import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:token_core_plugin/model/ex_wallet.dart';

void main() {

  test('Log test', () {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record){
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
    final Logger log = new Logger('MyClassName');

  });
}
