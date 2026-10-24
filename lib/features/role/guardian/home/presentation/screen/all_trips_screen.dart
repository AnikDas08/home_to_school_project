import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/features/role/guardian/home/presentation/widgets/guardian_trip_card.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class AllTripsScreen extends StatefulWidget {
  final bool isTab;

  const AllTripsScreen({super.key, this.isTab = false});

  @override
  State<AllTripsScreen> createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'One-way', 'Round Trip'];

  final List<Map<String, dynamic>> _allTrips = const [
    {
      'month': 'MAY',
      'day': '22',
      'weekday': 'Wed',
      'timeText': '07:30 AM',
      'pickupAddress': '9 Harbourview Lane',
      'destinationAddress': 'Greenfield International',
      'badgeType': TripBadgeType.oneWay,
    },
    {
      'month': 'MAY',
      'day': '22',
      'weekday': 'Wed',
      'timeText': '07:30 AM & 01:00 PM',
      'pickupAddress': '9 Harbourview Lane',
      'destinationAddress': 'Greenfield International',
      'badgeType': TripBadgeType.roundTrip,
    },
    {
      'month': 'MAY',
      'day': '24',
      'weekday': 'Wed',
      'timeText': '07:30 AM & 01:00 PM',
      'pickupAddress': '9 Harbourview Lane',
      'destinationAddress': 'Greenfield International',
      'badgeType': TripBadgeType.roundTrip,
    },
    {
      'month': 'MAY',
      'day': '25',
      'weekday': 'Thu',
      'timeText': '08:00 AM',
      'pickupAddress': '9 Harbourview Lane',
      'destinationAddress': 'Greenfield International',
      'badgeType': TripBadgeType.oneWay,
    },
    {
      'month': 'MAY',
      'day': '26',
      'weekday': 'Fri',
      'timeText': '07:30 AM & 02:30 PM',
      'pickupAddress': '9 Harbourview Lane',
      'destinationAddress': 'Greenfield International',
      'badgeType': TripBadgeType.roundTrip,
    },
  ];

  List<Map<String, dynamic>> get _filteredTrips {
    if (_selectedFilterIndex == 1) {
      return _allTrips
          .where((t) => t['badgeType'] == TripBadgeType.oneWay)
          .toList();
    } else if (_selectedFilterIndex == 2) {
      return _allTrips
          .where((t) => t['badgeType'] == TripBadgeType.roundTrip)
          .toList();
    }
    return _allTrips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: !widget.isTab,
        leading: widget.isTab
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  size: 28,
                  color: Color(0xFF0F172A),
                ),
                onPressed: () => Get.back(),
              ),
        centerTitle: true,
        title: CommonText(
          text: widget.isTab ? "All Bookings" : "Today's Trips",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F5F9),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            14.height,

            /// Filter Pills
            SizedBox(
              height: 38.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => 8.width,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedFilterIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1B2B68)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1B2B68)
                              : const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: CommonText(
                        text: _filters[index],
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
                      ),
                    ),
                  );
                },
              ),
            ),

            14.height,

            /// List of Trips
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                itemCount: _filteredTrips.length,
                separatorBuilder: (_, __) => 12.height,
                itemBuilder: (context, index) {
                  final trip = _filteredTrips[index];
                  return GuardianTripCard(
                    month: trip['month'],
                    day: trip['day'],
                    weekday: trip['weekday'],
                    timeText: trip['timeText'],
                    pickupAddress: trip['pickupAddress'],
                    destinationAddress: trip['destinationAddress'],
                    badgeType: trip['badgeType'],
                    onTap: () => Get.toNamed(AppRoutes.tripDetails),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
