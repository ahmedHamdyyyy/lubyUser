import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import 'current_reservation_details.dart';
import 'current_reservation_details2.dart';
import 'package:google_fonts/google_fonts.dart';

// ==================== RESERVATION SCREEN WIDGETS ====================

// Reservation screen app bar
Widget reservationScreenAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0, left: 20.0),
    child: Row(
      children: [
        InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon)),
        const SizedBox(width: 8),
        Text(
          "Reservation",
          style: GoogleFonts.poppins(
            color: AppColors.grayTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}

// Tab button widget for reservation screen
Widget buildTabButton({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Container(
    width: 160,
    height: 40,
    decoration: BoxDecoration(
      color: isSelected ? AppColors.primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.secondTextColor),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : AppColors.secondTextColor,
            ),
          ),
        ),
      ],
    ),
  );
}

// Hotel/Studio reservation card for current reservations
Widget buildHotelReservationCardCurrentReservation({
  required String imageUrl,
  required String title,
  required String location,
  required String checkInDate,
  required String checkOutDate,
}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Accommodation image
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imageUrl,
                  width: 101,
                  height: 101,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Accommodation details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.grayTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          const TextSpan(
                            text: 'check in ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: checkInDate,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'check out ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: checkOutDate,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Hotel/Studio reservation card for last reservations
Widget buildHotelReservationCardLastReservation({
  required String imageUrl,
  required String title,
  required String location,
  required String checkInDate,
  required String checkOutDate,
  required VoidCallback onViewDetails,
}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Accommodation image
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imageUrl,
                  width: 101,
                  height: 101,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Accommodation details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.grayTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'check in ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: checkInDate,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'check out ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: checkOutDate,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onViewDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'View Reservations Details',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Activity reservation card for current reservations
Widget buildActivityCardCurrentReservation({
  required String imageUrl,
  required String title,
  required String location,
  required int persons,
  required String date,
  required VoidCallback onViewDetails,
}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: 101,
                  height: 101,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Activity details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$persons person',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.grayTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Date ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: date,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // View details button
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onViewDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Reservations Details',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Activity reservation card for last reservations
Widget buildActivityCardLastReservation({
  required String imageUrl,
  required String title,
  required String location,
  required int persons,
  required String date,
  required VoidCallback onViewDetails,
}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 16),
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Activity image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 101,
                  height: 101,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Activity details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$persons person',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.grayTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.secondTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Date ',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                            ),
                          ),
                          TextSpan(
                            text: date,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.grayTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // View details button
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onViewDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'View Reservations Details',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ==================== RESERVATION DETAILS WIDGETS ====================

// App bar for reservation details screens
Widget reservationDetailsAppBar(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0),
    child: Row(
      children: [
        InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon)),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: AppColors.grayTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}

// Screen title widget
Widget reservationTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryColor,
    ),
  );
}

// Reusable item card for both reservation detail screens
Widget buildItemCard({
  required String imagePath,
  required String title,
  required String location,
  required String dateDetails,
  required String price,
  bool showActions = true,
}) {
  return Card(
    color: Colors.white,
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                    child: Image.asset(
                      imagePath,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Content next to the image
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.secondTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          price,
                          style: GoogleFonts.poppins(
                            color: AppColors.secondTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Location
                    Text(
                      location,
                      style: GoogleFonts.poppins(
                        color: AppColors.grayTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Reservation date
                    Text(
                      dateDetails,
                      style: GoogleFonts.poppins(
                        color: AppColors.grayTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                "Free cancellation before 27 October",
                style: GoogleFonts.poppins(
                  color: AppColors.secondTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showActions)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageAssets.editIcon),
                  const SizedBox(width: 10),
                  SvgPicture.asset(ImageAssets.deleteIcon),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

// Host information widget
class HostInfo extends StatelessWidget {
  final bool showMessageIcon;

  const HostInfo({
    super.key,
    this.showMessageIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset('assets/images/saudian_man.png',
              width: 50, height: 50, fit: BoxFit.cover),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity Name - 2 person',
                style: GoogleFonts.poppins(
                  color: AppColors.secondTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )),
            Text('Hosted by',
                style: GoogleFonts.poppins(
                  color: AppColors.secondTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                )),
            Text('Mohamed Abdallah',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: AppColors.grayTextColor,
                  fontSize: 14,
                )),
          ],
        ),
        Spacer(),
        if (showMessageIcon) SvgPicture.asset(ImageAssets.messages2),
      ],
    );
  }
}

// Summary section row item
class SummaryRow extends StatelessWidget {
  final String title;
  final String price;

  const SummaryRow({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
              )),
          Text(price,
              style: GoogleFonts.poppins(
                height: 1.2,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
              )),
        ],
      ),
    );
  }
}

