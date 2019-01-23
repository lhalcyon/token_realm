
import 'package:l_token/model/wallet.dart';

class WalletManager {

  Map<String,WalletWrapper> _wallets = {};

  bool isWalletExisted(String address,WalletWrapper wallet){
    String lowerCaseAddress = address.toLowerCase();
    return _wallets.containsKey(lowerCaseAddress);
  }



}