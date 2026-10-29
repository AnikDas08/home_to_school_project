import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class DriverReviewItem {
  final String id;
  final String name;
  final String subtitle;
  final double rating;
  final String dateText;
  final String comment;
  final List<String> tags;
  int helpfulCount;
  bool isHelpful;
  final Color avatarBgColor;

  DriverReviewItem({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.rating,
    required this.dateText,
    required this.comment,
    required this.tags,
    required this.helpfulCount,
    this.isHelpful = false,
    required this.avatarBgColor,
  });
}

class DriverReviewsScreen extends StatefulWidget {
  const DriverReviewsScreen({super.key});

  @override
  State<DriverReviewsScreen> createState() => _DriverReviewsScreenState();
}

class _DriverReviewsScreenState extends State<DriverReviewsScreen> {
  int _selectedFilter = 0; // 0: All, 1: 5 Stars, 2: 4 Stars, 3: < 4 Stars

  final List<DriverReviewItem> _reviews = [
    DriverReviewItem(
      id: '1',
      name: 'Sarah Jenkins',
      subtitle: 'Parent of Leo (Grade 3)',
      rating: 5.0,
      dateText: 'Yesterday',
      comment:
          'Tariq is an exceptional driver! He has dedicated booster seats installed, arrives 5 minutes early, and drives very smoothly. Both of my kids feel completely safe and happy commuting with him.',
      tags: ['Clean Vehicle', 'Safe Driving', 'Booster Seats', 'Punctual'],
      helpfulCount: 22,
      avatarBgColor: const Color(0xFF1E3A8A),
    ),
    DriverReviewItem(
      id: '2',
      name: 'Michael Chang',
      subtitle: 'Parent of Emma & Noah (Grade 1 & 4)',
      rating: 5.0,
      dateText: '3 days ago',
      comment:
          'Fantastic service! Very polite, well-maintained minivan, and updates us as soon as the children board and reach Greenfield International School. Highest recommendation for working parents!',
      tags: ['Minivan Clean', 'Polite Driver', 'Real-time Updates'],
      helpfulCount: 16,
      avatarBgColor: const Color(0xFF0F766E),
    ),
    DriverReviewItem(
      id: '3',
      name: 'Fatima Al-Hassan',
      subtitle: 'Parent of Zayd (Grade 2)',
      rating: 5.0,
      dateText: '1 week ago',
      comment:
          'Very reliable and safe. Tariq has been driving our son to school for over 4 months now. Never a single delay or issue. He takes school zone speed limits and safety very seriously.',
      tags: ['Reliable Commute', 'Safety First', 'Great with Kids'],
      helpfulCount: 14,
      avatarBgColor: const Color(0xFF7C3AED),
    ),
    DriverReviewItem(
      id: '4',
      name: 'David Miller',
      subtitle: 'Parent of Lucas (Grade 4)',
      rating: 4.0,
      dateText: '2 weeks ago',
      comment:
          'Great experience overall. Vehicle is always spotless, air conditioning is pleasant, and he always double-checks that seatbelts are fastened before shifting into gear.',
      tags: ['Seatbelts Checked', 'Clean Car', 'Helpful'],
      helpfulCount: 9,
      avatarBgColor: const Color(0xFFC2410C),
    ),
    DriverReviewItem(
      id: '5',
      name: 'Priya Sharma',
      subtitle: 'Parent of Anaya (Kindergarten)',
      rating: 5.0,
      dateText: '3 weeks ago',
      comment:
          'Our 5-year-old was initially nervous about riding without us, but Tariq was so gentle and welcoming that now she looks forward to her morning ride every day. Truly grateful!',
      tags: ['Child Friendly', 'Punctual', 'Gentle Driving'],
      helpfulCount: 19,
      avatarBgColor: const Color(0xFFBE185D),
    ),
    DriverReviewItem(
      id: '6',
      name: 'James Wilson',
      subtitle: 'Parent of Sophia (Grade 5)',
      rating: 5.0,
      dateText: '1 month ago',
      comment:
          'Top-tier driver in the Greenfield district. Extremely communicative when there are morning traffic detours, and always greets the kids with a smile.',
      tags: ['Traffic Aware', 'School Zone Safety', 'Trusted'],
      helpfulCount: 8,
      avatarBgColor: const Color(0xFF0369A1),
    ),
  ];

  List<DriverReviewItem> get _filteredReviews {
    switch (_selectedFilter) {
      case 1:
        return _reviews.where((r) => r.rating >= 5.0).toList();
      case 2:
        return _reviews.where((r) => r.rating >= 4.0 && r.rating < 5.0).toList();
      case 3:
        return _reviews.where((r) => r.rating < 4.0).toList();
      default:
        return _reviews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

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
          text: 'Ratings & Reviews',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
        ),
      ),

      /// Body Content
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Overall Rating Summary Card
            _buildRatingSummaryCard(),

            16.height,

            /// 2. Highlights Badges
            _buildHighlightsRow(),

            20.height,

