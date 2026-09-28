import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:stacked/stacked.dart';

import 'home_livestock_associate_viewmodel.dart';
import 'add_livestock_details_livestock_associate.dart';
import 'breeding_details_livestock_associate.dart';
import 'vaccination_details_livestock_associate.dart';
import 'pashudhan_card_livestock_associate.dart';
import 'settings_livestock_associate.dart';
import 'package:pashudhan_qr/widgets/ad_player_widget.dart';

class HomeLivestockAssociate
    extends StackedView<HomeLivestockAssociateViewModel> {
  const HomeLivestockAssociate({super.key});

  static const Color primaryYellow = Color(0xFFEDC93A);
  static const Color primaryGreen = Color(0xFFA1BC2A);
  static const Color buttonYellow = Color(0xFFF3D133);
  static const Color darkBrown = Color(0xFF452B14);
  static const Color notificationRed = Color(0xFFF13E42);

  @override
  Widget builder(
    BuildContext context,
    HomeLivestockAssociateViewModel viewModel,
    Widget? child,
  ) {
    final size = Responsive.size(context);
    final isTablet = Responsive.isTablet(context);

    // Keep the main content from becoming excessively wide
    // on 10/11-inch tablets.
    final contentWidth = Responsive.contentWidth(
      context,
      maxWidth: 1050,
    );

    final screenWidth = size.width;

    // Responsive scaling.
    final sc = isTablet
        ? (contentWidth / 700.0).clamp(1.0, 1.35)
        : (screenWidth / 360.0).clamp(0.85, 1.25);

    final adHeight =
        isTablet ? (contentWidth * 0.13).clamp(120.0, 160.0) : 135 * sc;

    final inputHeight = isTablet ? 68.0 : 62 * sc;

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
                      /// AD SPACE
                      SizedBox(
                        height: adHeight,
                        child: _buildAdSpace(
                          onTap: () {},
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// SEARCH / QR ROW
                      SizedBox(
                        height: inputHeight,
                        child: _buildMiddleInputRow(
                          context,
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// OVERVIEW
                      _buildSectionTitle(
                        'Overview',
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        height: isTablet ? 125.0 : 110 * sc,
                        child: _buildOverviewCard(
                          viewModel,
                          isTablet: isTablet,
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// QUICK ACTIONS
                      _buildSectionTitle(
                        'Quick Actions',
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 10),

                      _buildQuickActions(
                        context,
                        viewModel,
                        isTablet: isTablet,
                      ),

                      const SizedBox(height: 8),
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
  HomeLivestockAssociateViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeLivestockAssociateViewModel();

  @override
  void onViewModelReady(
    HomeLivestockAssociateViewModel viewModel,
  ) {
    print("ASSOCIATE SCREEN LOADED");
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

  // ================================================================
  // APP BAR
  // ================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    final toolbarHeight = isTablet ? 100.0 : 90.0;

    return AppBar(
      backgroundColor: primaryYellow,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      shape: const Border(
        bottom: BorderSide(
          color: darkBrown,
          width: 4.0,
        ),
      ),
      flexibleSpace: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 1050.0 : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24.0 : 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// WELCOME
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: isTablet ? 25 : 22,
                            fontWeight: FontWeight.w900,
                            color: darkBrown,
                          ),
                        ),
                        Text(
                          viewModel.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w800,
                            color: darkBrown,
                          ),
                        ),
                        Text(
                          'ID-123456',
                          style: TextStyle(
                            fontSize: isTablet ? 15 : 14,
                            fontWeight: FontWeight.w800,
                            color: darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// RIGHT ICONS
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
        isTablet ? 10 : 8,
      ),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkBrown,
          width: 2.0,
        ),
      ),
      child: Icon(
        icon,
        color: darkBrown,
        size: isTablet ? 34 : 30,
      ),
    );
  }

  Widget _buildProfileAvatar(
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    final size = isTablet ? 56.0 : 48.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: darkBrown,
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: viewModel.isFetchingPic
            ? Padding(
                padding: const EdgeInsets.all(10.0),
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
                    size: isTablet ? 34 : 30,
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
          width: 3.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AdPlayerWidget(
              targetAudience: 'ASSOCIATE',
              apiBaseUrl: 'https://pashudhanqr-api-f5b0885dd324.herokuapp.com',
            ),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SEARCH / QR ROW
  // ================================================================

  Widget _buildMiddleInputRow(
    BuildContext context,
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 16 : 12,
            ),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: darkBrown,
                width: 3.0,
              ),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: viewModel.searchController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                color: darkBrown,
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                hintText: 'Enter registered mobile no',
                hintStyle: TextStyle(
                  color: darkBrown,
                  fontSize: isTablet ? 16 : 15,
                  fontWeight: FontWeight.w800,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => viewModel.searchCustomer(context),
            child: Container(
              decoration: BoxDecoration(
                color: darkBrown,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: buttonYellow,
                  width: 3.0,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.search,
                  color: buttonYellow,
                  size: isTablet ? 44 : 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => viewModel.scanQr(context),
            child: Container(
              decoration: BoxDecoration(
                color: buttonYellow,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: darkBrown,
                  width: 3.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/icons_home/customer/pet_owner/qr_image1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
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
        fontSize: isTablet ? 21 : 18,
        fontWeight: FontWeight.bold,
        color: darkBrown,
      ),
    );
  }

  // ================================================================
  // OVERVIEW
  // ================================================================

  Widget _buildOverviewCard(
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        isTablet ? 18 : 14,
        isTablet ? 12 : 10,
        isTablet ? 18 : 14,
        isTablet ? 16 : 14,
      ),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: darkBrown,
          width: 3.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Registered Livestocks',
            style: TextStyle(
              fontSize: isTablet ? 17 : 15,
              fontWeight: FontWeight.w900,
              color: darkBrown,
              height: 1.0,
            ),
          ),
          Text(
            '${viewModel.totalAnimals}',
            style: TextStyle(
              fontSize: isTablet ? 17 : 15,
              fontWeight: FontWeight.w900,
              color: darkBrown,
              height: 1.0,
            ),
          ),
          SizedBox(
            height: isTablet ? 46 : 40,
            child: Row(
              children: [
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.cowCount}',
                    'COW',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 16 : 12,
                ),
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.buffaloCount}',
                    'BUFFALO',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 16 : 12,
                ),
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.goatCount}',
                    'GOAT',
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
        color: buttonYellow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: darkBrown,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w900,
              color: darkBrown,
              height: 1.0,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 15 : 14,
              fontWeight: FontWeight.w900,
              color: darkBrown,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // QUICK ACTIONS
  // ================================================================

  Widget _buildQuickActions(
    BuildContext context,
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        final tileWidth = (totalWidth - 24) / 4;

        final rowHeight = isTablet ? tileWidth * 1.30 : tileWidth * 1.45;

        return Column(
          children: [
            /// ROW 1
            SizedBox(
              height: rowHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/vaccination_yellow_report.png',
                      label: 'Add Livestock\nVaccination\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const VaccinationDetailsLivestockAssociate(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth * 2 + 8,
                    child: _buildScanMeWideTile(
                      onTap: () => viewModel.scanMuzzle(context),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/breading_report.png',
                      label: 'Add Livestock\nBreeding\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BreedingDetailsLivestockAssociate(),
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
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/health_certificate_green.png',
                      label: 'Add Livestock\nHealth\nCertificate',
                      bgColor: primaryGreen,
                      borderColor: const Color(0xFFF0D735),
                      onTap: () {},
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/add_livestock_farmer.png',
                      label: 'Add Livestock\nFarmer',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AddLivestockDetailsLivestockAssociate(),
                        ),
                      ).then(
                        (_) => viewModel.refresh(),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/pashudhan_qr.png',
                      label: 'Update Livestock\nPashuDhanQR',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const PashudhanCardLivestockAssociate(),
                        ),
                      ).then(
                        (_) => viewModel.refresh(),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/livestock_farmer/trest_livestock.png',
                      label: 'Coming Soon',
                      bgColor: Colors.white,
                      borderColor: darkBrown,
                      fontSize: isTablet ? 12 : 10,
                      iconScale: isTablet ? 1.35 : 1.5,
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
    Widget? customIconWidget,
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
                    child: customIconWidget ??
                        (imageAsset != null
                            ? Image.asset(
                                imageAsset,
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => Icon(
                                  icon,
                                  color: darkBrown,
                                ),
                              )
                            : FittedBox(
                                child: Icon(
                                  icon,
                                  color: iconColor ?? darkBrown,
                                ),
                              )),
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

  Widget _buildScanMeWideTile({
    VoidCallback? onTap,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF0D735),
          width: 3.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 6 : 4,
              vertical: isTablet ? 10 : 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: Transform.scale(
                    scale: isTablet ? 1.25 : 1.5,
                    child: Image.asset(
                      'assets/icons_home/customer/livestock_farmer/muzzle.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Scan Muzzle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 18,
                        fontWeight: FontWeight.w900,
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
  // BOTTOM NAVIGATION
  // ================================================================

  Widget _buildBottomNav(
    BuildContext context,
    HomeLivestockAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    final navHeight = isTablet ? 102.0 : 90.0;

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
        vertical: isTablet ? 10 : 10,
        horizontal: isTablet ? 24 : 12,
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 850.0 : double.infinity,
            ),
            child: SizedBox(
              height: navHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/livestock_farmer/home_icon.png',
                    icon: Icons.home_outlined,
                    label: 'Home',
                    fontSize: isTablet ? 17 : 16,
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/livestock_farmer/new_livestock.png',
                    label: 'Add New\nLivestock',
                    fontSize: isTablet ? 15 : 14,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AddLivestockDetailsLivestockAssociate(),
                      ),
                    ).then(
                      (_) => viewModel.refresh(),
                    ),
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/livestock_farmer/update_livestock.png',
                    label: 'Update Livestock\nOwnership',
                    fontSize: isTablet ? 12.5 : 10.5,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/livestock_farmer/settings.png',
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    fontSize: isTablet ? 17 : 16,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsLivestockAssociate(),
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

    if (itemSize > (isTablet ? 110 : 88)) {
      itemSize = isTablet ? 110 : 88;
    }

    final scale = itemSize / (isTablet ? 110.0 : 88.0);

    return GestureDetector(
      onTap: onTap ?? () {},
      child: SizedBox(
        width: itemSize,
        height: itemSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFF0D735),
            borderRadius: BorderRadius.circular(
              22 * scale,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
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
              const SizedBox(height: 3),
              FittedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
