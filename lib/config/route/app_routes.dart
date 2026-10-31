import 'package:get/get.dart';
import 'package:home_to_school/features/common/auth/presentation/forgot_password/screen/create_password.dart';
import 'package:home_to_school/features/common/auth/presentation/forgot_password/screen/forgot_password.dart';
import 'package:home_to_school/features/common/auth/presentation/forgot_password/screen/verify_screen.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_in/screen/sign_in_screen.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_up/screen/add_child_screen.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:home_to_school/features/common/auth/presentation/sign_up/screen/verify_user.dart';
import 'package:home_to_school/features/common/onboarding/onboarding_screen.dart';
import 'package:home_to_school/features/common/splash/splash_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/guardian_booking_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/book_a_ride_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/available_providers_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/driver_profile_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/booking_summary_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/guardian_trip_details_screen.dart';
import 'package:home_to_school/features/role/guardian/booking/presentation/screen/guardian_live_track_screen.dart';
import 'package:home_to_school/features/role/driver/presentation/screen/driver_licence_screen.dart';
import 'package:home_to_school/features/role/driver/presentation/screen/vehicle_details_screen.dart';
import 'package:home_to_school/features/role/driver/presentation/screen/vehicle_insurance_screen.dart';
import 'package:home_to_school/features/role/driver/home/presentation/screen/driver_home_screen.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/screen/driver_requests_screen.dart';
import 'package:home_to_school/features/role/driver/requests/presentation/screen/driver_request_details_screen.dart';
import 'package:home_to_school/features/role/driver/schedule/presentation/screen/driver_schedule_screen.dart';
import 'package:home_to_school/features/role/driver/active_trip/presentation/screen/driver_active_trip_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/driver_role_profile_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/driver_vehicle_info_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/driver_documents_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/document_details_screen.dart';
import 'package:home_to_school/features/role/driver/profile/presentation/screen/driver_reviews_screen.dart';
import 'package:home_to_school/features/common/about/presentation/screen/about_screen.dart';
import 'package:home_to_school/features/role/driver/availability/presentation/screen/driver_availability_screen.dart';
import 'package:home_to_school/features/role/walkshare/presentation/screen/walkshare_verification_screen.dart';
import 'package:home_to_school/features/role/walkshare/home/presentation/screen/walkshare_home_screen.dart';
import 'package:home_to_school/features/role/walkshare/requests/presentation/screen/walkshare_requests_screen.dart';
import 'package:home_to_school/features/role/walkshare/requests/presentation/screen/walkshare_request_details_screen.dart';
import 'package:home_to_school/features/role/walkshare/schedule/presentation/screen/walkshare_schedule_screen.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/screen/walkshare_profile_screen.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/screen/walkshare_documents_screen.dart';
import 'package:home_to_school/features/role/walkshare/profile/presentation/screen/walkshare_reviews_screen.dart';
import 'package:home_to_school/features/role/walkshare/active_walk/presentation/screen/walkshare_active_walk_screen.dart';
import 'package:home_to_school/features/message/presentation/chat_list/screen/chat_screen.dart';
import 'package:home_to_school/features/message/presentation/message_details/screen/message_screen.dart';
import 'package:home_to_school/features/notifications/presentation/screen/notifications_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/guardian_profile_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/personal_information_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/my_children_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/add_new_child_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/favourites_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/emergency_contacts_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/saved_locations_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/billing_and_transactions_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/contact_support_screen.dart';
import 'package:home_to_school/features/role/guardian/profile/presentation/screen/faq_screen.dart';
import 'package:home_to_school/features/profile/presentation/screen/edit_profile.dart';

import 'package:home_to_school/features/setting/presentation/screen/privacy_policy_screen.dart';
import 'package:home_to_school/features/setting/presentation/screen/setting_screen.dart';
import 'package:home_to_school/features/setting/presentation/screen/terms_of_service_screen.dart';

