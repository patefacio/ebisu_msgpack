library ebisu_msgpack.msgpack_cpp;

import 'package:ebisu/ebisu.dart';
import 'package:ebisu_cpp/ebisu_cpp.dart';
import 'package:ebisu_pod/pod.dart';
import 'package:id/id.dart';
import 'package:quiver/iterables.dart';

// custom <additional imports>
// end <additional imports>

class PodMsgpack {
  PodObject rootPod;

  // custom <class PodMsgpack>

  Header get header {
    return header(rootPod.name);
  }

  // end <class PodMsgpack>

}

// custom <library msgpack_cpp>
// end <library msgpack_cpp>
