import 'package:aaha/Agency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AgHomeAgView.dart';
import 'services/agencyManagement.dart';
import 'services/packageManagement.dart';
class AgencyHome extends StatefulWidget {
  const AgencyHome({Key? key}) : super(key: key);

  @override
  State<AgencyHome> createState() => AgencyHomeState();
}

class AgencyHomeState extends State<AgencyHome> {
  void initState() {
    PackageList=[];
    packageManagement.p1=[];
    WidgetsBinding.instance?.addPostFrameCallback((_){
      context.read<packageProvider>().setPackages(FirebaseAuth.instance.currentUser!.uid);


    });




  }
  static String Agencyname='';
  final List<String> images = [
    'https://wander-lush.org/wp-content/uploads/2020/01/PhanderLakePakistanKanokwanPonokCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/Beautiful-places-in-Pakistan-Hingol-National-Park-LukasBischoffGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/MargalaHillsPakistanNaqshCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/KatpanaColdDesertPakistanSuthidaloedchaiyapanCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Naltar-Valley-lake-MolviDSLRGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/RohtasFortPakistanSimonImagesCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/RakaposhiMountainPakistanSkazzjyCanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Swat-Valley-KhwajaSaeedGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Hunza-Valley-undefinedGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/12/Beautiful-places-in-Pakistan-Passu-Cones-SiddiquiGetty-CanvaPro.jpg',
    'https://wander-lush.org/wp-content/uploads/2020/01/PassuConesPakistanSuthidaloedchaiyapanCanvaPro.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child :Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        title: FutureBuilder<String>(
          future: context
              .read<agencyProvider>()
              .getName(FirebaseAuth.instance.currentUser),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Agencyname=snapshot.data!.toString();
              return Text(
                'Hi, ' + snapshot.data!.toString(),
                style: TextStyle(color: Colors.black),
              );
            }
            return CircularProgressIndicator(
              color: Colors.black,
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                packageManagement.p1=[];
                PackageList=[];
                FirebaseAuth.instance.signOut();

                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 250,
            width: 400,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                //color: Colors.blue,
                image: DecorationImage(
              image: NetworkImage(
                'https://wallpaperaccess.com/full/51364.jpg',
              ),
              fit: BoxFit.fill,
            )),
            child: const Text(
              'WELCOME !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                // fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(
                    'Your Top selling Packages',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: InkWell(
                    child: const Text(
                      'see all',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AgHomeAgView()));
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index.isOdd) {
                            return const VerticalDivider(
                              width: 5,
                              color: Colors.white,
                            );
                          }

                          return ClipRRect(
                            borderRadius:
                                BorderRadius.circular(25), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50), // Image radius
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                      fit: BoxFit.cover),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Kashmir',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(
                  'Recently Added Packages',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: InkWell(
                    child: const Text(
                      'see all',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AgHomeAgView()));
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
            child: SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index.isOdd) {
                            return const VerticalDivider(
                              width: 5,
                              color: Colors.white,
                            );
                          }

                          return ClipRRect(
                            borderRadius:
                                BorderRadius.circular(25), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50), // Image radius
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                      fit: BoxFit.cover),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Karachi',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
