import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  final _auth = FirebaseAuth.instance;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
   File file;

  void getImage(ImageSource imageSource,BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile!=null) {
      selectedImagePath.value = pickedFile.path;
      file = File(pickedFile.path);
      selectedImageSize.value = ((File(selectedImagePath.value)).lengthSync()/1024/1024).toStringAsFixed(2)+"Mb";
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      // Fluttertoast.showToast(msg: _auth.currentUser.uid.toString());
      // final ref = FirebaseStorage.instance
      //     .ref()
      //     .child('user_image')
      //     .child(_auth.currentUser.uid + '.jpg'
      // );
      // await ref.putFile(file);
      // final url = await ref.getDownloadURL();
      //
      // await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).update({
      //   'firstname': '',
      //   'middleName': '',
      //   'lastname': '',
      //   'mobile': '',
      //   'city': '',
      //   'zipcode': '',
      //   'image_url': '',
      //   'updatedDate': DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
      // }).then((value) => print("Updated")).catchError((onError)=>print("error"));

     // await Provider.of<ApiManager>(context,listen: false).uploadimageApi(base64Image);

    }else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}

