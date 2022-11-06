import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/profile_controller.dart';
import 'package:sisterhood_app/screen/Dashboard/profile/profile_page.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/custom_button.dart';
import 'package:sisterhood_app/utill/email_validation.dart';
import 'package:sisterhood_app/utill/extension.dart';
import 'package:sisterhood_app/utill/images.dart';
import 'package:sisterhood_app/utill/styles.dart';

class EditProfilePage extends StatefulWidget {
  final dynamic profileData;
  const EditProfilePage({Key key, this.profileData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _userName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _city = TextEditingController();
  final _address = TextEditingController();
  final _zipCode = TextEditingController();
  File image;
  String userImage = "";
  File _pickedImage;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  bool isLoad = false;
  final profileController = Get.put(ProfileController());

  _trySubmit() async {
    if (profileController.file == null) {
      setState(() {
        isLoad = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
            'firstname': _firstName.text,
            'middleName': _middleName.text,
            'lastname': _lastName.text,
            'mobile': _phoneNumber.text,
            'address': _address.text,
            'city': _city.text,
            'zipcode': _zipCode.text,
            'updatedDate': DateTime.now().day.toString() +
                "/" +
                DateTime.now().month.toString() +
                "/" +
                DateTime.now().year.toString(),
          })
          .then((value) => print("Updated"))
          .catchError((onError) => print("error"));

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => ProfilePage()));

      Fluttertoast.showToast(msg: context.loc.profile_updated_success);

      setState(() {
        isLoad = false;
      });
    } else {
      setState(() {
        isLoad = true;
      });

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(_auth.currentUser.uid + '.jpg');
      await ref.putFile(profileController.file);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({
            'firstname': _firstName.text,
            'middleName': _middleName.text,
            'lastname': _lastName.text,
            'mobile': _phoneNumber.text,
            'address': _address.text,
            'city': _city.text,
            'zipcode': _zipCode.text,
            'image_url': url,
            'updatedDate': DateTime.now().day.toString() +
                "/" +
                DateTime.now().month.toString() +
                "/" +
                DateTime.now().year.toString(),
          })
          .then((value) => print("Updated"))
          .catchError((onError) => print("error"));

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => ProfilePage()));

      Fluttertoast.showToast(msg: context.loc.profile_updated_success);

      setState(() {
        isLoad = false;
      });
    }
  }

  @override
  void initState() {
    _firstName.text = widget.profileData['firstname'];
    _lastName.text = widget.profileData['lastname'];
    _middleName.text = widget.profileData['middleName'];
    _phoneNumber.text = widget.profileData['mobile'];
    _city.text = widget.profileData['city'];
    if (widget.profileData['address'] != null) {
      _address.text = widget.profileData['address'];
    }
    _zipCode.text = widget.profileData['zipcode'];
    userImage = widget.profileData['image_url'];
    profileController.file == null;
    print('ll');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorResources.background,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 10),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left_outlined,
                      color: ColorResources.grey,
                      size: 35,
                    )),
              ],
            ),
          ),
          // title: Image.asset(Images.logo,width: 50,),
          actions: [
            InkWell(
              onTap: () => exit(0),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  Images.loginImage,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: Center(
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorResources.box_border,
                                              width: 2,
                                            ),
                                            color:
                                                ColorResources.box_background,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            // image:  const DecorationImage(
                                            //   image:  AssetImage(Images.profileImage,),
                                            //   fit: BoxFit.fill,
                                            // )
                                          ),
                                          child: userImage == ""
                                              ? Obx(
                                                  () => profileController
                                                              .selectedImagePath
                                                              .value ==
                                                          ''
                                                      ? CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              ColorResources
                                                                  .background,
                                                          child: Image.asset(
                                                            Images.profileImage,
                                                            height: 100,
                                                            width: 100,
                                                          ),
                                                          // backgroundImage: NetworkImage(image),
                                                        )
                                                      : ClipOval(
                                                          child: Image.file(
                                                          File(profileController
                                                              .selectedImagePath
                                                              .value),
                                                          fit: BoxFit.cover,
                                                        )),
                                                )
                                              : Obx(
                                                  () => profileController
                                                              .selectedImagePath
                                                              .value ==
                                                          ''
                                                      ? ClipOval(
                                                          child: Image.network(
                                                          userImage,
                                                          fit: BoxFit.cover,
                                                        ))
                                                      : ClipOval(
                                                          child: Image.file(
                                                          File(profileController
                                                              .selectedImagePath
                                                              .value),
                                                          fit: BoxFit.cover,
                                                        )),
                                                ),
                                        )),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorResources.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.asset(
                                                  Images.exportImage,
                                                  scale: 3,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.first_name,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _firstnameField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.middle_name,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _middlenameField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.last_name,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _lastnameField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.phone_number,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _phoneNumberField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.address,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _addressField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.city,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources
                                          .profilePlaceholderColor)),
                              SizedBox(
                                height: 5,
                              ),
                              _cityField(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.loc.zip_code,
                                  style: arialFont16W600.copyWith(
                                      color: ColorResources.grey)),
                              SizedBox(
                                height: 5,
                              ),
                              _zipcodeField(),
                            ],
                          ),
                          SizedBox(height: 30),
                          if (isLoad)
                            Center(child: CircularProgressIndicator())
                          else
                            _continuebutton(),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                ))));
  }

  _continuebutton() {
    return GestureDetector(
      onTap: () => _trySubmit(),
      child: CustomButton(
          text1: context.loc.save, text2: "", width: Get.width, height: 60),
    );
  }

  _firstnameField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _firstName,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.first_name,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_first_name;
          }
          return null;
        },
      ),
    );
  }

  _middlenameField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _middleName,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.middle_name,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_middle_name;
          }
          return null;
        },
      ),
    );
  }

  _lastnameField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _lastName,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.last_name,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_last_name;
          }
          return null;
        },
      ),
    );
  }

  _emailaddressField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _emailAddress,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.email_address,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) => validateEmail(value),
      ),
    );
  }

  _usernameField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _userName,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.user_name,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_user_name;
          }
          return null;
        },
      ),
    );
  }

  _phoneNumberField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _phoneNumber,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.phone_number,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_phone_number;
          }
          return null;
        },
      ),
    );
  }

  _addressField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _address,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.address,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_your_address;
          }
          return null;
        },
      ),
    );
  }

  _cityField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _city,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.city,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.please_enter_city;
          }
          return null;
        },
      ),
    );
  }

  _zipcodeField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorResources.box_border,
          width: 1,
        ),
        color: ColorResources.box_background,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      alignment: Alignment.topCenter,
      child: TextFormField(
        controller: _zipCode,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.bottom,
        style: arialFont18W600,
        decoration: InputDecoration(
          hintText: context.loc.zip_code,
          hintStyle: arialFont18W600,
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return context.loc.plese_enter_your_zip_code;
          }
          return null;
        },
      ),
    );
  }

  void _showPicker(context) {
    final signupController = Get.put(ProfileController());

    showModalBottomSheet(
        // enableDrag: false,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      size: 35,
                    ),
                    title: Text(
                      context.loc.camera,
                      style: arialFont18W600,
                    ),
                    onTap: () {
                      signupController.getImage(ImageSource.camera, context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    size: 35,
                  ),
                  title: Text(
                    context.loc.gallery,
                    style: arialFont18W600,
                  ),
                  onTap: () {
                    signupController.getImage(ImageSource.gallery, context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
