import 'package:get/get.dart';
import 'package:home_to_school/utils/app_snackbar.dart';

class ProviderModel {
  final String id;
  final String name;
  final bool isVerified;
  final double rating;
  final double distanceKm;
  final String area;
  final String vehicle;
  final int seats;
  final String gender; // 'Male', 'Female', 'Other'
  final String? image;

  const ProviderModel({
    required this.id,
    required this.name,
    this.isVerified = true,
    required this.rating,
    required this.distanceKm,
    this.area = 'Greenfield',
    required this.vehicle,
    required this.seats,
    required this.gender,
    this.image,
  });
}

class AvailableProvidersController extends GetxController {
  static AvailableProvidersController get instance =>
      Get.find<AvailableProvidersController>();

  /// All initial providers matching the design
  final List<ProviderModel> allProviders = const [
    ProviderModel(
      id: '1',
      name: 'Tariq Ahmed',
      isVerified: true,
      rating: 4.9,
      distanceKm: 0.8,
      area: 'Greenfield',
      vehicle: 'Toyota Sienna',
      seats: 4,
      gender: 'Male',
    ),
    ProviderModel(
      id: '2',
      name: 'Farhana Yasmin',
      isVerified: true,
      rating: 5.0,
      distanceKm: 1.2,
      area: 'Greenfield',
      vehicle: 'Honda Odyssey',
      seats: 5,
      gender: 'Female',
    ),
    ProviderModel(
      id: '3',
      name: 'Kabir Hossain',
      isVerified: true,
      rating: 4.8,
      distanceKm: 1.5,
      area: 'Greenfield',
      vehicle: 'Toyota Highlander',
      seats: 4,
      gender: 'Male',
    ),
  ];

  /// Quick Filter Tab: 'All', 'Nearest', 'Rating'
  String selectedQuickFilter = 'All';

  /// Bottom Sheet Filter States
  double distanceRadius = 10.0;
  String selectedGender = 'All'; // 'All', 'Male', 'Female', 'Other'

  // Temporary filter states while sheet is open
  double tempDistanceRadius = 10.0;
  String tempSelectedGender = 'All';

  final List<String> quickFilters = const ['All', 'Nearest', 'Rating'];
  final List<String> genderOptions = const ['All', 'Male', 'Female', 'Other'];

  void selectQuickFilter(String filter) {
    selectedQuickFilter = filter;
    update();
  }

  void initTempFilters() {
    tempDistanceRadius = distanceRadius;
    tempSelectedGender = selectedGender;
  }

  void setTempDistance(double value) {
    tempDistanceRadius = value;
    update();
  }

  void setTempGender(String gender) {
    tempSelectedGender = gender;
    update();
  }

  void applyFilters() {
    distanceRadius = tempDistanceRadius;
    selectedGender = tempSelectedGender;
    update();
  }

  void requestBooking(ProviderModel provider) {
    AppSnackbar.success(
      title: 'Booking Requested',
      message: 'Your booking request has been sent to ${provider.name}',
    );
  }

  /// Get filtered & sorted list
  List<ProviderModel> get filteredProviders {
    var list = allProviders.where((p) {
      final matchesDistance = p.distanceKm <= distanceRadius;
      final matchesGender =
          selectedGender == 'All' || p.gender.toLowerCase() == selectedGender.toLowerCase();
      return matchesDistance && matchesGender;
    }).toList();

    if (selectedQuickFilter == 'Nearest') {
      list.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    } else if (selectedQuickFilter == 'Rating') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return list;
  }
}
