import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide(color: Colors.white24)
                  //borderSide: const BorderSide(),
                ),

                hintStyle: TextStyle(color: Colors.white,fontFamily: "WorkSansLight"),
                filled: true,
                fillColor: Colors.white24,
                hintText: 'Password'),
          ),
        ],
      ),
    );
  }
}
