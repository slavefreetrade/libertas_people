import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../shared_ui_elements/app_fonts.dart';

class Principle extends StatelessWidget {
  final String logo;
  final String title;
  final String text;

  const Principle({Key key, this.logo, this.title, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).principle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage(logo),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: width * 0.6,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: AppFonts.roboto,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
