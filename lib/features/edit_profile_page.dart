import 'package:flutter/material.dart';
import 'package:libertaspeople/shared_ui_elements/colors.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
// FocusNode function Used to control field Item and pass to another field
  final workAdressFocusNode = FocusNode();
  final managerFocusNode = FocusNode();
  final genderFocusNode = FocusNode();
  final workplaceTypeFocusNode = FocusNode();
  final ageGroupFocusNode = FocusNode();

  List<String> gender = ["Male", "Female"];
  List<String> workplaceType = ["An office", "A field or a farm", "Other"];
  List<String> ageGroup = ["18-25 years", "26-39 years", "40-60 years"];
  List<String> manager = ["Yes", "No"];

  String _genderStyle = "Female";
  String _workplaceTypeCurrent = "An office";
  String _agegroupcurrent = "26-39 years";
  String _managerValuerCurrent = "No";
  bool isEnabled = false;
  bool isReadOnly = true;

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    workAdressFocusNode.dispose();
    managerFocusNode.dispose();
    genderFocusNode.dispose();
    workplaceTypeFocusNode.dispose();
  }

  void saveForm() {
    final valid = _form.currentState.validate();
    if (!valid) {
      return;
    }
    _form.currentState.save();
  }

  void readWriteField() {
    setState(() {
      isReadOnly = false;
    });
  }

  void enableButton() {
    setState(() {
      isEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            isReadOnly = true;
          });
        },
        child: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 35.0, right: 35.0, bottom: 25.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Workplace ID",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                      readOnly: isReadOnly,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: readWriteField),
                        hintText: "0000000",
                        hintStyle: const TextStyle(
                            color: AppColors.darkBlue,
                            fontFamily: "WorkSansLight",
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(workAdressFocusNode);
                      },
                      // ignore: missing_return
                      validator: (value) {
                        final String itemTovalidate = (value.toString()).trim();
                        if (value.isEmpty) {
                          return "Please provide your Workplace ID";
                        } else if (itemTovalidate.isEmpty) {
                          return "Your Workplace ID cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Work address",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0),
                      readOnly: isReadOnly,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: readWriteField),
                        hintText: "XXXXXXXX street XX, XXXX City",
                        hintStyle: const TextStyle(
                            color: AppColors.darkBlue,
                            fontFamily: "WorkSansLight",
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                      focusNode: workAdressFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(genderFocusNode);
                      },
                      onSaved: (value) {},
                      validator: (value) {
                        final String itemTovalidate = (value.toString()).trim();
                        if (value.isEmpty) {
                          return "Please provide your Work Address";
                        } else if (itemTovalidate.length <= 4) {
                          return "Your Address cannot be less than 4 letters";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      items: gender.map((String genderItem) {
                        Icon currentSelect;
                        if (genderItem == _genderStyle) {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.green);
                        } else {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.grey);
                        }
                        return DropdownMenuItem(
                            value: genderItem,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(genderItem),
                                  currentSelect
                                ],
                              ),
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        FocusScope.of(context)
                            .requestFocus(workplaceTypeFocusNode);
                        setState(() {
                          _genderStyle = newValue as String;
                        });
                      },
                      onSaved: (newValue) {
                        setState(() {
                          _genderStyle = newValue as String;
                        });
                      },
                      validator: (String newValue) {
                        if (newValue.isEmpty) {
                          return "Please provide a value";
                        }
                        return null;
                      },
                      value: _genderStyle,
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
//                    focusNode: _GenderFocusNode,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Workplace type",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      items: workplaceType.map((String workplaceTypeItem) {
                        Icon currentSelect;
                        if (workplaceTypeItem == _workplaceTypeCurrent) {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.green);
                        } else {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.grey);
                        }
                        return DropdownMenuItem(
                            value: workplaceTypeItem,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(workplaceTypeItem),
                                currentSelect
                              ],
                            ));
                      }).toList(),
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35.0,
                      ),
                      onChanged: (newValue) {
                        FocusScope.of(context).requestFocus(ageGroupFocusNode);
                        setState(() {
                          _workplaceTypeCurrent = newValue as String;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _workplaceTypeCurrent = value as String;
                        });
                      },
//                    focusNode: _workplaceTypeFocusNode,
                      value: _workplaceTypeCurrent,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Age group",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      items: ageGroup.map((String ageGroupItem) {
                        Icon currentSelect;
                        if (ageGroupItem == _agegroupcurrent) {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.green);
                        } else {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.grey);
                        }
                        return DropdownMenuItem(
                            value: ageGroupItem,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(ageGroupItem),
                                currentSelect
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        FocusScope.of(context).requestFocus(managerFocusNode);
                        enableButton();
                        setState(() {
                          _agegroupcurrent = newValue as String;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _agegroupcurrent = value as String;
                        });
                      },
                      value: _agegroupcurrent,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please provide a value";
                        }
                        return null;
                      },
//                    focusNode: _ageGroupFocusNode,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35.0,
                      ),
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Manager",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      items: manager.map((managerItem) {
                        Icon currentSelect;
                        if (managerItem == _managerValuerCurrent) {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.green);
                        } else {
                          currentSelect = const Icon(Icons.check_circle_outline,
                              color: Colors.grey);
                        }
                        return DropdownMenuItem(
                          value: managerItem,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(managerItem),
                              currentSelect
                            ],
                          ),
                        );
                      }).toList(),
//                    focusNode: _managerFocusNode,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35.0,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _managerValuerCurrent = newValue as String;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          _managerValuerCurrent = value as String;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please provide a value";
                        }
                        return null;
                      },
                      value: _managerValuerCurrent,
                      style: const TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(width: 2.5, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 3.0, color: AppColors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: RaisedButton(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 70.0, right: 70.0),
                        color: isEnabled ? AppColors.orange : Colors.grey,
                        onPressed: isEnabled ? saveForm : null,
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
