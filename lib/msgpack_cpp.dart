/// Support for generating C++ serializers with msgpack
library ebisu_msgpack.msgpack_cpp;

import 'package:ebisu/ebisu.dart';
import 'package:ebisu_cpp/ebisu_cpp.dart';
import 'package:ebisu_pod/pod.dart';
import 'package:id/id.dart';
import 'package:quiver/iterables.dart';

// custom <additional imports>
// end <additional imports>

/// Given a root [PodObject] will generate C++ serializers
class PodMsgpack {
  PodObject get rootPod => _rootPod;

  // custom <class PodMsgpack>

  PodMsgpack(this._rootPod, [this._namespace]);

  Namespace get namespace =>
      this._namespace == null ? new Namespace([rootPod.id]) : this._namespace;

  Header get header {
    return new Header(rootPod.id)..namespace = namespace;
  }

  // end <class PodMsgpack>

  PodObject _rootPod;
  Namespace _namespace;
}

// custom <library msgpack_cpp>
// end <library msgpack_cpp>
