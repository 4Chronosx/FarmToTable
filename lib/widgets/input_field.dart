import 'package:farm2you/commons.dart';

Container detailsInputField(
    double screenWidth,
    double screenHeight,
    TextEditingController textEditingControllerVar,
    Icon myIcon,
    String placeholder) {
  return Container(
    width: screenWidth * 0.7,
    height: 50,
    margin: EdgeInsets.all(1.0),
    decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.24),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 3),
          ),
        ]),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(left: 30, right: 20), child: myIcon),
          Expanded(
            child: TextField(
              controller: textEditingControllerVar,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: placeholder),
            ),
          ),
        ]),
  );
}
