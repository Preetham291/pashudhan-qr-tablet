import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:stacked/stacked.dart';

import 'home_customer_pet_viewmodel.dart';
import 'package:pashudhan_qr/screens/home/customer_home/pet_owner/reminders_customer_pet.dart';
import 'package:pashudhan_qr/screens/home/customer_home/pet_owner/vaccination_details_customer_pet.dart';
import 'pashudhan_card_customer_pet.dart';
import 'breeding_details_customer_pet.dart';
import 'settings_customer_pet.dart';
import 'deworming_details_customer_pet.dart';
import 'routes/health_report_pet_screen.dart';
import 'routes/buy_pet_screen.dart';
import 'routes/sell_pet_screen.dart';
import 'package:pashudhan_qr/widgets/ad_player_widget.dart';

class HomeCustomerPet extends StackedView<HomeCustomerPetViewModel> {
  const HomeCustomerPet({super.key});

  static const Color primaryYellow = Color(0xFFEDC93A);
  static const Color primaryGreen = Color(0xFFA1BC2A);
  static const Color buttonYellow = Color(0xFFF3D133);
  static const Color darkBrown = Color(0xFF452B14);
  static const Color notificationRed = Color(0xFFF13E42);

  @override
  Widget builder(
    BuildContext context,
    HomeCustomerPetViewModel viewModel,
    Widget? child,
  ) {
    final size = Responsive.size(context);
    final isTablet = Responsive.isTablet(context);

    final contentWidth = Responsive.contentWidth(
      context,
      maxWidth: 1050,
    );

    final screenWidth = size.width;

    final sc = isTablet
        ? (contentWidth / 700.0).clamp(1.0, 1.35)
        : (screenWidth / 360.0).clamp(0.85, 1.25);

    final adHeight =
        isTablet ? (contentWidth * 0.13).clamp(120.0, 160.0) : 130 * sc;

    final overviewHeight = isTablet ? 130.0 : 110 * sc;

    final quickActionsHeight = isTablet ? 300.0 : 220.0;

    final servicesHeight = isTablet ? 68.0 : 55.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(
          context,
          viewModel,
          isTablet: isTablet,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contentWidth,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24.0 : 16.0,
                    vertical: isTablet ? 18.0 : 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// AD
                      SizedBox(
                        height: adHeight,
                        child: _buildAdSpace(
                          onTap: () {},
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// OVERVIEW
                      _buildSectionTitle(
                        'Overview',
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        height: overviewHeight,
                        child: _buildOverviewCard(
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// QUICK ACTIONS
                      _buildSectionTitle(
                        'Quick Actions',
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        height: quickActionsHeight,
                        child: _buildQuickActions(
                          context,
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// OTHER SERVICES
                      SizedBox(
                        height: servicesHeight,
                        child: _buildOtherServices(
                          context,
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNav(
          context,
          viewModel,
          isTablet: isTablet,
        ),
      ),
    );
  }

  @override
  HomeCustomerPetViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeCustomerPetViewModel();

  @override
  void onViewModelReady(
    HomeCustomerPetViewModel viewModel,
  ) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

  // ================================================================
  // APP BAR
  // ================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    return AppBar(
      backgroundColor: primaryYellow,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: isTablet ? 92 : 70,
      flexibleSpace: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 1050 : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 16,
                            fontWeight: FontWeight.w700,
                            color: darkBrown,
                          ),
                        ),
                        Text(
                          viewModel.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isTablet ? 24 : 20,
                            fontWeight: FontWeight.w900,
                            color: darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: viewModel.onNotificationIconTapped,
                        child: _buildTopIconWithBadge(
                          Icons.notifications_none_outlined,
                          viewModel.notificationCount,
                          isTablet: isTablet,
                        ),
                      ),
                      SizedBox(
                        width: isTablet ? 14 : 10,
                      ),
                      GestureDetector(
                        onTap: viewModel.onProfileIconTapped,
                        child: _buildProfileAvatar(
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopIconWithBadge(
    IconData icon,
    int count, {
    required bool isTablet,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildTopIcon(
          icon,
          isTablet: isTablet,
        ),
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: notificationRed,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopIcon(
    IconData icon, {
    required bool isTablet,
  }) {
    return Container(
      padding: EdgeInsets.all(
        isTablet ? 9 : 6,
      ),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkBrown,
          width: isTablet ? 2 : 1.5,
        ),
      ),
      child: Icon(
        icon,
        color: darkBrown,
        size: isTablet ? 31 : 26,
      ),
    );
  }

  Widget _buildProfileAvatar(
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    final avatarSize = isTablet ? 52.0 : 42.0;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkBrown,
          width: isTablet ? 2 : 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: viewModel.isFetchingPic
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: darkBrown,
                  strokeWidth: 2,
                ),
              )
            : viewModel.profilePicBytes != null
                ? Image.memory(
                    viewModel.profilePicBytes!,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.person_outline,
                    color: darkBrown,
                    size: isTablet ? 31 : 26,
                  ),
      ),
    );
  }

  // ================================================================
  // AD SPACE
  // ================================================================

  Widget _buildAdSpace({
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: darkBrown,
          width: 2.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: const AdPlayerWidget(
              targetAudience: 'PET_CUSTOMER',
              apiBaseUrl: 'https://pashudhanqr-api-f5b0885dd324.herokuapp.com',
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget _buildSectionTitle(
    String title, {
    required bool isTablet,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isTablet ? 22 : 20,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
    );
  }

  // ================================================================
  // OVERVIEW
  // ================================================================

  Widget _buildOverviewCard(
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 18 : 14,
        vertical: isTablet ? 12 : 8,
      ),
      decoration: BoxDecoration(
        color: primaryYellow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: darkBrown,
          width: 2.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Registered Pets',
            style: TextStyle(
              fontSize: isTablet ? 15 : 12,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          Text(
            viewModel.totalPets.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: isTablet ? 26 : 22,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.maleDogCount}',
                    'Male Dog',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 12 : 8,
                ),
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.femaleDogCount}',
                    'Female Dog',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 12 : 8,
                ),
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.catCount}',
                    'CAT',
                    isTablet: isTablet,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalCountPill(
    String count,
    String label, {
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: darkBrown,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 8 : 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      count,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w900,
                        color: darkBrown,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isTablet ? 13 : 11,
                        fontWeight: FontWeight.w900,
                        color: darkBrown,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // QUICK ACTIONS
  // ================================================================

  Widget _buildQuickActions(
    BuildContext context,
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final rowHeight = isTablet ? 140.0 : 105.0;

        return Column(
          children: [
            /// ROW 1
            SizedBox(
              height: rowHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/pashudhan_qr_petowner.png',
                      label: 'Get Pashudhan QR\nReport of your Pet',
                      bgColor: primaryGreen,
                      borderColor: darkBrown,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PashudhanCardCustomerPet(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/pet_breading_report.png',
                      label: 'Get Breeding\nReport of Your Pet',
                      bgColor: buttonYellow,
                      borderColor: darkBrown,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BreedingDetailsCustomerPet(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/vaccination_yellow_report.png',
                      label: 'Get Vaccination\nReport of Your Pet',
                      bgColor: primaryGreen,
                      borderColor: darkBrown,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VaccinationDetailsCustomerPet(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// ROW 2
            SizedBox(
              height: rowHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/pet_deworming_report.png',
                      label: 'Get Deworming\nReport of Your Pet',
                      bgColor: buttonYellow,
                      borderColor: darkBrown,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DewormingDetailsCustomerPet(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/health_report.png',
                      label: 'Get Health\nReport of Your Pet',
                      bgColor: primaryGreen,
                      borderColor: darkBrown,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HealthReportPetScreen(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/trest_livestock.png',
                      label: 'Coming Soon',
                      bgColor: Colors.white,
                      borderColor: darkBrown,
                      iconScale: 1.5,
                      fontSize: 13.0,
                      onTap: () {},
                      isTablet: isTablet,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionTile({
    String? imageAsset,
    IconData? icon,
    required String label,
    required Color bgColor,
    required Color borderColor,
    Color? iconColor,
    VoidCallback? onTap,
    double iconScale = 1.0,
    double fontSize = 11.0,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 2.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 6 : 4,
              vertical: isTablet ? 8 : 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Transform.scale(
                    scale: iconScale,
                    child: imageAsset != null
                        ? Image.asset(
                            imageAsset,
                            fit: BoxFit.contain,
                          )
                        : FittedBox(
                            child: Icon(
                              icon,
                              color: iconColor ?? darkBrown,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? fontSize + 2 : fontSize,
                        fontWeight: FontWeight.w800,
                        color: darkBrown,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // OTHER SERVICES
  // ================================================================

  Widget _buildOtherServices(
    BuildContext context,
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _buildServicePill(
            imageAsset:
                'assets/icons_home/customer/pet_owner/pets_insurence.png',
            label: 'Pets\nInsurance',
            bgColor: primaryGreen,
            onTap: () {},
            isTablet: isTablet,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildServicePill(
            imageAsset: 'assets/icons_home/customer/pet_owner/pets_show.png',
            label: 'Pets\nShow',
            bgColor: buttonYellow,
            centerContent: true,
            onTap: () {},
            isTablet: isTablet,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildServicePill(
            imageAsset:
                'assets/icons_home/customer/pet_owner/reminder_pets.png',
            label: 'Reminder\nfor pets',
            bgColor: primaryGreen,
            notificationCount: viewModel.notificationCount,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RemindersCustomerPetScreen(),
                ),
              );
            },
            isTablet: isTablet,
          ),
        ),
      ],
    );
  }

  Widget _buildServicePill({
    String? imageAsset,
    IconData? icon,
    required String label,
    required Color bgColor,
    VoidCallback? onTap,
    int? notificationCount,
    bool centerContent = false,
    required bool isTablet,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: darkBrown,
              width: 2.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap ?? () {},
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isTablet ? 6 : 4,
                  horizontal: isTablet ? 8 : 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Transform.scale(
                        scale: isTablet ? 1.25 : 1.2,
                        child: imageAsset != null
                            ? Image.asset(
                                imageAsset,
                                fit: BoxFit.contain,
                              )
                            : FittedBox(
                                child: Icon(
                                  icon,
                                  color: darkBrown,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 5,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isTablet ? 15 : 13,
                            fontWeight: FontWeight.w800,
                            color: darkBrown,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (notificationCount != null && notificationCount > 0)
          Positioned(
            right: -2,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: notificationRed,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$notificationCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ================================================================
  // BOTTOM NAVIGATION
  // ================================================================

  Widget _buildBottomNav(
    BuildContext context,
    HomeCustomerPetViewModel viewModel, {
    required bool isTablet,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryGreen,
        border: Border(
          top: BorderSide(
            color: darkBrown,
            width: 4.0,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: isTablet ? 24 : 12,
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 850 : double.infinity,
            ),
            child: SizedBox(
              height: isTablet ? 102 : 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/home_icon.png',
                    label: 'Home',
                    fontSize: isTablet ? 17 : 16,
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/buy_pets.png',
                    label: 'Buy Pets',
                    fontSize: isTablet ? 15 : 14,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BuyPetScreen(),
                      ),
                    ),
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/sell_pets.png',
                    label: 'Sell Pets',
                    fontSize: isTablet ? 15 : 14,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SellPetScreen(),
                      ),
                    ),
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/settings.png',
                    label: 'Setting',
                    fontSize: isTablet ? 17 : 16,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsCustomerPet(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    String? imageAsset,
    IconData? icon,
    required String label,
    required double fontSize,
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;

    final availableWidth = isTablet ? 800.0 : screenWidth;

    double itemSize = (availableWidth - 24 - (3 * 8.0)) / 4;

    final maxItemSize = isTablet ? 110.0 : 88.0;

    if (itemSize > maxItemSize) {
      itemSize = maxItemSize;
    }

    final scale = itemSize / maxItemSize;

    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: itemSize,
        height: itemSize,
        padding: EdgeInsets.all(
          4 * scale,
        ),
        decoration: BoxDecoration(
          color: primaryYellow,
          borderRadius: BorderRadius.circular(
            22 * scale,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: imageAsset != null
                    ? Image.asset(
                        imageAsset,
                        width: 48 * scale,
                        height: 48 * scale,
                        fit: BoxFit.contain,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) =>
                            Icon(
                          icon,
                          color: darkBrown,
                          size: 48 * scale,
                        ),
                      )
                    : Icon(
                        icon,
                        color: darkBrown,
                        size: 48 * scale,
                      ),
              ),
            ),
            SizedBox(
              height: 3 * scale,
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize * scale,
                      fontWeight: FontWeight.w900,
                      color: darkBrown,
                      height: 1.05,
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
}
