#!/usr/bin/env dart
import 'dart:io';
import 'package:args/args.dart';
import 'package:ebisu/ebisu.dart';
import 'package:ebisu/ebisu_dart_meta.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
// custom <additional imports>
// end <additional imports>
final _logger = new Logger('ebisuMsgpackEbisuDart');

main(List<String> args) {
  Logger.root.onRecord.listen((LogRecord r) =>
      print("${r.loggerName} [${r.level}]:\t${r.message}"));
  Logger.root.level = Level.OFF;
  useDartFormatter = true;
  String here = absolute(Platform.script.toFilePath());
  // custom <ebisuMsgpackEbisuDart main>

  final purpose = '''
Support for generating code providing msgpack data access patterns.
''';

  _topDir = dirname(dirname(here));
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
        'package:ebisu_pod/ebisu_pod.dart',
        'package:ebisu_pod/pod_cpp.dart',
        'package:ebisu_cpp/ebisu_cpp.dart',
        'package:quiver/iterables.dart',
        'package:id/id.dart',
        'package:ebisu/ebisu.dart',
      ]
      ..classes = [
        class_('pod_msgpack')
        ..doc = '''
Given a package of plain only data entities, [PodPackage], will generate C++
msgpack serializers'''
        ..defaultMemberAccess = RO
        ..members = [
          member('pod_package')..type = 'PodPackage',
          member('namespace')..type = 'Namespace'..access = RO,
          member('pod_cpp_mapper')
          ..type = 'PodCppMapper'
          ..access = RO,
          member('header')..type = 'Header'..access = RO,
        ]
      ],
    ];


  ebisu.generate();

  _logger.warning('''
**** NON GENERATED FILES ****
${indentBlock(brCompact(nonGeneratedFiles))}
''');

  // end <ebisuMsgpackEbisuDart main>
}

// custom <ebisuMsgpackEbisuDart global>
String _topDir;
// end <ebisuMsgpackEbisuDart global>
