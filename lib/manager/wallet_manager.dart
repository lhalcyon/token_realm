import 'package:l_token/model/wallet.dart';

class WalletManager {

  factory WalletManager() => _getInstance();

  static WalletManager get shared => _getInstance();
  static WalletManager _shared;


  WalletManager._internal();

  static WalletManager _getInstance(){
    if (_shared == null){
      _shared = new WalletManager._internal();
    }
    return _shared;
  }

  // ------------------  Singleton above ------------------

  Map<String, WalletWrapper> _wallets = {};

  bool isWalletExisted(String address, WalletWrapper wallet) {
    String lowerCaseAddress = address.toLowerCase();
    return _wallets.containsKey(lowerCaseAddress);
  }

  WalletManager append(WalletWrapper wrapper) {
    _wallets[wrapper.address.toLowerCase()] = wrapper;
    return this;
  }

  WalletManager remove(String address) {
    _wallets.remove(address.toLowerCase());
    return this;
  }

  void _flush(){

  }

  WalletManager load(){

    return this;
  }
}
