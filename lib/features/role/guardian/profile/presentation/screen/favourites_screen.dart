import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/config/route/app_routes.dart';
import 'package:home_to_school/utils/app_snackbar.dart';
import 'package:home_to_school/utils/constants/app_images.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final List<Map<String, dynamic>> _favourites = [
    {
      'name': 'Tariq Ahmed',
      'rating': '4.9',
      'distance': '0.8 km',
      'area': 'Greenfield',
      'vehicle': 'Toyota Sienna • 4 seats',
    },
    {
      'name': 'Farhana Yasmin',
      'rating': '5.0',
      'distance': '1.2 km',
      'area': 'Annex',
      'vehicle': 'Honda Odyssey • 5 seats',
    },
    {
      'name': 'Kabir Hossain',
      'rating': '4.8',
      'distance': '1.5 km',
      'area': 'East York',
      'vehicle': 'Toyota Highlander • 4 seats',
    },
  ];

  void _showEditDialog(BuildContext context, int index) {
    final item = _favourites[index];
    final nameCtrl = TextEditingController(text: item['name']);
    final areaCtrl = TextEditingController(text: item['area']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const CommonText(
          text: 'Edit Favourite',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Driver Name',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
            12.height,
            const CommonText(
              text: 'Area',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
            6.height,
            TextField(
              controller: areaCtrl,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const CommonText(
              text: 'Cancel',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B2B68),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              setState(() {
                _favourites[index]['name'] = nameCtrl.text.trim();
                _favourites[index]['area'] = areaCtrl.text.trim();
              });
              Navigator.pop(ctx);
              AppSnackbar.success(
                title: 'Success',
                message: 'Favourite updated successfully',
              );
            },
            child: const CommonText(
              text: 'Save',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteFavourite(int index) {
    final deletedName = _favourites[index]['name'];
    setState(() {
      _favourites.removeAt(index);
    });
    AppSnackbar.success(
      title: 'Deleted',
      message: '$deletedName removed from favourites',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: Color(0xFF0F172A),
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const CommonText(
          text: 'Favourites',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
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

      /// List of Favourites
      body: _favourites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 54.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                  14.height,
                  const CommonText(
                    text: 'No favourites yet',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ],
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemCount: _favourites.length,
              separatorBuilder: (_, __) => const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFF1F5F9),
              ),
              itemBuilder: (context, index) {
                final item = _favourites[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Driver Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Image.asset(
                          AppImages.profileImage,
                          width: 48.w,
                          height: 48.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => CircleAvatar(
                            radius: 24.r,
                            backgroundColor: const Color(0xFFEFF6FF),
                            child: Icon(
                              Icons.person,
                              size: 26.sp,
                              color: const Color(0xFF1B2B68),
                            ),
                          ),
                        ),
                      ),

                      14.width,

                      /// Driver Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Name + Verified Badge
                            Row(
                              children: [
                                Flexible(
                                  child: CommonText(
                                    text: item['name']!,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                6.width,
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 15.sp,
                                  color: const Color(0xFF38BDF8),
                                ),
                              ],
                            ),

                            3.height,

                            /// Star Rating + Distance + Area
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 14.sp,
                                  color: const Color(0xFFF59E0B),
                                ),
                                3.width,
                                CommonText(
                                  text: item['rating']!,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFF59E0B),
                                ),
                                4.width,
                                CommonText(
                                  text:
                                      '• ${item['distance']} • ${item['area']}',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF64748B),
                                ),
                              ],
                            ),

                            3.height,

                            /// Vehicle Details
                            CommonText(
                              text: item['vehicle']!,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF94A3B8),
                            ),
                          ],
                        ),
                      ),

                      10.width,

                      /// ReBook Button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.bookings);
                        },
                        child: const CommonText(
                          text: 'ReBook',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1B2B68),
                        ),
                      ),

                      4.width,

                      /// Three-Dot Dropdown Menu (Edit & Delete)
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: Color(0xFF94A3B8),
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: const BorderSide(
                            color: Color(0xFFF1F5F9),
                            width: 1,
                          ),
                        ),
                        offset: const Offset(0, 36),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditDialog(context, index);
                          } else if (value == 'delete') {
                            _deleteFavourite(index);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'edit',
                            height: 38.h,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 18.sp,
                                  color: const Color(0xFF0F172A),
                                ),
                                10.width,
                                const CommonText(
                                  text: 'Edit',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0F172A),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(height: 1),
                          PopupMenuItem<String>(
                            value: 'delete',
                            height: 38.h,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline_rounded,
                                  size: 18.sp,
                                  color: const Color(0xFFEF4444),
                                ),
                                10.width,
                                const CommonText(
                                  text: 'Delete',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFEF4444),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
