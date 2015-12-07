import 'package:logging/logging.dart';
import 'test_msgpack_cpp.dart' as test_msgpack_cpp;

main() {
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  test_msgpack_cpp.main();
}
