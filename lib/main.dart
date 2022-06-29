import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coinz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Coinz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Client httpClient;
  late Web3Client ethClient;

  bool data = false;
  int myAmount = 0;
  String infuraUrl = "https://ropsten.infura.io/v3/a7e3f028bac945f1b304b6a3755297d6";
  final myAddress = "0x5c6D144Aa3D3cF4F403cb4f8df326Bc91d4721d4";

  var myData;

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(infuraUrl, httpClient);
    getBalance(myAddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0x6aaE259501e37000043fd9EBE6418E4Dd9901e84";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "HarryCoin"),
      EthereumAddress.fromHex(contractAddress),);
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    print('data : $data');
    print("get balance called");
    EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalanace", []);
    print(result);
    myData = result[0];
    data = true;
    setState(() {
    });
    print('data : $data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Balance'),
          ),
          Center(
            child: data
                ? Text(myData.toString())
                : CircularProgressIndicator(),
          ),
          Center(
            child: Row(children: [
              Text('Amount'),
              Expanded(child: TextField(onChanged: (val) {
                myAmount = int.parse(val);
              },),),
            ],
            ),
          ),

          Center(
            child: Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),),
                  ),
                  onPressed: () {getBalance(myAddress);},
                  icon: Icon(Icons.refresh),
                  label: Text('Refresh'),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),),),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.call_made_outlined),
                  label: Text('Deposit'),),
                TextButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.call_received_outlined),
                  label: Text('Withdraw'),),
              ],
            ),
          )
        ],
      ),
    );
  }
}