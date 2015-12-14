library ebisu_msgpack.test_msgpack_cpp;

import 'package:ebisu_pod/example/balance_sheet.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

// custom <additional imports>

import 'package:ebisu_msgpack/msgpack_cpp.dart';

// end <additional imports>

final _logger = new Logger('test_msgpack_cpp');

// custom <library test_msgpack_cpp>
// end <library test_msgpack_cpp>

main([List<String> args]) {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
// custom <main>

  test('serialization', () {
    final podMsgpack = new PodMsgpack(balanceSheet);
    final header = podMsgpack.header;
    print(header.contents);
  });

// end <main>
}
