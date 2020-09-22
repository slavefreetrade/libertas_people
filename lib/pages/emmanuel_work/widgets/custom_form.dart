import 'package:flutter/material.dart';
import 'package:libertaspeople/constants/colors.dart';

class CustomForm extends StatefulWidget {

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {


  final _WorkAdressFocusNode = FocusNode();
  final _managerFocusNode = FocusNode();
  final _GenderFocusNode = FocusNode();
  final _workplaceTypeFocusNode = FocusNode();

   List<String> gender = ["Male", "Female"];
   List<String> workplaceType = ["An office", "A field or a farm", "Other"];
   List<String> ageGroup = ["18-25 years", "26-39 years", "40-60 years"];
   List<String> manager = ["Yes", "No"];

   String _genderStyle = "Female";
   String _workplaceType = "An office";
   var _agegroupcategory = "26-39 years";
   String _managerValuer = "No";




  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.only(top: 25.0, left: 35.0, right: 35.0, bottom: 25.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Workplace ID",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.0,),
                TextFormField(
                  style: TextStyle(
                    color: ColorConstants.darkBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "0000000",
                    hintStyle: TextStyle(
                        color: ColorConstants.darkBlue,
                        fontFamily: "WorkSansLight",
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.5, color: Colors.grey),
                    ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10.0),
                     borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                   ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_WorkAdressFocusNode);
                  },
                  // ignore: missing_return
                  validator: (value){
                    if(value.isEmpty){
                      return "Please provide a value";
                    }
                    return null;
                  },
                  /*  onSaved: (value){
                _profileInformation = Profile(
                    title: value,
                    price: _profileInformation.price,
                    description: _profileInformation.description,
                    comment: _profileInformation.comment
                );
              },*/
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Work address",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 5.0,),
                TextFormField(
                  style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintText: "XXXXXXXX street XX, XXXX City",
                    hintStyle: TextStyle(
                        color: ColorConstants.darkBlue,
                        fontFamily: "WorkSansLight",
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.5, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                    ),
                  ),
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  focusNode: _WorkAdressFocusNode,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_GenderFocusNode);
                  },
                  /*  onSaved: (value){
                _profileInformation = Profile(
                    title: _profileInformation.title,
                    price: _profileInformation.price,
                    description: value,
                    comment: _profileInformation.comment
                );
              },*/
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.0,),
                DropdownButtonFormField(
                  items: gender.map((String category) {
                    return new DropdownMenuItem(
                        value: category,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            children: <Widget>[
                              Text(category),
                            ],
                          ),
                        )
                    );
                  }).toList(),
                  onChanged: (newValue){
                    _genderStyle = newValue;
                  },
                  value: _genderStyle,
                  style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0
                  ),
                  focusNode: _GenderFocusNode,
                  icon: Icon(Icons.keyboard_arrow_down, size: 35.0,),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.5, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Workplace type",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.0,),
                DropdownButtonFormField(
                    items: workplaceType.map((String workplacecategory) {
                      return new DropdownMenuItem(
                          value: workplacecategory,
                          child: Row(
                            children: <Widget>[
                              Text(workplacecategory),
                            ],
                          )
                      );
                    }).toList(),
                  style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0
                  ),
                  icon: Icon(Icons.keyboard_arrow_down, size: 35.0,),
                  onChanged: (newValue){
                     setState(() {
                       _workplaceType = newValue;
                     });
                   },
                  focusNode: _workplaceTypeFocusNode,
                  value: _workplaceType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.5, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Age group",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.0,),
                DropdownButtonFormField(
                    items: ageGroup.map((String agegroupcategory) {
                      return new DropdownMenuItem(
                          value: agegroupcategory,
                          child: Row(
                            children: <Widget>[
                              Text(agegroupcategory),
                            ],
                          )
                      );
                    }).toList(),
                    onChanged: (String newValue){
                      setState(() {
                        _agegroupcategory = newValue;
                      });
                    },
                  icon: Icon(Icons.keyboard_arrow_down, size: 35.0,),
                  value: _agegroupcategory,
                  style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 2.5, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manager",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.0,),
                DropdownButtonFormField(
                    items: manager.map((String managerItem) {
                      return new DropdownMenuItem(
                        value: managerItem,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(managerItem),
                           // Icon(Icons.check)
                          ],
                        ),
                      );
                    }).toList(),
                    focusNode: _managerFocusNode,
                    icon: Icon(Icons.keyboard_arrow_down, size: 35.0,),
                    onChanged: (newValue){
                      setState(() {
                        _managerValuer = newValue;
                      });
                    },
                    value: _managerValuer,
                    style: TextStyle(
                      color: ColorConstants.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0
                  ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 3.0, color: ColorConstants.orange),
                        ),
                      ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(

                  borderRadius: BorderRadius.circular(40),
                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 70.0, right: 70.0),
                    color: ColorConstants.orange,
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 22.0 ),),
                    onPressed: () {},
                  ),
                ),
                ],
              ),
            SizedBox(height: 20.0),
            ],
        ),
      ),
    );
  }
}
