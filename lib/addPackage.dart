import 'package:aaha/Agency.dart';
import 'package:aaha/editPackage.dart';
import 'package:aaha/otherDetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'MyBottomBarDemo.dart';
import 'signupAgency.dart';
import 'loginScreen.dart';
import 'MyBottomBarDemo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aaha/services/packageManagement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';
import 'package:aaha/pkg_detail_pg_travellers.dart';
import 'package:image_picker/image_picker.dart';
import 'otherDetails.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _descController = TextEditingController();
TextEditingController daysController = TextEditingController();
TextEditingController _priceController = TextEditingController();
TextEditingController _locationController = TextEditingController();

class addPackage extends StatefulWidget {
  const addPackage({Key? key}) : super(key: key);
  @override
  _addPackage createState() => _addPackage();
}

class _addPackage extends State<addPackage> {
  File? file;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  UploadTask? task;
  List<String> ImgUrls1 = [];
  String PhotoUrl='';
  @override
  Widget build(BuildContext context) {
    final filename =
        file != null ? file!.path.toString() : ('No file selected');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Package',
          style: (TextStyle(color: Colors.black, fontSize: 30)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 45.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                userInput('Package Name', TextInputType.text, _nameController),
                userInput('Description', TextInputType.text, _descController),
                userInput('Days', TextInputType.number, daysController),
                userInput('Price', TextInputType.number, _priceController),
                userInput('Location', TextInputType.text, _locationController),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.indigo.shade500,
                    onPressed: () {
                     selectImage();
                    },
                    child: Text(
                      'Add thumbnail photo',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.indigo.shade500,
                    onPressed: () {
                      if (daysController.text == '') {
                        showAlertDialog(
                            context: context,
                            title: 'Something went wrong',
                            content: 'Please enter a valid amount of days');
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => otherDetails(),
                        ));
                      }
                    },
                    child: Text(
                      'Add Daywise Details',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gallery',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 10),
                        child: IconButton(
                            onPressed: () {
                              //_imageFromGallery();
                              selectImages();
                            },
                            icon: Icon(Icons.camera_alt_outlined)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: GridView.builder(
                        itemCount: imageFileList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Image.file(
                                      File(imageFileList![index].path),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  task != null
                                      ? buildUploadStatus(task!)
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RaisedButton(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: Colors.indigo.shade800,
                    onPressed: () async {
                      print(ImgUrls1.length);
                      if (daysController.text == '') {
                        showAlertDialog(
                            context: context,
                            title: 'Something went wrong',
                            content: 'Please enter daywise details');
                      }
                      else{
                        await packageManagement.storeNewPackage(
                            FirebaseAuth.instance.currentUser,
                            _nameController.text,
                            _descController.text,
                            daysController.text,
                            _priceController.text,
                            _locationController.text,
                            0.0,
                            context,
                            ImgUrls1,
                            otherDetailsList,
                            PhotoUrl,
                            isSaved

                            );
                        setState(() {});
                        _nameController.clear();
                        _descController.clear();
                        daysController.clear();
                        _priceController.clear();
                        _locationController.clear();
                        otherDetailsList = [];
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectImage() async {
    final result = await imagePicker.pickImage(source: ImageSource.gallery );
    if (result == null) return;
    final path = File(result.path);
    setState(() {});
    final fileName = basename(path.path);
    final destination = '$fileName';
    int i = 1;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
      storage.ref().child(packageManagement.Packid + '___' + fileName);
      i = i + 1;
      String url = '';
      task = ref.putFile(path);
      setState(() {});
      TaskSnapshot taskSnapshot = await task!.whenComplete(() {});
      taskSnapshot.ref.getDownloadURL().then(
            (value) {
          url = value;
          PhotoUrl=url;
          print(PhotoUrl +
              '\n...................................................................................................................');
          print("Done: $value");
        },
      );

    } catch (e) {
      print('error occured');
      print(e);
    }
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
    await uploadFile(imageFileList!);
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future uploadFile(List _images) async {
    _images.forEach((_photo) async {
      if (_photo == null) {
        return;
      }
      ;
      File file = File(_photo.path);
      final fileName = basename(file.path);
      final destination = '$fileName';
      int i = 1;
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child(packageManagement.Packid + '___' + fileName);
        i = i + 1;
        String url = '';
        task = ref.putFile(file);
        setState(() {});
        TaskSnapshot taskSnapshot = await task!.whenComplete(() {});
        taskSnapshot.ref.getDownloadURL().then(
          (value) {
            url = value;
            ImgUrls1.add(url);
            print(ImgUrls1[0] +
                '\n...................................................................................................................');
            print("Done: $value");
          },
        );
        final urlString = ref.getDownloadURL();
      } catch (e) {
        print('error occured');
        print(e);
      }
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

Widget userInput(
    String hintTitle, TextInputType keyboardType, TextEditingController a) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintTitle,
          hintStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
        keyboardType: keyboardType,
        controller: a,
      ),
    ),
  );
}

showAlertDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext contextAletDialog) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(content ?? ""),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(contextAletDialog);


              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Continue'),
              ),
            ),
          ],
        );
      });
}
