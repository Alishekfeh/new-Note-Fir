import 'message.dart';
validInput(String val,int min,int max){
  if (val.length>max) {
    return "$messageInputMax $max";
  }
  if (val.isEmpty) {
    return messageInputEmpty;
  }
  if (val.length<min) {
    return "$messageInputMin $min";
  }
  if (val.isEmpty) {
    return messageInputEmpty;
  }


}



//switch(variable) {
// case value:
//   //execute if variable is value
//   break;
// case value2:
//   //execute if variable is value2
//   break;
// default:
//  // code to be executed if variable is none
// }