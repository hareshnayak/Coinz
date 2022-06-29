import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import '../env/secretKeys.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString("assets/abi.json");
  String contractAddress = CONTRACT_ADDRESS;
  final contract = DeployedContract(ContractAbi.fromJson(abi, "HarryCoin"),
    EthereumAddress.fromHex(contractAddress),);
  return contract;
}
