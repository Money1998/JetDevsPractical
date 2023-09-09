import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.title,
      this.color,
      this.onTap,
      this.isLoading,
      this.isIcon,
      this.style,
      this.width})
      : super(key: key);

  final String? title;
  final Color? color;
  final double? width;
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final bool? isLoading;
  final bool? isIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? const Color(0xFF16B98D),
        ),
        child: SizedBox(
          width: width,
          child: Center(
            child: _child(),
          ),
        ),
      ),
    );
  }

  Widget _child() {
    if (isLoading ?? false) {
      return const SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            color: white,
            strokeWidth: 2,
          ));
    } else {
      if (isIcon == true && isIcon != null) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? '',
                style: style ??
                    GoogleFonts.ibmPlexSans(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.add_circle)
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            title ?? '',
            style: style ??
                GoogleFonts.ibmPlexSans(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
          ),
        );
      }
    }
  }
}
