import 'package:flutter/material.dart';
import 'package:vonage_dart/vonage_dart.dart';


// Future<void> main() async {
//   final Vonage vonage = Vonage(
//       api_key: "xxxxxx", api_secret: "xxxxxx");
//   final VonageVerifyResponse res = await vonage.verify(
//       number: 'xxxxxxxxx', brand: "My Brand Name", code_length: 4);
//   print(res.request_id);
//
// }

void main(){
    runApp(MaterialApp(home:VonageExample()));
  }


class VonageExample extends StatefulWidget {
  const VonageExample({Key? key}) : super(key: key);

  @override
  _VonageExampleState createState() => _VonageExampleState();
}

class _VonageExampleState extends State<VonageExample> {

  late TextEditingController _phoneController;
  late TextEditingController _codeController;

  final Vonage vonage = Vonage(api_key: "VONAGE_API_KEY",api_secret: "VONAGE_API_SECRET");
  String REQUEST_ID ='';
  bool startverify = true;

  vonageVerify(String number) async{
    final VonageVerifyResponse res = await vonage.verify(number: number, brand: "My Flutter App", code_length: 4);
    if(res.request_id!=null){setState(() {REQUEST_ID = res.request_id!; startverify = !startverify;});}
  }

  vonageCheckVerify(String code) async{
    final VonageVerifyCheckResponse res = await vonage.check(request_id: REQUEST_ID, code: code);
    if(res.auth_status == 0){
      print(res.event_id);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()),);
    }
  }

  // do before render.
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _codeController = TextEditingController();
  }

  // delete resource when not using
  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth APP'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 16,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: startverify,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0,32,32,8),
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Phone Number',
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: startverify,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0,16,32,32),
                      child: ElevatedButton.icon(
                          onPressed: () async{
                            await vonageVerify(_phoneController.text);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                          icon: Icon(Icons.send),
                          label: Text('Verify Phone')),
                    ),
                  ),
                ),
                Visibility(
                  visible: !startverify,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32.0,32,32,8),
                    child: TextField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Code Recieved Via SMS',
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !startverify,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0,16,32,32),
                      child: ElevatedButton.icon(
                          onPressed: () async{
                            await vonageCheckVerify(_codeController.text);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                          icon: Icon(Icons.send),
                          label: Text('Check Code')),
                    ),
                  ),
                ),
                Visibility(
                  visible: !startverify,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
                      child: InkWell(
                          onTap: (){ setState(() {
                            startverify = !startverify;
                          });},
                          child: const Text('Verify Different Number',
                            style: TextStyle(decoration: TextDecoration.underline),))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 16,
            child: Column(
              children: <Widget>[
                Text('Welcome To The App HomePage :)'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








