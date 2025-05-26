import 'package:farm2you/commons.dart';

class VendorStandardButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool addShadow;

  const VendorStandardButton({
    super.key,
    this.text = 'Start Selling',
    this.onPressed,
    this.backgroundColor = const Color(0xFFF0D003),
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.margin = const EdgeInsets.all(20),
    this.width = 300,
    this.height = 44,
    this.addShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        width: width,
        height: height,
        decoration: addShadow
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              )
            : null,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: EdgeInsets.zero,
            minimumSize: Size(width ?? 300, height ?? 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation:
                0, // Remove default elevation since we're using custom shadow
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Poppins',
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
