import 'package:get/get.dart';
import 'package:medicalsupport/app/middlewares/auth_guard.dart';

import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/Onboarding1/bindings/onboarding1_binding.dart';
import '../modules/Onboarding1/views/onboarding1_view.dart';
import '../modules/login_screen/bindings/login_screen_binding.dart';
import '../modules/login_screen/views/login_screen_view.dart';
import '../modules/register/bindings/client_register_binding.dart';
import '../modules/register/views/client_register_view.dart';
import '../modules/register/bindings/employee_register_binding.dart';
import '../modules/register/views/employee_register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

import '../modules/forgot_screen/views/forgot_screen_view.dart';
import '../modules/otp_verification_screen/views/otp_verification_screen_view.dart';
import '../modules/reset_password_screen/views/reset_password_screen_view.dart';
import '../modules/otp_verification_screen/bindings/otp_verification_screen_binding.dart';
import '../modules/reset_password_screen/bindings/reset_password_screen_binding.dart';
import '../modules/forgot_screen/bindings/forgot_screen_binding.dart';
import '../modules/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/profile_screen/views/profile_screen_view.dart';
import '../modules/editprofile_screen/bindings/editprofile_screen_binding.dart';
import '../modules/editprofile_screen/views/editprofile_screen_view.dart';

import 'package:medicalsupport/app/modules/activity_screen/activity_screen_binding.dart';
import 'package:medicalsupport/app/modules/activity_screen/activity_screen_view.dart';
import 'package:medicalsupport/app/modules/editpictre_screen/bindings/editpictre_screen_binding.dart';
import 'package:medicalsupport/app/modules/editpictre_screen/views/editpictre_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [		
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),	
    GetPage(
      name: _Paths.ONBOARDING1,
      page: () => Onboarding1View(),
      binding: Onboarding1Binding(),
    ),
    GetPage(
      name: _Paths.CLIENT_REGISTER,
      page: () =>  ClientRegisterView(),
      binding: ClientRegisterBinding(),
    ),
	GetPage(
      name: _Paths.EMPLOYEE_REGISTER,
      page: () =>  EmployeeRegisterView(),
      binding: EmployeeRegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_SCREEN,
      page: () => ForgotScreenView(),
      binding: ForgotScreenBinding(),
    ),
	GetPage(
	  name: _Paths.OTP_VERIFICATION_SCREEN,
	  page: () {
		final String email = Get.parameters['email'] ?? ''; // Fetch the email parameter
		final String contextStr = Get.parameters['context'] ?? 'forgotPassword'; // Fetch the context parameter
		return OtpVerificationScreenView(email: email, context: contextStr);
	  },
	  binding: OtpVerificationScreenBinding(),
	),
	GetPage(
		name: _Paths.RESET_PASSWORD_SCREEN,
		page: () {
			final String email = Get.parameters['email'] ?? ''; // Fetch the email parameter
			return ResetPasswordScreenView(email: email);
		},
		binding: ResetPasswordScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
	  middlewares: [AuthGuard()], // After Login
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () =>  ProfileScreenView(),
      binding: ProfileScreenBinding(),
	  middlewares: [AuthGuard()], // After Login
    ),
    GetPage(
      name: _Paths.EDITPROFILE_SCREEN,
      page: () => EditprofileScreenView(),
      binding: EditprofileScreenBinding(),
	  middlewares: [AuthGuard()], // After Login
    ),
  ];
}
