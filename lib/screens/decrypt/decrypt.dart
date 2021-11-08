import 'package:cryptool/app.dart';
import 'package:flutter/material.dart';

import '../../style.dart';

class DecryptionScreen extends StatelessWidget {
  final _keyController = TextEditingController();
  final _cipherTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Decrypt',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),

              //Key input
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: _keyController,
                  decoration: InputDecoration(
                    hintText: 'Key ....',
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              //Plain Text box
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                padding: EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: TextField(
                  controller: _cipherTextController,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Cipher Text....',
                    border: InputBorder.none,
                  ),
                ),
              ),

              //Encrypt Button
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.black45),
                child: FlatButton(
                  onPressed: () => _onDecryptTap(
                    context,
                    _keyController.text,
                    _cipherTextController.text,
                  ),
                  child: Text(
                    'Decrypt',
                    style: StyleMaker.buttonTextStyle(
                      fontColor: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onDecryptTap(BuildContext context, String key, String text) {

    for(int i = 0; i<4; i++){
      print("Before reverse transpose:  $text");
      text = reverseTransposeCharacters(text);
      print("After reverse transpose  $text");
      text = reverseKeyProcess(text, key);
      print("After reverse key process $text");
    }


    Navigator.pushNamed(context, ResultRoute,
        arguments: {"key": key, "resultingText": text, "isCipher": true});
  }
}
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}

Iterable<String> splitStringByFour(String text){
  RegExp rx = new RegExp(r".{1,4}(?=(.{4})+(?!.))|.{1,4}$");
  return rx.allMatches(text).map((m) => m.group(0));
}


String shiftCharToLeft(String textArray, int shiftBy){
  for (int i = 0; i < shiftBy; i++) //Repeats the procedure until the shift value is reached.
      {
    textArray = textArray.substring(1) + textArray.substring(0,1); //places the first character at the last position and shifts everything to the left by 1 place.
  }

  return textArray;
}

String keyProcess(String text, String key)
{
  int index = 0;
  for(int i = 0; i<16; i++){
    index = _chars.indexOf(text[i]) + _chars.indexOf(key[i]);
    if(index>_chars.length-1){
      index = index - _chars.length;
    }
    text = replaceCharAt(text, i, _chars[index]);
  }
  return text;
}

String reverseKeyProcess(String text, String key){
  int index = 0;
  for(int i = 0; i<16; i++){
    index = _chars.indexOf(text[i]) - _chars.indexOf(key[i]);
    if(index<0){
      index = index + _chars.length;
    }
    text = replaceCharAt(text, i, _chars[index]);
  }
  return text;
}

String reverseTransposeCharacters(String text){
  List textArray = splitStringByFour(text).toList();

  textArray[1] = shiftCharToLeft(textArray[1], 3);
  textArray[2] = shiftCharToLeft(textArray[2], 2);
  textArray[3] = shiftCharToLeft(textArray[3], 1);

  text = textArray.join();
  return text;
}