/// Support for generating C++ serializers with msgpack
library ebisu_msgpack.msgpack_cpp;

import 'package:ebisu/ebisu.dart';
import 'package:ebisu_cpp/ebisu_cpp.dart';
import 'package:ebisu_pod/ebisu_pod.dart';
import 'package:ebisu_pod/pod_cpp.dart';
import 'package:id/id.dart';
import 'package:quiver/iterables.dart';

// custom <additional imports>
// end <additional imports>

/// Given a package of plain only data entities, [PodPackage], will generate C++
/// msgpack serializers
class PodMsgpack {
  PodPackage get podPackage => _podPackage;
  Namespace get namespace => _namespace;
  PodCppMapper get podCppMapper => _podCppMapper;
  Header get header => _header;

  // custom <class PodMsgpack>

  PodMsgpack(this._podPackage, [this._namespace]) {
    if (_namespace == null) {
      _namespace = new Namespace(podPackage.name.path);
    }
    _podCppMapper = new PodCppMapper(podPackage);
    _header = _podCppMapper.header;
    _addSerializerSupport();
  }

  _addSerializerSupport() {
    _header.includes.add('msgpack.hpp');
  }

  // end <class PodMsgpack>

  PodPackage _podPackage;
  Namespace _namespace;
  PodCppMapper _podCppMapper;
  Header _header;
}

// custom <library msgpack_cpp>
// end <library msgpack_cpp>
