import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
class LaguageTranslationPage extends StatefulWidget {
  const LaguageTranslationPage({super.key});

  @override
  State<LaguageTranslationPage> createState() => _LaguageTranslationPageState();
}

class _LaguageTranslationPageState extends State<LaguageTranslationPage> {
  var languages=["hindi", "English","Arabic"];
  var originLanguage="From";
  var destinationLanguage="To";
  var output="";
  TextEditingController languageController=TextEditingController();
  
  void translate(String src, String dest,String input) async{
    GoogleTranslator translator= GoogleTranslator();
    var translation= await translator.translate(input,from: src,to: dest);
    setState(() {
      output=translation.text.toString();
    });
    if(src=='--' || dest=='--'){
      setState(() {
        output="failed to translate";
      });
    }
  }

  String getLanguageCode(String language){
    if(language=="English"){
      return "en";
    }
   else if(language=="hindi"){
      return "hi";
    }
   else if(language=="Arabic"){
      return "ar";
    }
    return "-- ";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      appBar: AppBar(
        title: Text("Language Translator"),centerTitle:  true,
        backgroundColor: Colors.lightBlueAccent[100],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(focusColor: Colors.grey,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    originLanguage,
                    style: TextStyle(color: Colors.white),
                  ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem(child:  Text(dropDownStringItem),value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        originLanguage=value!;
                      });                    },
                  ),
                  SizedBox(width: 40,),
                  Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                  SizedBox(width: 40,),
                  DropdownButton(focusColor: Colors.grey,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem(child:  Text(dropDownStringItem),value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String? value){
                    setState(() {
                      destinationLanguage=value!;
                    });
                      
                    },
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "please enter text",
                    labelStyle: TextStyle(fontSize: 15,color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                        )
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                    )
                  ),
                  controller: languageController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff2b3c5a)),
                    onPressed: (){
                    translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString(),);
                    }, child: Text("translate")),
              ),
              SizedBox(height: 20,),
              Text("\n$output",
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
