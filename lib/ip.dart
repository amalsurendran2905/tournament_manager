import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tournament_app/splash.dart';


class Ip_page extends StatefulWidget {
   Ip_page({super.key});

  @override
  State<Ip_page> createState() => _Ip_screenState();
}

class _Ip_screenState extends State<Ip_page> {
  final key1=GlobalKey<FormState>();

  TextEditingController _ipController=TextEditingController();

  String ip_address='';
  
  
   @override

  void initState() {
    // TODO: implement initState
    
    _loadIpaddress();
  }
  void _loadIpaddress()async {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    String? saveIp=sharedPreferences.getString('ip');

    if(saveIp!=null){

      setState(() {
        
        _ipController.text=saveIp;
      });
    }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            
            key: key1,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _ipController,
                decoration: InputDecoration(
                  labelText: 'IP ADDRESS',
                  hintText: 'Enter your ip address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Enter your ip address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{
          
                if(key1.currentState!.validate()){

                  setState(() {
                    ip_address=_ipController.text;
                  });

                  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();

                  await sharedPreferences.setString('ip', ip_address);

                  

                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                    return Splash();
                  }));

                  
      
                }
          
              }, child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 25),))
            ],
          )),
        ),
      ),
    );
  }
}



