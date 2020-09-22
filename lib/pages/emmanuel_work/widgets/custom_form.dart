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
  final _ageGroupFocusNode = FocusNode();

   List<String> gender = ["Male", "Female"];
   List<String> workplaceType = ["An office", "A field or a farm", "Other"];
   List<String> ageGroup = ["18-25 years", "26-39 years", "40-60 years"];
   List<String> manager = ["Yes", "No"];

   String _workID;
   String _workAddress;
   String _genderStyle = "Female";
   String _workplaceTypeCurrent = "An office";
   String _agegroupcurrent = "26-39 years";
   String _managerValuerCurrent = "No";

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _WorkAdressFocusNode.dispose();
    _managerFocusNode.dispose();
    _GenderFocusNode.dispose();
    _workplaceTypeFocusNode.dispose();
  }

  // Function used to valid Form
  _saveForm(){
  /*  final valid = _form.currentState.validate();
    if(valid){
      return;
    }*/
    _form.currentState.save();

    print("****************** Print current Form Valuer **********************");

    print("Work ID: $_workID");
    print("Work Address: $_workAddress ");
    print("Your Gender: ${_genderStyle}");
    print("Workplace Type: ${_workplaceTypeCurrent}");
    print("Your age group: ${_agegroupcurrent}");
    print("You are manager: ${_managerValuerCurrent}");
  }

  bool isEnabled = true;

  enableButton(){
    setState(() {
      isEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
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
                  textInputAction: TextInputAction.next,
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
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_WorkAdressFocusNode);
                  },

                  // ignore: missing_return
                /*  validator: (value){
                    if(value.isEmpty){
                      return "Please provide a value";
                    }
                    return null;
                  },*/
                /*  onChanged: (value){
                    setState(() {
                      _workID = value;
                    });
                  },*/
                  onSaved: (value){
                      _workID = value;
                  },
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
                  textInputAction: TextInputAction.next,
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
                  focusNode: _WorkAdressFocusNode,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_GenderFocusNode);
                  },
                  onChanged: (value){
                      _workAddress = value;
                  },
                  onSaved: (value){
                      _workAddress = value;
                  },
                /*  validator: (value){
                    if(value.isEmpty){
                      return "Please provide a value";
                    }
                    return null;
                  }, */
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
                  items: gender.map((String genderItem) {
                    return new DropdownMenuItem(
                        value: genderItem,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                            children: <Widget>[
                              Text(genderItem),
                            ],
                          ),
                        )
                    );
                  }).toList(),
                  onChanged: (newValue){
                    FocusScope.of(context).requestFocus(_workplaceTypeFocusNode);
                    setState(() {
                      _genderStyle = newValue;
                    });
                  },
                  onSaved: (newValue){
                    setState(() {
                        _genderStyle = newValue;
                    });
                  },
                  validator: (newValue){
                    if(newValue.isEmpty){
                      return "Please provide a value";
                    }
                    return null;
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
                    items: workplaceType.map((String workplaceTypeItem) {
                      return new DropdownMenuItem(
                          value: workplaceTypeItem,
                          child: Row(
                            children: <Widget>[
                              Text(workplaceTypeItem),
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
                     FocusScope.of(context).requestFocus(_ageGroupFocusNode);
                     setState(() {
                       _workplaceTypeCurrent = newValue;
                     });
                  },
                  onSaved: (value){
                    setState(() {
                      _workplaceTypeCurrent = value;
                    });
                  },
                  focusNode: _workplaceTypeFocusNode,
                  value: _workplaceTypeCurrent,
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
                  items: ageGroup.map((String ageGroupItem) {
                    return new DropdownMenuItem(
                        value: ageGroupItem,
                        child: Row(
                          children: <Widget>[
                            Text(ageGroupItem),
                          ],
                        )
                    );
                  }).toList(),
                  onChanged: (newValue){
                    FocusScope.of(context).requestFocus(_managerFocusNode);
                   // enableButton();
                    setState(() {
                      _agegroupcurrent = newValue;
                    });
                  },
                  onSaved: (value){
                    setState(() {
                      _agegroupcurrent = value;
                    });
                  },
                  value: _agegroupcurrent,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please provide a value";
                    }
                    return null;
                  },
                  focusNode: _ageGroupFocusNode,
                  icon: Icon(Icons.keyboard_arrow_down, size: 35.0,),
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
                    items: manager.map((managerItem) {
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
                        _managerValuerCurrent = newValue;
                      });
                    },
                    onSaved: (value){
                      setState(() {
                        _managerValuerCurrent = value;
                      });
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return "Please provide a value";
                      }
                      return null;
                    },
                    value: _managerValuerCurrent,
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
                    color: isEnabled ? ColorConstants.orange : Colors.grey,
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 22.0 ),),
                    onPressed: _saveForm

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
