import 'package:construction_app/controllers/controller.dart';
import 'package:construction_app/models/product.dart';
import 'package:construction_app/screens/widgets/custom_text_field.dart';
import 'package:construction_app/screens/widgets/loading_dailog.dart';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Checkout extends StatelessWidget {
  Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController locationOneController = TextEditingController();
    TextEditingController locationTwoController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController postcodeController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    // "city": "Mangalore",
    //       "state": "KA",
    //       "postcode": "575001",
    //       "country": "IN",
    Position? position;
    List<Placemark>? placeMark;

    String completeAddress = '';

    getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position newPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPostion;

      placeMark = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placeMark![0];
      completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

      locationOneController.text = '${pMark.subLocality} ${pMark.locality}';
      locationTwoController.text = '${pMark.subAdministrativeArea}';
      cityController.text = '${pMark.subLocality} ${pMark.locality}';
      stateController.text = '${pMark.administrativeArea}';
      countryController.text = '${pMark.subLocality} ${pMark.locality}';
      postcodeController.text = '${pMark.postalCode}';
      // locationController.text = completeAddress;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "CHECKOUT ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      data: Icons.person,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      controller: lastNameController,
                      data: Icons.person,
                      hintText: "Last Name",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      controller: emailController,
                      data: Icons.email,
                      hintText: "Email",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      controller: phoneController,
                      data: Icons.phone,
                      hintText: "Phone",
                      isObsecre: false,
                    ),
                    CustomTextField(
                      controller: locationOneController,
                      data: Icons.my_location,
                      hintText: "Address One",
                      isObsecre: false,
                      enabled: false,
                    ),
                    CustomTextField(
                      controller: locationTwoController,
                      data: Icons.my_location,
                      hintText: "Address Two",
                      isObsecre: false,
                      enabled: false,
                    ),
                    CustomTextField(
                      controller: cityController,
                      data: Icons.my_location,
                      hintText: "City",
                      isObsecre: false,
                      enabled: false,
                    ),
                    CustomTextField(
                      controller: stateController,
                      data: Icons.my_location,
                      hintText: "State",
                      isObsecre: false,
                      enabled: false,
                    ),
                    CustomTextField(
                      controller: countryController,
                      data: Icons.my_location,
                      hintText: "Country",
                      isObsecre: false,
                      enabled: false,
                    ),
                    CustomTextField(
                      controller: postcodeController,
                      data: Icons.my_location,
                      hintText: "Postal Code",
                      isObsecre: false,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          getCurrentLocation();
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Get my location",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return const LoadingDailog(
                                  message: "Order Creating",
                                );
                              });
                          productController.createOrder(
                            nameController.text.toString().trim(),
                            lastNameController.text.toString().trim(),
                            emailController.text.toString().trim(),
                            phoneController.text.toString().trim(),
                            locationOneController.text.toString().trim(),
                            locationTwoController.text.toString().trim(),
                            cityController.text.toString().trim(),
                            stateController.text.toString().trim(),
                            countryController.text.toString().trim(),
                            postcodeController.text.toString().trim(),
                            productController.productCartList.entries
                                .map((e) => e),
                          );
                        },
                        child: Text('Order Place'))
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
