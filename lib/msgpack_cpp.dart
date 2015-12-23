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
    _podCppMapper = new PodCppMapper(podPackage);
    _header = _podCppMapper.header;
    if (_namespace == null) {
      _namespace = new Namespace(podPackage.name.path);
    }
    _header.namespace = namespace;
    _addSerializerSupport();
  }

  _addSerializerSupport() {
    _header.includes.add('msgpack.hpp');
    for (Class cls in _header.classes) {
      final podObject = podPackage.getType(cls.id.snake);

      cls
        ..getCodeBlock(clsPublic).snippets.add(
            'MSGPACK_DEFINE(${cls.members.map((m) => m.vname).join(", ")});\n')
        ..addFullMemberCtor()
        ..defaultCtor.usesDefault = true;
    }

    final podEnums = podPackage.podEnums;
    _header.getCodeBlock(fcbPostNamespace).snippets.add(brCompact(podEnums.map(
        (pe) =>
            'MSGPACK_ADD_ENUM(${namespace.qualify(defaultNamer.nameEnum(pe.id))});')));

    final hasDate = podPackage.allTypes.any((var t) => t.typeName == 'date');

    _header.getCodeBlock(fcbPostNamespace).snippets.add('''
template< typename T >
inline msgpack::sbuffer to_msgpack(T const& t) {
  msgpack::sbuffer sbuf;
  msgpack::pack(sbuf, t);
  return sbuf;
}

template < typename T >
inline void from_msgpack(msgpack::sbuffer &sbuf, T &t) {
  msgpack::unpacked msg;
  msgpack::unpack(msg, sbuf.data(), sbuf.size());
  msgpack::object obj = msg.get();
  obj.convert(&t);
}
''');

    if (hasDate) {
      _header.getCodeBlock(fcbPostNamespace).snippets.add('''
#ifndef __BOOST_DATE_MSGPACK_SERIALIZER__
#define __BOOST_DATE_MSGPACK_SERIALIZER__
namespace msgpack {
MSGPACK_API_VERSION_NAMESPACE(MSGPACK_DEFAULT_API_NS) {
namespace adaptor {

template<>
struct convert<boost::gregorian::date> {
    msgpack::object const& operator()(msgpack::object const& o, boost::gregorian::date& v) const {
        v = boost::gregorian::from_undelimited_string(o.as<std::string>());
        return o;
    }
};

template<>
struct pack<boost::gregorian::date> {
    template <typename Stream>
    packer<Stream>& operator()(msgpack::packer<Stream>& o, boost::gregorian::date const& v) const {
        o.pack(boost::gregorian::to_iso_string(v));
        return o;
    }
};

} // namespace adaptor
} // MSGPACK_API_VERSION_NAMESPACE(MSGPACK_DEFAULT_API_NS)
} // namespace msgpack
#endif // __BOOST_DATE_MSGPACK_SERIALIZER__
''');
    }
  }

  // end <class PodMsgpack>

  PodPackage _podPackage;
  Namespace _namespace;
  PodCppMapper _podCppMapper;
  Header _header;
}

// custom <library msgpack_cpp>
// end <library msgpack_cpp>
