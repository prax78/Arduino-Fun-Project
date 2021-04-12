

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';




void main()=>runApp(new MaterialApp(
  home: Bluetooth(),

));

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {




  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection connection;
  BluetoothDevice mydevice;
  String op="Press ConnectBT Button";
  Color status;
  bool isConnectButtonEnabled=true;
  bool isDisConnectButtonEnabled=false;

  bool isToneOne=false;
  bool isToneTwo=false;
  bool isToneThree=false;
  bool isToneFour=false;
  bool isToneFive=false;










  void _connect() async  {
    List<BluetoothDevice> devices = [];
    setState(() {
      isConnectButtonEnabled=false;
      isDisConnectButtonEnabled=true;
       isToneOne=true;
       isToneTwo=true;
       isToneThree=true;
       isToneFour=true;
       isToneFive=true;
    });
    devices = await _bluetooth.getBondedDevices();
    // ignore: unnecessary_statements
    devices.forEach((device) {

      print(device);
      if(device.name=="HC-05")
      {
        mydevice=device;
      }
    });

    await BluetoothConnection.toAddress(mydevice.address)
        .then((_connection) {
      print('Connected to the device'+ mydevice.toString());
      _showtoastConnect(context);

      connection = _connection;});




    connection.input.listen(null).onDone(() {

      print('Disconnected remotely!');
    });

  }
 void _toneone()
 {

   connection.output.add(ascii.encode("1"));

 }

void _tonetwo()
{

  connection.output.add(ascii.encode("2"));

}

void _tonethree()
{

  connection.output.add(ascii.encode("3"));

}

void _tonefour()
{

  connection.output.add(ascii.encode("4"));

}

void _tonefive()
{

  connection.output.add(ascii.encode("5"));

}



void _disconnect()
{

  setState(() {
    op="Disconnected";
    isConnectButtonEnabled=true;
    isDisConnectButtonEnabled=false;
     isToneOne=false;
     isToneTwo=false;
     isToneThree=false;
     isToneFour=false;
     isToneFive=false;
  });
  connection.close();
  connection.dispose();
  _showtoastDisConnect(context);
}

void _showtoastConnect(context){
    final scaffold=ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(content: const Text("Connected"),duration: const Duration(seconds: 2),action: SnackBarAction(label: "Close",onPressed: scaffold.hideCurrentSnackBar,),),);
}

  void _showtoastDisConnect(context){
    final scaffolds=ScaffoldMessenger.of(context);
    scaffolds.showSnackBar(SnackBar(content: const Text("Disconnected"),duration: const Duration(seconds: 2),action: SnackBarAction(label: "Close",onPressed: scaffolds.hideCurrentSnackBar,),),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Arduino Fun Tones ",style: TextStyle(color: Colors.black),),

        backgroundColor:Colors.blue,
      ),


    body:
    Column(
      children: [

        Center(
            child: Column(

              children: [

                Card(color: Colors.white,elevation: 50,shadowColor: Colors.grey,
                  child:Text("Please make sure you paired your HC-05, its default password is 1234",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                )
              ],
            )
        ),


        Container(
          child: Row(

            children: [

              Container(padding: EdgeInsets.all(5),child:TextButton(onPressed:isConnectButtonEnabled?_connect:null ,child: Text("Connect BT",style: TextStyle(fontSize: 17),) ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent)))
                ,),
              SizedBox(width: 5,),


              Container(padding: EdgeInsets.all(5),child:TextButton(onPressed:isDisConnectButtonEnabled?_disconnect:null,child: Text("Disconnect BT",style:TextStyle(fontSize: 17)),style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)))
                ,),

            ],
          ),
        ),
        SizedBox(height: 50),

       Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(child: TextButton(onPressed:isToneOne?_toneone:null, child: Text("Classic Nokia Tone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent))),padding: EdgeInsets.all(10),),
             ],
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(child: TextButton(onPressed:isToneTwo?_tonetwo:null, child: Text("Classic PACMAN  Tone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),),),padding: EdgeInsets.all(10),),
             ],
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(child: TextButton(onPressed:isToneThree?_tonethree:null, child: Text("Lullaby Tone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amberAccent)),),padding: EdgeInsets.all(10),),
             ],
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(child: TextButton(onPressed:isToneFour?_tonefour:null, child: Text("Happy Birth Day Tone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.cyanAccent)),),padding: EdgeInsets.all(10),),
             ],
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Container(child: TextButton(onPressed:isToneFive?_tonefive:null, child: Text("ChristMas Tone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent)),),padding: EdgeInsets.all(10),),
             ],
           ),
         ],
       )





      ],

    ),



    );
  }
}
