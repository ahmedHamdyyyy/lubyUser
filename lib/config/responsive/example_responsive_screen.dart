import 'package:flutter/material.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../colors/colors.dart';
import 'responsive.dart';

/// An example screen demonstrating the usage of responsive utilities
class ExampleResponsiveScreen extends StatelessWidget {
  const ExampleResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.responsiveExampleTitle)),
      body: SafeArea(
        child: Responsive(
          // Define different layouts for different device sizes
          mobileSmall: _buildMobileSmallLayout(context),
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  // Layout for small mobile devices (< 480px width)
  Widget _buildMobileSmallLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 1),
          SizedBox(height: context.sectionSpacing),
          _buildForm(context),
          SizedBox(height: context.sectionSpacing),
          _buildButtons(context),
        ],
      ),
    );
  }

  // Layout for normal mobile devices (480px - 768px width)
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 2),
          SizedBox(height: context.sectionSpacing),
          _buildForm(context),
          SizedBox(height: context.sectionSpacing),
          _buildButtons(context),
        ],
      ),
    );
  }

  // Layout for tablet devices (768px - 1024px width)
  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.sectionSpacing),
          _buildInfoCards(context, columns: 3),
          SizedBox(height: context.sectionSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: _buildForm(context)),
              SizedBox(width: context.componentSpacing),
              Expanded(
                flex: 4,
                child: Column(
                  children: [_buildSummaryCard(context), SizedBox(height: context.componentSpacing), _buildButtons(context)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Layout for desktop devices (> 1024px width)
  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: context.sectionSpacing),
              _buildInfoCards(context, columns: 4),
              SizedBox(height: context.sectionSpacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _buildForm(context)),
                  SizedBox(width: context.componentSpacing * 2),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _buildSummaryCard(context),
                        SizedBox(height: context.componentSpacing),
                        _buildButtons(context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header section with responsive text
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveText(
          'Welome to Fondok',
          mobileSmallSize: 24,
          mobileSize: 28,
          tabletSize: 32,
          desktopSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.secondTextColor,
        ),
        SizedBox(height: context.itemSpacing),
        const ResponsiveText(
          'Find the perfect accommodations for your needs',
          mobileSmallSize: 14,
          mobileSize: 16,
          tabletSize: 18,
          desktopSize: 20,
          color: AppColors.grayTextColor,
        ),
      ],
    );
  }

  // Info cards section with responsive grid
  Widget _buildInfoCards(BuildContext context, {required int columns}) {
    return ResponsiveGridView(
      mobileSmallCrossAxisCount: 1,
      mobileCrossAxisCount: 2,
      tabletCrossAxisCount: 3,
      desktopCrossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildInfoCard(
          context,
          icon: Icons.hotel,
          title: context.l10n.hotelsTitle,
          description: context.l10n.hotelsDescription,
          color: Colors.blue.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.apartment,
          title: context.l10n.apartmentsTitle,
          description: context.l10n.apartmentsDescription,
          color: Colors.green.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.house,
          title: context.l10n.villasTitle,
          description: context.l10n.villasDescription,
          color: Colors.orange.shade100,
        ),
        _buildInfoCard(
          context,
          icon: Icons.cabin,
          title: context.l10n.cabinsTitle,
          description: context.l10n.cabinsDescription,
          color: Colors.purple.shade100,
        ),
      ],
    );
  }

  // Single info card with responsive design
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return ResponsiveCard(
      color: color,
      mobileSmallPadding: const EdgeInsets.all(12),
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(20),
      desktopPadding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: context.iconSize * 1.5, color: Colors.black87),
          SizedBox(height: context.itemSpacing),
          ResponsiveText(
            title,
            mobileSmallSize: 16,
            mobileSize: 18,
            tabletSize: 20,
            desktopSize: 22,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.itemSpacing / 2),
          ResponsiveText(
            description,
            mobileSmallSize: 12,
            mobileSize: 14,
            tabletSize: 16,
            desktopSize: 18,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  // Form section with responsive inputs
  Widget _buildForm(BuildContext context) {
    return ResponsiveCard(
      child: ResponsiveColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            context.l10n.searchForAccommodations,
            mobileSmallSize: 18,
            mobileSize: 20,
            tabletSize: 22,
            desktopSize: 24,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 16),
          ResponsiveTextField(hintText: context.l10n.searchLocationHint, prefixIcon: Icon(Icons.location_on_outlined)),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ResponsiveTextField(hintText: context.l10n.checkIn.trim(), prefixIcon: Icon(Icons.calendar_today)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ResponsiveTextField(hintText: context.l10n.checkOut.trim(), prefixIcon: Icon(Icons.calendar_today)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ResponsiveTextField(
                  hintText: context.l10n.guests,
                  prefixIcon: Icon(Icons.person_outline),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ResponsiveDropdownButton<String>(
                  hint: context.l10n.roomTypeLabel,
                  items: [
                    DropdownMenuItem(value: 'single', child: Text(context.l10n.roomTypeSingle)),
                    DropdownMenuItem(value: 'double', child: Text(context.l10n.roomTypeDouble)),
                    DropdownMenuItem(value: 'suite', child: Text(context.l10n.roomTypeSuite)),
                    DropdownMenuItem(value: 'family', child: Text(context.l10n.roomTypeFamily)),
                  ],
                  isExpanded: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ResponsiveCheckbox(value: true, label: context.l10n.includeBreakfast),
          ResponsiveCheckbox(value: false, label: context.l10n.petFriendly),
        ],
      ),
    );
  }

  // Summary card with responsive design
  Widget _buildSummaryCard(BuildContext context) {
    return ResponsiveCard(
      color: AppColors.primary.withAlpha(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            context.l10n.yourSearch,
            mobileSmallSize: 18,
            mobileSize: 20,
            tabletSize: 22,
            desktopSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(context, context.l10n.locationLabel, 'Dubai, UAE'),
          _buildSummaryRow(context, context.l10n.checkIn.trim(), 'Jun 15, 2023'),
          _buildSummaryRow(context, context.l10n.checkOut.trim(), 'Jun 20, 2023'),
          _buildSummaryRow(context, context.l10n.guests, '2 Adults, 1 Child'),
          _buildSummaryRow(context, context.l10n.roomTypeLabel, 'Double Room'),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ResponsiveText(
                context.l10n.commonTotal,
                mobileSmallSize: 16,
                mobileSize: 18,
                tabletSize: 20,
                desktopSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const ResponsiveText(
                '\$750',
                mobileSmallSize: 18,
                mobileSize: 20,
                tabletSize: 22,
                desktopSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for summary row
  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResponsiveText(label, mobileSmallSize: 12, mobileSize: 14, tabletSize: 16, desktopSize: 18, color: Colors.black54),
          ResponsiveText(
            value,
            mobileSmallSize: 12,
            mobileSize: 14,
            tabletSize: 16,
            desktopSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  // Buttons section with responsive buttons
  Widget _buildButtons(BuildContext context) {
    bool isSmallDevice = context.isMobileSmall;

    return isSmallDevice
        ? Column(
          children: [
            ResponsiveElevatedButton(
              text: context.l10n.searchProperties,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              isFullWidth: true,
              onPressed: () {},
            ),
            SizedBox(height: context.itemSpacing),
            ResponsiveOutlinedButton(
              text: context.l10n.clearSearch,
              foregroundColor: AppColors.primary,
              borderColor: AppColors.primary,
              isFullWidth: true,
              onPressed: () {},
            ),
          ],
        )
        : Row(
          children: [
            Expanded(
              child: ResponsiveElevatedButton(
                text: context.l10n.searchProperties,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                isFullWidth: true,
                onPressed: () {},
              ),
            ),
            SizedBox(width: context.itemSpacing),
            Expanded(
              child: ResponsiveOutlinedButton(
                text: context.l10n.clearSearch,
                foregroundColor: AppColors.primary,
                borderColor: AppColors.primary,
                isFullWidth: true,
                onPressed: () {},
              ),
            ),
          ],
        );
  }
}