            /// 3. Section Title & Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Reviews (${_filteredReviews.length})',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
                const CommonText(
                  text: '100% Verified Trips',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF10B981),
                ),
              ],
            ),

            12.height,

            /// Filter Pills
            _buildFilterChips(),

            16.height,

            /// 4. Review Cards List
            if (_filteredReviews.isEmpty)
              _buildEmptyState()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredReviews.length,
                separatorBuilder: (_, __) => 14.height,
                itemBuilder: (context, index) {
                  final review = _filteredReviews[index];
                  return _buildReviewCard(review);
                },
              ),

            24.height,
          ],
        ),
      ),
    );
  }

  /// Overall Rating Summary Card
  Widget _buildRatingSummaryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Big Score & Star Row
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CommonText(
                  text: '4.9',
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
                4.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star_rounded,
                      color: const Color(0xFFFBBF24),
                      size: 20.sp,
                    );
                  }),
                ),
                6.height,
                const CommonText(
                  text: 'Based on 142 reviews',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
                4.height,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const CommonText(
                    text: '99% Positive',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 90.h,
            width: 1,
            color: const Color(0xFFE2E8F0),
            margin: EdgeInsets.symmetric(horizontal: 14.w),
          ),

          /// Distribution Bars
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildRatingBar('5★', 0.90, '128'),
                5.height,
                _buildRatingBar('4★', 0.08, '12'),
                5.height,
                _buildRatingBar('3★', 0.02, '2'),
                5.height,
                _buildRatingBar('2★', 0.00, '0'),
                5.height,
                _buildRatingBar('1★', 0.00, '0'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Individual rating star bar row
  Widget _buildRatingBar(String label, double ratio, String count) {
    return Row(
      children: [
        SizedBox(
          width: 22.w,
          child: CommonText(
            text: label,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
        6.width,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Container(
              height: 6.h,
              color: const Color(0xFFF1F5F9),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: ratio,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFBBF24),
                        Color(0xFFF59E0B),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        8.width,
        SizedBox(
          width: 24.w,
          child: CommonText(
            text: count,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF94A3B8),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  /// Highlights Row: Top Rated, Pristine Vehicle, Safe Driver
  Widget _buildHighlightsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildHighlightChip(
            icon: Icons.workspace_premium_rounded,
            iconColor: const Color(0xFF10B981),
            bgColor: const Color(0xFFECFDF5),
            borderColor: const Color(0xFFA7F3D0),
            title: 'Top Rated Driver',
          ),
          10.width,
          _buildHighlightChip(
            icon: Icons.directions_car_rounded,
            iconColor: const Color(0xFF3B82F6),
            bgColor: const Color(0xFFEFF6FF),
            borderColor: const Color(0xFFBFDBFE),
            title: 'Pristine Vehicle',
          ),
          10.width,
          _buildHighlightChip(
            icon: Icons.verified_user_rounded,
            iconColor: const Color(0xFF8B5CF6),
            bgColor: const Color(0xFFF5F3FF),
            borderColor: const Color(0xFFDDD6FE),
            title: 'Safe Driving Record',
          ),
          10.width,
          _buildHighlightChip(
            icon: Icons.access_time_filled_rounded,
            iconColor: const Color(0xFFF59E0B),
            bgColor: const Color(0xFFFFFBEB),
            borderColor: const Color(0xFFFDE68A),
            title: 'Always On-Time',
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightChip({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: iconColor),
          6.width,
          CommonText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ],
      ),
    );
  }

  /// Filter Chips
  Widget _buildFilterChips() {
    final filters = [
      'All (${_reviews.length})',
      '5 Stars (${_reviews.where((r) => r.rating >= 5.0).length})',
      '4 Stars (${_reviews.where((r) => r.rating >= 4.0 && r.rating < 5.0).length})',
      '< 4 Stars (${_reviews.where((r) => r.rating < 4.0).length})',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = _selectedFilter == index;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1B2B68)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1B2B68)
                        : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF1B2B68).withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: CommonText(
                  text: filters[index],
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Review Card
  Widget _buildReviewCard(DriverReviewItem review) {
    final initials = review.name.split(' ').map((e) => e[0]).take(2).join();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Reviewer Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Initials Avatar
              CircleAvatar(
                radius: 20.r,
                backgroundColor: review.avatarBgColor,
                child: CommonText(
                  text: initials,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              12.width,

              /// Reviewer Name & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CommonText(
                            text: review.name,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        6.width,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 10.sp,
                                color: const Color(0xFF10B981),
                              ),
                              3.width,
                              const CommonText(
                                text: 'Verified',
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF059669),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    2.height,
                    CommonText(
                      text: review.subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),

              /// Date
              CommonText(
                text: review.dateText,
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF94A3B8),
              ),
            ],
          ),

          12.height,

          /// Star Rating Row
          Row(
            children: List.generate(5, (index) {
              final isFilled = index < review.rating.floor();
              return Icon(
                isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFilled ? const Color(0xFFFBBF24) : const Color(0xFFCBD5E1),
                size: 17.sp,
              );
            }),
          ),

          10.height,

          /// Comment Text
          CommonText(
            text: review.comment,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF334155),
            textAlign: TextAlign.start,
          ),

          12.height,

          /// Tags List
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: review.tags.map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: CommonText(
                  text: tag,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              );
            }).toList(),
          ),

          12.height,

          /// Footer: Helpful button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    review.isHelpful = !review.isHelpful;
                    review.helpfulCount += review.isHelpful ? 1 : -1;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: review.isHelpful
                        ? const Color(0xFFEFF6FF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: review.isHelpful
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        review.isHelpful
                            ? Icons.thumb_up_rounded
                            : Icons.thumb_up_outlined,
                        size: 13.sp,
                        color: review.isHelpful
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF64748B),
                      ),
                      5.width,
                      CommonText(
                        text: 'Helpful (${review.helpfulCount})',
                        fontSize: 11.5,
                        fontWeight: review.isHelpful
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: review.isHelpful
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF64748B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Empty state
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48.sp,
            color: const Color(0xFF94A3B8),
          ),
          12.height,
          const CommonText(
            text: 'No reviews matching this filter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }
}