// Summary section title
Widget summaryTitle() {
  return Text(
    'Summary',
    style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryTextColor,
    ),
  );
}

// View reservation summary row
Widget viewSummaryRow(BuildContext context, {VoidCallback? onTap}) {
  return Row(
    children: [
      Image.asset(
        ImageAssets.pdfIcon,
        width: 30,
        height: 30,
      ),
      SizedBox(width: 14),
      Expanded(
        child: Text(
          'View reservation summary',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.secondTextColor,
          ),
        ),
      ),
      InkWell(
        onTap: onTap,
        child: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.grayColorIcon,
        ),
      )
    ],
  );
}

// Main content for the current reservation details screen
class CurrentReservationDetailsContent extends StatelessWidget {
  const CurrentReservationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reservationDetailsAppBar(context, "Current Reservations"),
          const SizedBox(height: 22),
          reservationTitle('Reservation Number 1234'),
          SizedBox(height: 16),
          buildItemCard(
            imagePath: 'assets/images/image6.png',
            title: "Studio - 5 Night",
            location: "Riyadh - District Name",
            dateDetails: "Check-in  14/10/2024\nCheck-out 19/10/2024",
            price: "4000 SAR",
          ),
          HostInfo(),
          Divider(height: 32, thickness: 1),
          buildItemCard(
            imagePath: 'assets/images/image7.png',
            title: "Activity Name\n2 person",
            location: "Riyadh - District Name",
            dateDetails: "Date: 14/10/2024",
            price: "4000 SAR",
          ),
          HostInfo(),
          Divider(height: 32, thickness: 1),
          summaryTitle(),
          SizedBox(height: 8),
          SummaryRow(title: '5 nights × 800', price: '4000 SAR'),
          SummaryRow(title: '2 Person × 800', price: '4000 SAR'),
          SummaryRow(title: 'Vat', price: '0 SAR'),
          SummaryRow(title: 'Discount', price: '-200 SAR'),
          SummaryRow(title: 'Discount', price: '-1000 SAR'),
          SizedBox(height: 16),
          Divider(height: 32, thickness: 1),
          viewSummaryRow(context, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurretReservationDetailsScreen2(),
              ),
            );
          }),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

// Main content for the past reservation details screen
class PastReservationDetailsContent extends StatelessWidget {
  const PastReservationDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reservationDetailsAppBar(context, "Last Reservation"),
          const SizedBox(height: 22),
          reservationTitle('Last Number 1234'),
          SizedBox(height: 16),
          buildItemCard(
            imagePath: 'assets/images/image6.png',
            title: "Studio - 5 Night",
            location: "Riyadh - District Name",
            dateDetails: "Check-in  14/10/2024\nCheck-out 19/10/2024",
            price: "4000 SAR",
            showActions: false,
          ),
          HostInfo(showMessageIcon: false),
          Divider(height: 32, thickness: 1),
          buildItemCard(
            imagePath: 'assets/images/image7.png',
            title: "Activity Name\n2 person",
            location: "Riyadh - District Name",
            dateDetails: "Date: 14/10/2024",
            price: "4000 SAR",
            showActions: false,
          ),
          HostInfo(showMessageIcon: false),
          Divider(height: 32, thickness: 1),
          summaryTitle(),
          SizedBox(height: 8),
          SummaryRow(title: '5 nights × 800', price: '4000 SAR'),
          SummaryRow(title: '2 Person × 800', price: '4000 SAR'),
          SummaryRow(title: 'Vat', price: '0 SAR'),
          SummaryRow(title: 'Discount', price: '-200 SAR'),
          SummaryRow(title: 'Discount', price: '-1000 SAR'),
          SizedBox(height: 16),
          Divider(height: 32, thickness: 1),
          viewSummaryRow(context),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

// Reservation Container for Current Reservations
Widget buildCurrentReservationContainer({
  required BuildContext context,
  required String hotelImageUrl,
  required String hotelTitle,
  required String hotelLocation,
  required String checkInDate,
  required String checkOutDate,
  required String activityImageUrl,
  required String activityTitle,
  required String activityLocation,
  required int activityPersons,
  required String activityDate,
  required VoidCallback onViewDetails,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primary),
    ),
    child: Column(
      children: [
        buildHotelReservationCardCurrentReservation(
          imageUrl: hotelImageUrl,
          title: hotelTitle,
          location: hotelLocation,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
        ),
        buildActivityCardCurrentReservation(
          imageUrl: activityImageUrl,
          title: activityTitle,
          location: activityLocation,
          persons: activityPersons,
          date: activityDate,
          onViewDetails: onViewDetails,
        ),
      ],
    ),
  );
}

