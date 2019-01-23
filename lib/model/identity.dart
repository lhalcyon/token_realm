
import 'package:token_core_plugin/model/ex_identity.dart';

class Identity {

  String name;

  String avatar;

  ExIdentity identity;


  Identity({this.name, this.avatar, this.identity});

  @override
  int get hashCode => identity.hashCode;
}