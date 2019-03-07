import 'package:token_core_plugin/model/ex_wallet.dart';

class WalletWrapper {

  String name;

  ChainType chainType;

  ExWallet wallet;

  String address;

  String keystore;

  String icon;

  WalletWrapper(
      {this.name, this.chainType, this.address, this.keystore, this.icon});

  @override
  int get hashCode {
    return address.toLowerCase().hashCode;
  }

  @override
  bool operator ==(other) {
    if (other is WalletWrapper) {
      return address.toLowerCase() == other.address.toLowerCase();
    }
    return false;
  }

  @override
  String toString() {
    return 'HDWallet{name: $name, address: $address, keystore: $keystore, icon: $icon}';
  }
}