import 'package:home_to_school/features/common/nav_screen/screen/nav_screen.dart';
import 'package:home_to_school/features/common/sos/presentation/screen/sos_screen.dart';
import '../../features/common/role_selection/presentation/screen/role_selection_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-selection';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verifyUser = '/verify-user';
  static const String addChild = '/add-child';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';
  static const String createPassword = '/create-password';
  static const String changePassword = '/change-password';
  static const String home = '/home';
  static const String navScreen = '/nav-screen';
  static const String homeNav = '/home-nav';
  static const String bookings = '/bookings';
  static const String bookRide = '/book-a-ride';
  static const String addBooking = '/add-booking';
  static const String availableProviders = '/available-providers';
  static const String driverProfile = '/driver-profile';
  static const String bookingSummary = '/booking-summary';
  static const String tripDetails = '/trip-details';
  static const String guardianLiveTrack = '/guardian-live-track';
  static const String driverLicence = '/driver-licence';
  static const String driverVehicleDetails = '/driver-vehicle-details';
  static const String driverVehicleInsurance = '/driver-vehicle-insurance';
  static const String driverVehicleInfo = '/driver-vehicle-info';
  static const String driverDocuments = '/driver-documents';
  static const String documentDetails = '/document-details';
  static const String driverHome = '/driver-home';
  static const String driverRequests = '/driver-requests';
  static const String driverRequestDetails = '/driver-request-details';
  static const String driverSchedule = '/driver-schedule';
  static const String driverActiveTrip = '/driver-active-trip';
  static const String driverAccountProfile = '/driver-account-profile';
  static const String driverReviews = '/driver-reviews';
  static const String driverAvailability = '/driver-availability';
  static const String walkshareVerification = '/walkshare-verification';
  static const String walkshareHome = '/walkshare-home';
  static const String walkshareRequests = '/walkshare-requests';
  static const String walkshareRequestDetails = '/walkshare-request-details';
  static const String walkshareSchedule = '/walkshare-schedule';
  static const String walkshareProfile = '/walkshare-profile';
  static const String walkshareDocuments = '/walkshare-documents';
  static const String walkshareReviews = '/walkshare-reviews';
  static const String walkshareActiveTrip = '/walkshare-active-trip';
  static const String allTrips = '/all-trips';
  static const String notifications = '/notifications';
  static const String chat = '/chat';
  static const String message = '/message';
  static const String profile = '/profile';
  static const String personalInformation = '/personal-information';
  static const String myChildren = '/my-children';
  static const String addNewChild = '/add-new-child';
  static const String favourites = '/favourites';
  static const String emergencyContacts = '/emergency-contacts';
  static const String savedLocations = '/saved-locations';
  static const String billingAndTransactions = '/billing-and-transactions';
  static const String contactSupport = '/contact-support';
  static const String faq = '/faq';
  static const String editProfile = '/edit-profile';
  static const String setting = '/settings';
  static const String settings = '/settings';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsOfServices = '/terms-of-services';
  static const String termsOfService = termsOfServices;
  static const String about = '/about';
  static const String sos = '/sos';
  static const String test = '/test';

  static List<GetPage<dynamic>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(
      name: roleSelection,
      page: () => const RoleSelectionScreen(),
    ),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => const VerifyUser()),
    GetPage(name: addChild, page: () => const AddChildScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: home, page: () => const NavScreen()),
    GetPage(name: navScreen, page: () => const NavScreen()),
    GetPage(name: homeNav, page: () => const NavScreen()),
    GetPage(name: bookings, page: () => const GuardianBookingScreen()),
    GetPage(name: bookRide, page: () => const BookARideScreen()),
    GetPage(name: addBooking, page: () => const BookARideScreen()),
    GetPage(name: availableProviders, page: () => const AvailableProvidersScreen()),
    GetPage(name: driverProfile, page: () => const DriverProfileScreen()),
    GetPage(name: bookingSummary, page: () => const BookingSummaryScreen()),
    GetPage(name: tripDetails, page: () => const GuardianTripDetailsScreen()),
    GetPage(name: guardianLiveTrack, page: () => const GuardianLiveTrackScreen()),
    GetPage(name: driverLicence, page: () => const DriverLicenceScreen()),
    GetPage(name: driverVehicleDetails, page: () => const VehicleDetailsScreen()),
    GetPage(name: driverVehicleInsurance, page: () => const VehicleInsuranceScreen()),
    GetPage(name: driverVehicleInfo, page: () => const DriverVehicleInfoScreen()),
    GetPage(name: driverDocuments, page: () => const DriverDocumentsScreen()),
    GetPage(name: documentDetails, page: () => const DocumentDetailsScreen()),
    GetPage(name: driverHome, page: () => const DriverHomeScreen()),
    GetPage(name: driverRequests, page: () => const DriverRequestsScreen()),
    GetPage(name: driverRequestDetails, page: () => const DriverRequestDetailsScreen()),
    GetPage(name: driverSchedule, page: () => const DriverScheduleScreen()),
    GetPage(name: driverActiveTrip, page: () => const DriverActiveTripScreen()),
    GetPage(name: driverAccountProfile, page: () => const DriverRoleProfileScreen()),
    GetPage(name: driverReviews, page: () => const DriverReviewsScreen()),
    GetPage(name: driverAvailability, page: () => const DriverAvailabilityScreen()),
    GetPage(name: walkshareVerification, page: () => const WalkshareVerificationScreen()),
    GetPage(name: walkshareHome, page: () => const WalkshareHomeScreen()),
    GetPage(name: walkshareRequests, page: () => const WalkshareRequestsScreen()),
    GetPage(name: walkshareRequestDetails, page: () => const WalkshareRequestDetailsScreen()),
    GetPage(name: walkshareSchedule, page: () => const WalkshareScheduleScreen()),
    GetPage(name: walkshareProfile, page: () => const WalkshareProfileScreen()),
    GetPage(name: walkshareDocuments, page: () => const WalkshareDocumentsScreen()),
    GetPage(name: walkshareReviews, page: () => const WalkshareReviewsScreen()),
    GetPage(name: walkshareActiveTrip, page: () => const WalkshareActiveWalkScreen()),
    GetPage(name: allTrips, page: () => const GuardianBookingScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: chat, page: () => const ChatListScreen()),
    GetPage(name: message, page: () => const MessageScreen()),
    GetPage(name: profile, page: () => const GuardianProfileScreen()),
    GetPage(
      name: personalInformation,
      page: () => const PersonalInformationScreen(),
    ),
    GetPage(name: myChildren, page: () => const MyChildrenScreen()),
    GetPage(name: addNewChild, page: () => const AddNewChildScreen()),
    GetPage(name: favourites, page: () => const FavouritesScreen()),
    GetPage(
      name: emergencyContacts,
      page: () => const EmergencyContactsScreen(),
    ),
    GetPage(
      name: savedLocations,
      page: () => const SavedLocationsScreen(),
    ),
    GetPage(
      name: billingAndTransactions,
      page: () => const BillingAndTransactionsScreen(),
    ),
    GetPage(
      name: contactSupport,
      page: () => const ContactSupportScreen(),
    ),
    GetPage(
      name: faq,
      page: () => const FaqScreen(),
    ),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: settings, page: () => const SettingScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => const TermsOfServiceScreen()),
    GetPage(name: about, page: () => const AboutScreen()),
    GetPage(name: sos, page: () => const SosScreen()),
  ];
}
