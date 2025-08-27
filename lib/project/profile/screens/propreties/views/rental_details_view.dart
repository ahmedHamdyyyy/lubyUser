import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/images/assets.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../Home/ui/hom_screen.dart';
import '../../../../favorites/view/favourite2.dart';
import '../widgets/amenities_widget.dart';
import '../widgets/booking_details_widget.dart';
import '../widgets/carde_reserve.dart';
import '../widgets/host_details.dart';
import '../widgets/image_list.dart';
import '../widgets/location_widget.dart';
import '../widgets/read_details_widget.dart';
import '../widgets/read_more.dart';
import '../widgets/rental_unit_widget.dart';
import '../widgets/reviews_widget.dart';

class RentalDetailScreen extends StatefulWidget {
  const RentalDetailScreen({super.key, required this.id});
  final String id;
  @override
  State<RentalDetailScreen> createState() => _RentalDetailScreenState();
}

class _RentalDetailScreenState extends State<RentalDetailScreen> {
  bool isExpanded = false;
  @override
  void initState() {
    getIt<HomeCubit>().getProperty(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.propertyStatus == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.propertyStatus == Status.error) {
            return Center(child: Text(state.msg));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Material(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(AssetsData.apartmentView), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                                );
                              },
                              child: const Icon(Icons.arrow_back_ios_new, size: 24, color: Colors.white),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/export.svg',
                                  // ignore: deprecated_member_use
                                  color: Colors.white, // Changes SVG color
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite2Screen()));
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/heart.svg',
                                    // ignore: deprecated_member_use
                                    color: Colors.white, // Changes SVG color
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Title
                    const Positioned(
                      top: 100,
                      bottom: 0,
                      left: 23,
                      child: TextWidget(
                        text: 'Great Studio with a Great View',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 112),
                        CardeReserve(property: state.property),
                        const SizedBox(height: 10),
                        BookingDetailsWidget(state: state),
                        const Driver(),
                        RentalUnitWidget(state: state),
                        const Driver(),
                        LocationWidget(state: state),
                        const Driver(),
                        ReviewsWidget(id: state.property.id, reviewId: state.property.reviewId, isProperty: true),
                        HostDetailsWidget(
                          vendorId: state.property.vendorId.id,
                          vendorName: "${state.property.vendorId.firstName} ${state.property.vendorId.lastName}",
                          vendorImageUrl: "https://www.facebook.com/photo?fbid=864741994898346&set=a.102393161133237",
                        ), 
                        ImageListWidget(images: state.property.medias),
                        const Driver(),
                        if (isExpanded == true)
                          ReadMoreTextWidget(details: state.property.details)
                        else
                          ReadDetailsWidget(details: state.property.details),
                        Center(
                          child: SizedBox(
                            width: 173,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF262626),
                                padding: const EdgeInsets.only(bottom: 2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: TextWidget(
                                text: isExpanded ? 'Read Less' : 'Read More',
                                color: const Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Driver(),
                        AmenitiesWidget(state: state),
                        const SizedBox(height: 20),
                      ],
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
