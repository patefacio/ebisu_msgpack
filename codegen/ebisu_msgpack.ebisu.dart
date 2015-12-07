import "dart:io";
import "package:path/path.dart" as path;
import "package:ebisu/ebisu.dart";
import "package:ebisu/ebisu_dart_meta.dart";
import "package:logging/logging.dart";

String _topDir;

final _logger = new Logger('ebisu_msgpack');

void main() {
  Logger.root.onRecord.listen(
      (LogRecord r) => print("${r.loggerName} [${r.level}]:\t${r.message}"));
  String here = path.absolute(Platform.script.toFilePath());

  Logger.root.level = Level.OFF;

  final purpose = '''
Support for generating code providing msgpack data access patterns.
''';

  _topDir = path.dirname(path.dirname(here));
  useDartFormatter = true;
  System ebisu = system('ebisu_msgpack')
    ..includesHop = true
    ..license = 'boost'
    ..pubSpec.homepage = 'https://github.com/patefacio/ebisu_msgpack'
    ..pubSpec.version = '0.0.1'
    ..pubSpec.doc = purpose
    ..rootPath = _topDir
    ..doc = purpose
    ..testLibraries = [
      library('test_msgpack_cpp')
      ..imports = [
        'package:ebisu_pod/example/balance_sheet.dart',
      ],
    ]
    ..libraries = [

      library('msgpack_cpp')
      ..doc = 'Support for generating C++ serializers with msgpack'
      ..imports = [
        'package:ebisu_pod/pod.dart',
        'package:quiver/iterables.dart',
        'package:id/id.dart',
        'package:ebisu/ebisu.dart',
        'package:ebisu_cpp/ebisu_cpp.dart',
      ]
      ..classes = [
        class_('pod_msgpack')
        ..doc = 'Given a root [PodObject] will generate C++ serializers'
        ..defaultMemberAccess = RO
        ..members = [
          member('root_pod')..type = 'PodObject',
          member('namespace')..type = 'Namespace'..access = IA,
        ]
      ],
    ];


  ebisu.generate();

  _logger.warning('''
**** NON GENERATED FILES ****
${indentBlock(brCompact(nonGeneratedFiles))}
''');
}
