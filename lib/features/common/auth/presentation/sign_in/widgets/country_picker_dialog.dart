import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/constants/app_colors.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class CountryPickerDialog extends StatefulWidget {
  final String selectedCode;
  final Function(Country country) onCountrySelected;

  const CountryPickerDialog({
    super.key,
    required this.selectedCode,
    required this.onCountrySelected,
  });

  static Future<void> show(
    BuildContext context, {
    required String selectedCode,
    required Function(Country country) onCountrySelected,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (context) => CountryPickerDialog(
        selectedCode: selectedCode,
        onCountrySelected: onCountrySelected,
      ),
    );
  }

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = List.from(countries);
    _searchController.addListener(_filterCountries);
  }

  void _filterCountries() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = List.from(countries);
      } else {
        _filteredCountries = countries.where((country) {
          final nameMatch = country.name.toLowerCase().contains(query);
          final codeMatch = country.dialCode.contains(query);
          final isoMatch = country.code.toLowerCase().contains(query);
          return nameMatch || codeMatch || isoMatch;
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: double.infinity,
          height: 520.h,
          child: Column(
            children: [
              16.height,

              /// Header: Title + Close Icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Row(
                  children: [
                    const Expanded(
                      child: CommonText(
                        text: 'Select Country',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close_rounded,
                          size: 18.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              12.height,

              /// Search Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _searchController,
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: const Color(0xFF0F172A),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search_rounded,
                        size: 20.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                      hintText: 'Search country or code...',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                ),
              ),

              12.height,
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              /// Country List
              Expanded(
                child: _filteredCountries.isEmpty
                    ? Center(
                        child: CommonText(
                          text: 'No country found',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF94A3B8),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredCountries.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: Color(0xFFF8FAFC)),
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          final formattedCode = '+${country.dialCode}';
                          final isSelected =
                              widget.selectedCode == formattedCode ||
                                  widget.selectedCode == country.dialCode;

                          return ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 18.w),
                            leading: Text(
                              country.flag,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                            title: CommonText(
                              text: country.name,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: const Color(0xFF0F172A),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonText(
                                  text: formattedCode,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : const Color(0xFF64748B),
                                ),
                                if (isSelected) ...[
                                  8.width,
                                  const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ],
                            ),
                            onTap: () {
                              widget.onCountrySelected(country);
                              Get.back();
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
