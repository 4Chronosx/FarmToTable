import 'package:farm2you/commons.dart';
import 'package:farm2you/models/product_model.dart';

Container productWidget(double screenWidth, ProductModel item) {
  return Container(
    height: 200,
    width: screenWidth * 0.4,
    decoration: BoxDecoration(
        color: Colors.amberAccent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(99, 99, 99, 0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(
              0,
              2,
            ),
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Text(item.name,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        SizedBox(
          height: 5,
        ),
        Text(item.vendor,
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        SizedBox(
          height: 5,
        ),
        Text('${item.price}/${item.unit}',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.black))
      ],
    ),
  );
}
