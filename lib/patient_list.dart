import 'dart:convert';
import 'package:curus_test/audio_to_text.dart';
import 'package:curus_test/utils.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Patient List"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString("assets/mock_data.json"),
            builder: (context,AsyncSnapshot snapshot){
              var myData = json.decode(snapshot.data.toString());
              if(snapshot.data==null){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (BuildContext context,int index){
                      return Card(
                          child: ListTile(
                            leading: Image.network(myData[index]["image"]),
                            title: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: myData[index]["gender"]=="Male"?"Mr":"Ms", style: head2.copyWith(color: Colors.grey)),
                                  TextSpan(text: " ${myData[index]["first_name"]} ${myData[index]["last_name"]}",style: head1),
                                ],
                              ),
                            ),
                            subtitle: Text(myData[index]["description"].length > 30 ? '${myData[index]["description"].substring(0,30)}...' : myData[index]["description"],),
                          )
                      );
                    }
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context)=>AudioToText())
            );
          },
          label: Text("Record Audio")),
    );
  }
}
