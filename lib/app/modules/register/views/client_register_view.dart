import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/services/api_service.dart';
import 'package:medicalsupport/app/routes/app_pages.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:medicalsupport/config/app_contents.dart';
import 'package:medicalsupport/config/common_textfield.dart';
import 'package:medicalsupport/config/common_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicalsupport/config/snackbar_helper.dart';

import '../controllers/register_controller.dart';
import 'package:medicalsupport/app/modules/login_screen/controllers/login_screen_controller.dart';

// ignore: must_be_immutable
class ClientRegisterView extends GetView<RegisterController> {
  ClientRegisterView({super.key});

  //final LoginScreenController loginScreenController = Get.find();
  final ApiService apiService = Get.put(ApiService());
  final LoginScreenController loginScreenController = Get.put(LoginScreenController(Get.find<ApiService>()));
  
  
  final RegisterController registerController = Get.find();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordconfirmationController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  //final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _firstnameFocusNode = FocusNode();
  final FocusNode _lastnameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordconfirmationFocusNode = FocusNode();
  final FocusNode _companynameFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  //final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _zipcodeFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  
  GoogleSignIn signIn = GoogleSignIn();
  void googleSignin(int flag) async {
    try {
      var user = await signIn.signIn();
	  if (user != null) {
		// Serialize the user object into a Map
		Map<String, dynamic> userMap = {
		'displayName': user.displayName ?? 'Unknown',
		'email': user.email,
		'id': user.id,
		'photoUrl': user.photoUrl,
		'userType': flag,
		};

		// Pass the entire serialized user object to the controller
		loginScreenController.googleLogin(userMap);
	  }else{
		SnackbarHelper.showErrorSnackbar(
		  title: Appcontent.snackbarTitleError, 
		  message: "Sign-in cancelled by user",
		  position: SnackPosition.BOTTOM, // Custom position
		);
	  }
    } catch(error) {
      SnackbarHelper.showErrorSnackbar(
		title: Appcontent.snackbarTitleError, 
		message: "$error",
		position: SnackPosition.BOTTOM, // Custom position
	  );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
	// Fetch the country list when the view loads
    //registerController.fetchCountryList();
	
    return Scaffold(
	  backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
				Padding(
                    padding: const EdgeInsets.all(20),
					child: Form(
					  key: _formKey,
					  child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
						  Padding(
							padding: const EdgeInsets.all(10),
							child: GestureDetector(
							  onTap: () => Get.back(),
							  child: Icon(Icons.keyboard_backspace, color: AppColor.black, size: 24.0),
							),
						  ),
						  const Padding(
							padding: EdgeInsets.only(left: 10, top: 1),
							child: Text(Appcontent.signUpClient,
							  style: TextStyle(
								fontSize: 32,
								fontWeight: FontWeight.bold,
								fontFamily: 'Urbanist-bold'
							  ),
							  textAlign: TextAlign.start,
							  overflow: TextOverflow.ellipsis,
							),
						  ),
							Padding(
								padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
								child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
									children: [	
									  // Text Field
									  autoWidthTextField(
										text: Appcontent.placeholderFirstName,
										text1: 'First Name',
										width: screenWidth,
										controller: firstnameController,
										focusNode: _firstnameFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'First name cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  /*if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }*/
										},
									  ),
									  /*
									  // Label Above the TextField
									  Text(
										Appcontent.lastName,
										style: TextStyle(
										  fontSize: 16,
										  color: AppColor.formLabelColor, // Or any color you prefer
										),
									  ),
									  const SizedBox(height: 8), // Space between label and text field
									  */
									  // Text Field
									  autoWidthTextField(
										text: Appcontent.placeholderLastName,
										text1: 'Last Name',
										width: screenWidth,
										controller: lastnameController,
										focusNode: _lastnameFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Last name cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
									  ),
									/*  
									// Label Above the TextField
									Text(
										Appcontent.email,
										style: TextStyle(
											fontSize: 16,
											color: AppColor.formLabelColor, // Or any color you prefer
										),
									),
									const SizedBox(height: 8), // Space between label and text field
									*/
									autoWidthTextField(
									  text: Appcontent.placeholderEmail,
									  text1: 'Email Address',
									  width: screenWidth,
									  controller: emailController,
									  focusNode: _emailFocusNode,
									  validator: (value) {
										if (value == null || value.isEmpty) {
										  return 'Email cannot be blank';
										}
										final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
										if (!emailRegex.hasMatch(value)) {
										  return 'Please enter a valid email address';
										}
										return null;
									  },
									  onChanged: (value) {
										if (value.isNotEmpty) {
										  _formKey.currentState?.validate();
										}
									  },
									),
									// Text Field
									autoWidthTextField(
										text: 'Enter Contact Number',
										text1: 'Contact Number',
										width: screenWidth,
										controller: phoneController,
										focusNode: _phoneFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Phone number cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
									),
									// Text Field
									autoWidthTextField(
										text: 'Enter Fax Number',
										text1: 'Fax Number',
										width: screenWidth,
										controller: phoneController,
										focusNode: _phoneFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Phone number cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
									),
									// Text Field
									autoWidthTextField(
										text: Appcontent.placeholdercompanyName,
										text1: 'Company Name',
										width: screenWidth,
										controller: companynameController,
										focusNode: _companynameFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Company name cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
									),
									// Text Field
									autoWidthTextField(
										text: 'Enter Username',
										text1: 'Create Username',
										width: screenWidth,
										controller: companynameController,
										focusNode: _companynameFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Company name cannot be blank';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
									),
									Obx(() {
									  return autoWidthTextField(
										text: Appcontent.placeholderPassword,
										text1: 'Password',
										width: screenWidth,
										controller: passwordController,
										obscureText: registerController.showPassword.value,
										focusNode: _passwordFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Password cannot be blank';
										  }
										  if (value.length < 8) {
											return 'Password must be at least 8 characters';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
										suffixIcon: InkWell(
										  onTap: () {
											registerController.changePasswordHideAndShow();
										  },
										  child: SizedBox(
											height: 20,
											width: 20,
											child: Center(
											  child: registerController.showPassword.value
												  ? const Icon(Icons.visibility_off, color: Color(0xff94A3B8))
												  : const Icon(Icons.visibility_outlined, color: Color(0xff94A3B8)),
											),
										  ),
										),
									  );
									}),
									/*
									// Label Above the TextField
									Text(
										Appcontent.confirmPassword,
										style: TextStyle(
											fontSize: 16,
											color: AppColor.formLabelColor, // Or any color you prefer
										),
									),
									const SizedBox(height: 8), // Space between label and text field
									*/
									Obx(() {
									  return autoWidthTextField(
										text: Appcontent.placeholderPassword,
										text1: 'Confirm Password',
										width: screenWidth,
										controller: passwordconfirmationController,
										obscureText: registerController.showCPassword.value,
										focusNode: _passwordconfirmationFocusNode,
										validator: (value) {
										  if (value == null || value.isEmpty) {
											return 'Password cannot be blank';
										  }
										  if (value.length < 8) {
											return 'Password must be at least 8 characters';
										  }
										  return null;
										},
										onChanged: (value) {
										  if (value.isNotEmpty) {
											_formKey.currentState?.validate();
										  }
										},
										suffixIcon: InkWell(
										  onTap: () {
											registerController.changeCPasswordHideAndShow();
										  },
										  child: SizedBox(
											height: 20,
											width: 20,
											child: Center(
											  child: registerController.showCPassword.value
												  ? const Icon(Icons.visibility_off, color: Color(0xff94A3B8))
												  : const Icon(Icons.visibility_outlined, color: Color(0xff94A3B8)),
											),
										  ),
										),
									  );
									}),
									],
								),
							),
						  const SizedBox(height: 20),
						  Obx(() {
								final selectedCountryValue = registerController.selectedCountry.value;
								final selectedStateValue = registerController.selectedState.value;
								final selectedCityValue = registerController.selectedCity.value;

								// Handle potential parsing issues
								final countryId = selectedCountryValue?.isNotEmpty ?? false
								? int.tryParse(selectedCountryValue ?? '') // Handle null case
								: null;

								final stateId = selectedStateValue?.isNotEmpty ?? false
								  ? int.tryParse(selectedStateValue ?? '')
								  : null;
								  
								 final cityId = selectedCityValue?.isNotEmpty ?? false
								  ? int.tryParse(selectedCityValue ?? '')
								  : null;
								  
								return autoWidthBtn(
								  text: registerController.isLoading.value ? 'Sign Up...' : 'Sign Up',
								  width: screenWidth,
								  onPress: registerController.isLoading.value
									  ? null
									  : () {
										  if (_formKey.currentState!.validate()) {
											final firstname = firstnameController.text.trim();
											final lastname = lastnameController.text.trim();
											final email = emailController.text.trim();
											final password = passwordController.text.trim();
											final passwordconfirmation = passwordconfirmationController.text.trim();
											final companyname = companynameController.text.trim();
											final address = addressController.text.trim();
											//final city = cityController.text.trim();
											final zipcode = zipcodeController.text.trim();
											final phone = phoneController.text.trim();
															  
											registerController.store_customer(
											  firstname,
											  lastname,
											  email,
											  password,
											  passwordconfirmation,
											  companyname,
											  address,
											  cityId,
											  stateId,
											  countryId,
											  zipcode,
											  phone,
											);
										  }
										},
								);
							  }),
						  const SizedBox(height: 10),
						  Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
							  Text(Appcontent.alreadyHaveAnAccount, style: TextStyle(color: Colors.grey[500])),
							  InkWell(
								onTap: () {
								  Get.toNamed(Routes.LOGIN_SCREEN);
								},
								child: const Text(Appcontent.loginSmall, style: TextStyle(color: AppColor.purple, fontFamily: 'Urbanist')),
							  ),
							],
						  ),
						  const SizedBox(height: 20),
						  Row(
							  children: [
								Expanded(
								  flex: 1,
								  child: Divider(thickness: 1, color: Color(0xffE2E8F0)),
								),
								Expanded(
								  flex: 1,
								  child: Center(child: Text(Appcontent.signUpWith, style: TextStyle(fontSize: 14, fontFamily: 'Urbanist', color: Colors.grey))),
								),
								Expanded(
								  flex: 1,
								  child: Divider(thickness: 1, color: Color(0xffE2E8F0)),
								),
							  ],
							),
							Padding(
							  padding: const EdgeInsets.only(top: 16, bottom: 16),
							  child: Center(
								child: Column(
								  children: [
								  
									// Consumer Google Sign-In Button
									OutlinedButton(
									  style: OutlinedButton.styleFrom(
										fixedSize: Size(screenWidth, 56),
										shape: RoundedRectangleBorder(
										  borderRadius: BorderRadius.circular(15),
										  side: BorderSide(color: AppColor.black, width: 1),
										),
										//side: BorderSide.none, // Removes the border
										backgroundColor: Colors.white, // Optional: Add background color if needed
									  ),
									  onPressed: () {
										//googleSignin(1); // Passing flag 1 for Consumer
									  },
									  child: const Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
										  SizedBox(
											height: 24,
											width: 24,
											child: Image(image: AssetImage(Appcontent.google)),
										  ),
										  SizedBox(width: 10),
										  Text(
											"Sign In with Google",
											style: TextStyle(
											  fontSize: 16,
											  color: Colors.black,
											  fontFamily: 'Urbanist-semibold',
											),
											overflow: TextOverflow.ellipsis,
										  ),
										],
									  ),
									),
									const SizedBox(height: 20),
									
									// Retailer Google Sign-In Button
									OutlinedButton(
									  style: OutlinedButton.styleFrom(
										fixedSize: Size(screenWidth, 56),
										shape: RoundedRectangleBorder(
										  borderRadius: BorderRadius.circular(15),
										  side: BorderSide(color: AppColor.black, width: 1),
										),
										//side: BorderSide.none, // Removes the border
										backgroundColor: Colors.white, // Optional: Add background color if needed
									  ),
									  onPressed: () {
										//googleSignin(2); // Passing flag 2 for Retailer
									  },
									  child: const Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
										  SizedBox(
											height: 24,
											width: 24,
											child: Image(image: AssetImage(Appcontent.apple)),
										  ),
										  SizedBox(width: 10),
										  Text(
											"Sign In with Apple Id",
											style: TextStyle(
											  fontSize: 16,
											  color: Colors.black,
											  fontFamily: 'Urbanist-semibold',
											),
											overflow: TextOverflow.ellipsis,
										  ),
										],
									  ),
									),
									
								  ],
								),
							  ),
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
