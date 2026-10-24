import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_to_school/component/text/common_text.dart';
import 'package:home_to_school/utils/extensions/extension.dart';

class WalkshareReviewItem {
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

  WalkshareReviewItem({
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

class WalkshareReviewsScreen extends StatefulWidget {
  const WalkshareReviewsScreen({super.key});

  @override
  State<WalkshareReviewsScreen> createState() => _WalkshareReviewsScreenState();
}

class _WalkshareReviewsScreenState extends State<WalkshareReviewsScreen> {
  int _selectedFilter = 0; // 0: All, 1: 5 Stars, 2: 4 Stars, 3: 3 Stars

  final List<WalkshareReviewItem> _reviews = [
    WalkshareReviewItem(
      id: '1',
      name: 'Sarah Jenkins',
      subtitle: 'Parent of Leo (Grade 3)',
      rating: 5.0,
      dateText: 'Yesterday',
      comment:
          'Robert is an outstanding walk leader! He is always waiting at the meeting corner 5 minutes early, holds the children\'s hands across the busy avenues, and sends a photo as soon as they reach the school gate. My son Leo absolutely loves walking with him!',
      tags: ['Punctual', 'Safety First', 'Great with Kids', 'Photo Proof'],
      helpfulCount: 18,
      avatarBgColor: const Color(0xFF1E3A8A),
    ),
    WalkshareReviewItem(
      id: '2',
      name: 'Michael Chang',
      subtitle: 'Parent of Emma & Noah (Grade 1 & 4)',
      rating: 5.0,
      dateText: '3 days ago',
      comment:
          'Such peace of mind for working parents. Robert maintains disciplined, cheerful group walking habits and teaches the kids pedestrian safety rules along the way. Highly recommended!',
      tags: ['Pedestrian Safety', 'Responsible', 'Friendly Guide'],
      helpfulCount: 14,
      avatarBgColor: const Color(0xFF0F766E),
    ),
    WalkshareReviewItem(
      id: '3',
      name: 'Fatima Al-Hassan',
      subtitle: 'Parent of Zayd (Grade 2)',
      rating: 5.0,
      dateText: '1 week ago',
      comment:
          'Excellent service and very trustworthy guide. Always pleasant, attentive to every child in the group, and updates parents in real-time. We have booked Robert for the entire semester.',
      tags: ['Trustworthy', 'Real-time Updates', 'Always on Time'],
      helpfulCount: 11,
      avatarBgColor: const Color(0xFF7C3AED),
    ),
    WalkshareReviewItem(
      id: '4',
      name: 'David Miller',
      subtitle: 'Parent of Lucas (Grade 4)',
      rating: 4.0,
      dateText: '2 weeks ago',
      comment:
          'Very consistent and safe walk companion. Only had a slight delay once due to heavy rain, but he communicated in advance and took extra precautions with umbrellas and high-visibility vests.',
      tags: ['Good Communication', 'Weather Prepared'],
      helpfulCount: 7,
      avatarBgColor: const Color(0xFFC2410C),
    ),
    WalkshareReviewItem(
      id: '5',
      name: 'Priya Sharma',
      subtitle: 'Parent of Anaya (Kindergarten)',
      rating: 5.0,
      dateText: '3 weeks ago',
      comment:
          'My 5-year-old was initially nervous about walking to school without me, but Robert was so gentle and encouraging that now she looks forward to walking every morning. Thank you Robert!',
      tags: ['Patient & Caring', 'Encouraging', '10/10 Experience'],
      helpfulCount: 22,
      avatarBgColor: const Color(0xFFBE185D),
    ),
    WalkshareReviewItem(
      id: '6',
      name: 'Marcus Sterling',
      subtitle: 'Parent of Oliver (Grade 5)',
      rating: 4.0,
      dateText: '1 month ago',
      comment:
          'Great guide who takes the shortest and safest route through residential roads rather than heavy traffic streets. The kids arrive energized and on time.',
      tags: ['Safe Route', 'Reliable'],
      helpfulCount: 5,
      avatarBgColor: const Color(0xFF334155),
    ),
    WalkshareReviewItem(
      id: '7',
      name: 'Amina Begum',
      subtitle: 'Parent of Rayan (Grade 3)',
      rating: 5.0,
      dateText: '1 month ago',
      comment:
          'Robert treated all the children like his own. Always respectful, verified with ID, and sends high quality proof photos after dropping them at the gate.',
      tags: ['Verified Guide', 'Respectful', 'High Quality Photos'],
      helpfulCount: 9,
      avatarBgColor: const Color(0xFF15803D),
    ),
  ];

  List<WalkshareReviewItem> get _filteredReviews {
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

      /// Content
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
                  text: '100% Verified Walks',
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

  /// Overall Rating Summary Card (Rating score + 5-star distribution bar)
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
                  text: 'Based on 128 reviews',
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
                    text: '98% Positive',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),

          16.width,

          Container(
            height: 95.h,
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),

          16.width,

          /// Progress Breakdown (5 to 1 Star)
          Expanded(
            flex: 5,
            child: Column(
              children: [
                _buildRatingBarRow('5 ★', 0.88, '112'),
                6.height,
                _buildRatingBarRow('4 ★', 0.09, '12'),
                6.height,
                _buildRatingBarRow('3 ★', 0.02, '3'),
                6.height,
                _buildRatingBarRow('2 ★', 0.01, '1'),
                6.height,
                _buildRatingBarRow('1 ★', 0.00, '0'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Single Rating Progress Bar row
  Widget _buildRatingBarRow(String star, double fraction, String count) {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          child: CommonText(
            text: star,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
            textAlign: TextAlign.start,
          ),
        ),
        6.width,
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6.h,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
            ),
          ),
        ),
        8.width,
        SizedBox(
          width: 22.w,
          child: CommonText(
            text: count,
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF94A3B8),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  /// 3 Highlights Pills
  Widget _buildHighlightsRow() {
    return Row(
      children: [
        _buildHighlightChip('🛡️ Safety Verified'),
        8.width,
        _buildHighlightChip('⏱️ 99% On-time'),
        8.width,
        _buildHighlightChip('⭐ Top Guide'),
      ],
    );
  }

  Widget _buildHighlightChip(String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: CommonText(
          text: label,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }

  /// Filter Chips
  Widget _buildFilterChips() {
    final filters = ['All (128)', '5 Stars (112)', '4 Stars (12)', '3 Stars (4)'];

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
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1B2B68)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1B2B68)
                        : const Color(0xFFCBD5E1),
                    width: 1.0,
                  ),
                ),
                child: CommonText(
                  text: filters[index],
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Review Card
  Widget _buildReviewCard(WalkshareReviewItem review) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Avatar with Initials
              CircleAvatar(
                radius: 20.r,
                backgroundColor: review.avatarBgColor,
                child: Text(
                  initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
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
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 10.sp,
                                color: const Color(0xFF2563EB),
                              ),
                              3.width,
                              const CommonText(
                                text: 'Verified Walk',
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2563EB),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    3.height,

                    CommonText(
                      text: review.subtitle,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),

              /// Date Text
              CommonText(
                text: review.dateText,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF94A3B8),
              ),
            ],
          ),

          10.height,

          /// Stars Row
          Row(
            children: List.generate(5, (index) {
              final isFilled = index < review.rating.floor();
              return Icon(
                isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isFilled
                    ? const Color(0xFFFBBF24)
                    : const Color(0xFFCBD5E1),
                size: 16.sp,
              );
            }),
          ),

          10.height,

          /// Comment Body
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF334155),
              height: 1.45,
            ),
          ),

          12.height,

          /// Tags Chips
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: review.tags.map((tag) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: CommonText(
                  text: tag,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              );
            }).toList(),
          ),

          12.height,

          const Divider(height: 1, thickness: 1, color: Color(0xFFF8FAFC)),

          8.height,

          /// Helpful Counter Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    review.isHelpful = !review.isHelpful;
                    review.helpfulCount += review.isHelpful ? 1 : -1;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Icon(
                      review.isHelpful
                          ? Icons.thumb_up_rounded
                          : Icons.thumb_up_outlined,
                      size: 14.sp,
                      color: review.isHelpful
                          ? const Color(0xFF1B2B68)
                          : const Color(0xFF94A3B8),
                    ),
                    6.width,
                    CommonText(
                      text: 'Helpful (${review.helpfulCount})',
                      fontSize: 12,
                      fontWeight: review.isHelpful
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: review.isHelpful
                          ? const Color(0xFF1B2B68)
                          : const Color(0xFF64748B),
                    ),
                  ],
                ),
              ),

              const CommonText(
                text: 'Safe Commute Verified',
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Empty State for filter
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.star_border_rounded,
            size: 48.sp,
            color: const Color(0xFF94A3B8),
          ),
          12.height,
          const CommonText(
            text: 'No reviews matching this filter',
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }
}
