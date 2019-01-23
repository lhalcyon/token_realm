

import 'package:token_core_plugin/model/ex_wallet.dart';

class WalletWrapper {

  String name;

  ExWallet wallet;

  String address;

  String keystore;

  String icon;

  String mnemonic;

  WalletWrapper({this.name, this.address, this.keystore, this.icon, this.mnemonic});

  @override
  int get hashCode {
    return address.hashCode;
  }

  @override
  bool operator ==(other) {
    if (other is WalletWrapper){
      return address.toLowerCase() == other.address.toLowerCase();
    }
    return false;
  }

  @override
  String toString() {
    return 'HDWallet{name: $name, address: $address, keystore: $keystore, icon: $icon, mnemonic: $mnemonic}';
  }


}