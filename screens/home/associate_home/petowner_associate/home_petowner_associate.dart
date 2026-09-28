import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:stacked/stacked.dart';

import 'home_petowner_associate_viewmodel.dart';
import 'add_pet_details_petowner_associate.dart';
import 'breeding_details_petowner_associate.dart';
import 'vaccination_details_petowner_associate.dart';
import 'settings_petowner_associate.dart';
import 'package:pashudhan_qr/widgets/ad_player_widget.dart';
import 'deworming_details_petowner_associate.dart';
import 'livestock_member_details_petowner_associate.dart';
import 'pet_card_petowner_associate.dart';

class HomePetOwnerAssociate
    extends StackedView<HomePetOwnerAssociateViewModel> {
  const HomePetOwnerAssociate({super.key});

  static const Color primaryYellow = Color(0xFFEDC93A);
  static const Color primaryGreen = Color(0xFFA1BC2A);
  static const Color buttonYellow = Color(0xFFF3D133);
  static const Color darkBrown = Color(0xFF452B14);
  static const Color notificationRed = Color(0xFFF13E42);

  @override
  Widget builder(
    BuildContext context,
    HomePetOwnerAssociateViewModel viewModel,
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
        body: SingleChildScrollView(
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
        bottomNavigationBar: _buildBottomNav(
          context,
          viewModel,
          isTablet: isTablet,
        ),
      ),
    );
  }

  @override
  HomePetOwnerAssociateViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomePetOwnerAssociateViewModel();

  @override
  void onViewModelReady(
    HomePetOwnerAssociateViewModel viewModel,
  ) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

  // ================================================================
  // APP BAR
  // ================================================================

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    HomePetOwnerAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return AppBar(
      backgroundColor: primaryGreen,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: isTablet ? 100 : 90,
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
        color: primaryYellow,
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
    HomePetOwnerAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    final avatarSize = isTablet ? 56.0 : 48.0;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: primaryYellow,
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
        color: primaryYellow,
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
            child: const AdPlayerWidget(
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
    HomePetOwnerAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 14 : 8,
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
                fontSize: isTablet ? 17 : 14,
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                hintText: 'Enter registered mobile no',
                hintStyle: TextStyle(
                  color: darkBrown,
                  fontSize: isTablet ? 16 : 16,
                  fontWeight: FontWeight.w800,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
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
                  size: isTablet ? 44 : 32,
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
    HomePetOwnerAssociateViewModel viewModel, {
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
            'Total Registered Pets',
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
                    '${viewModel.maleDogCount}',
                    'Male Dog',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 16 : 12,
                ),
                Expanded(
                  child: _buildAnimalCountPill(
                    '${viewModel.femaleDogCount}',
                    'Female Dog',
                    isTablet: isTablet,
                  ),
                ),
                SizedBox(
                  width: isTablet ? 16 : 12,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w900,
              color: darkBrown,
              height: 1.0,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
    HomePetOwnerAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final tileWidth = (totalWidth - 24) / 4;

        final rowHeight = isTablet ? tileWidth * 1.30 : tileWidth * 1.35;

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
                          'assets/icons_home/customer/pet_owner/vaccination_green_report.png',
                      label: 'Update Pet\nVaccination\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const VaccinationDetailsPetOwnerAssociate(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/pet_breading_report.png',
                      label: 'Update Pet\nBreeding\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BreedingDetailsPetOwnerAssociate(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/pet_deworming_report.png',
                      label: 'Update Pet\nDeworming\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const DewormingDetailsPetOwnerAssociate(),
                        ),
                      ),
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/health_report1.png',
                      label: 'Update Pet\nHealth\nReport',
                      bgColor: const Color(0xFFF0D735),
                      borderColor: primaryGreen,
                      onTap: () {},
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
                          'assets/icons_home/customer/pet_owner/pashudhan_qr_petowner.png',
                      label: 'Add Pet\nPashuDhanQR',
                      bgColor: primaryGreen,
                      borderColor: primaryYellow,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PetCardPetOwnerAssociate(),
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
                          'assets/icons_home/customer/pet_owner/share_petowner.png',
                      label: 'Share with\nPet Owner',
                      bgColor: primaryGreen,
                      borderColor: primaryYellow,
                      onTap: () {},
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/reminder_pets.png',
                      label: 'Pet Owners\nReminders',
                      bgColor: primaryGreen,
                      borderColor: primaryYellow,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                      },
                      isTablet: isTablet,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: tileWidth,
                    child: _buildActionTile(
                      imageAsset:
                          'assets/icons_home/customer/pet_owner/trest_livestock.png',
                      label: 'Coming Soon',
                      bgColor: Colors.white,
                      borderColor: darkBrown,
                      fontSize: 10.0,
                      iconScale: 1.5,
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

  // ================================================================
  // BOTTOM NAVIGATION
  // ================================================================

  Widget _buildBottomNav(
    BuildContext context,
    HomePetOwnerAssociateViewModel viewModel, {
    required bool isTablet,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryYellow,
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
                    icon: Icons.home_outlined,
                    label: 'Home',
                    fontSize: isTablet ? 17 : 16,
                    isActive: true,
                    onTap: () {},
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/add_new_pet.png',
                    label: 'Add New\nPet',
                    fontSize: isTablet ? 15 : 14,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AddLivestockDetailsPetOwnerAssociate(),
                      ),
                    ).then(
                      (_) => viewModel.refresh(),
                    ),
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/pet_add.png',
                    label: 'Add Pet\nOwner',
                    fontSize: isTablet ? 13 : 12,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LivestockMemberDetailsPetOwnerAssociate(
                          ownerMobile: viewModel.searchController.text.trim(),
                        ),
                      ),
                    ).then(
                      (_) => viewModel.refresh(),
                    ),
                  ),
                  _buildNavItem(
                    context: context,
                    imageAsset:
                        'assets/icons_home/customer/pet_owner/settings.png',
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    fontSize: isTablet ? 17 : 16,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsPetOwnerAssociate(),
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
          color: primaryGreen,
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