// Complete screen content for the reservation list
class ReservationScreenContent extends StatefulWidget {
  const ReservationScreenContent({super.key});

  @override
  State<ReservationScreenContent> createState() =>
      _ReservationScreenContentState();
}

class _ReservationScreenContentState extends State<ReservationScreenContent> {
  bool isCurrentReservations = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reservationScreenAppBar(context),
        const SizedBox(height: 22),

        // Reservation Title
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: Text(
            'Reservation',
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Tab buttons
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
            top: 0,
            right: 18,
            left: 18,
          ),
          child: Row(
            children: [
              Expanded(
                child: buildTabButton(
                  text: 'Current Reservations',
                  isSelected: isCurrentReservations,
                  onTap: () {
                    setState(() {
                      isCurrentReservations = true;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: buildTabButton(
                  text: 'Last Reservations',
                  isSelected: !isCurrentReservations,
                  onTap: () {
                    setState(() {
                      isCurrentReservations = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        // Reservation cards list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: isCurrentReservations
                ? [
                    // Current Reservations
                    buildCurrentReservationContainer(
                      context: context,
                      hotelImageUrl: 'assets/images/image6.png',
                      hotelTitle: 'Studio - 5 Night',
                      hotelLocation: 'Riyadh - District Name',
                      checkInDate: '14/10/2024',
                      checkOutDate: '19/10/2024',
                      activityImageUrl: 'assets/images/image7.png',
                      activityTitle: 'Activity Name',
                      activityLocation: 'Riyadh - District Name',
                      activityPersons: 2,
                      activityDate: '14/10/2024',
                      onViewDetails: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CurretReservationDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    buildCurrentReservationContainer(
                      context: context,
                      hotelImageUrl: 'assets/images/image6.png',
                      hotelTitle: 'Studio - 5 Night',
                      hotelLocation: 'Riyadh - District Name',
                      checkInDate: '14/10/2024',
                      checkOutDate: '19/10/2024',
                      activityImageUrl: 'assets/images/image7.png',
                      activityTitle: 'Activity Name',
                      activityLocation: 'Riyadh - District Name',
                      activityPersons: 2,
                      activityDate: '14/10/2024',
                      onViewDetails: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CurretReservationDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ]
                : [
                    // Last Reservations
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: buildHotelReservationCardLastReservation(
                            imageUrl: 'assets/images/image6.png',
                            title: 'Studio - 5 Night',
                            location: 'Riyadh - District Name',
                            checkInDate: '14/10/2024',
                            checkOutDate: '19/10/2024',
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CurretReservationDetailsScreen2(),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: buildActivityCardLastReservation(
                            imageUrl: 'assets/images/image7.png',
                            title: 'Activity Name',
                            location: 'Riyadh - District Name',
                            persons: 2,
                            date: '14/10/2024',
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CurretReservationDetailsScreen2(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
          ),
        ),
      ],
    );
  }
}
