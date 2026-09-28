import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:pashudhan_qr/models/role.dart';
import 'package:pashudhan_qr/screens/login/role_selection_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RoleSelectionView extends StackedView<RoleSelectionViewModel> {
  const RoleSelectionView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RoleSelectionViewModel viewModel,
    Widget? child,
  ) {
    final size = Responsive.size(context);
    final screenHeight = size.height;

    final isTablet = Responsive.isTablet(context);
    final isLandscape = Responsive.isLandscape(context);

    final contentWidth = Responsive.contentWidth(context);

    // Responsive header height
    final headerHeight = isTablet
        ? isLandscape
            ? (screenHeight * 0.42).clamp(240.0, 340.0)
            : (screenHeight * 0.34).clamp(240.0, 360.0)
        : screenHeight * 0.35;

    // Responsive role image sizes
    final roleImageSize =
        isTablet ? (contentWidth * 0.14).clamp(100.0, 145.0) : 100.0;

    final farmerImageSize =
        isTablet ? (contentWidth * 0.17).clamp(115.0, 165.0) : 120.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// HEADER
                    SizedBox(
                      height: headerHeight,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/header1.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    /// TITLE
                    Container(
                      width: double.infinity,
                      color: const Color(0xFF8A5A2B),
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 8.0 : 6.0,
                        horizontal: 8.0,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Kindly Choose Your Category',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFF9C22E),
                            fontSize: isTablet ? 26 : 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    /// MAIN CONTENT
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: contentWidth,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 32.0 : 16.0,
                            vertical: isTablet ? 28.0 : 24.0,
                          ),
                          child: Column(
                            children: [
                              /// ROLE ROW 1
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildRoleItem(
                                      'ASSOCIATE PARTNER',
                                      'assets/hand_shake.png',
                                      () => viewModel.onRoleSelected(
                                        UserRole.PARTNER,
                                      ),
                                      size: roleImageSize,
                                      buttonWidth: isTablet ? 220 : 160,
                                    ),
                                  ),
                                  SizedBox(
                                    width: isTablet ? 40 : 16,
                                  ),
                                  Expanded(
                                    child: _buildRoleItem(
                                      'ASSOCIATE',
                                      'assets/doctor1.png',
                                      () => viewModel.onRoleSelected(
                                        UserRole.ASSOCIATE,
                                      ),
                                      size: roleImageSize,
                                      buttonWidth: isTablet ? 220 : 160,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: isTablet ? 32 : 24,
                              ),

                              /// ROLE ROW 2
                              _buildRoleItem(
                                'LIVESTOCK FARMER & PET OWNER',
                                'assets/livestockfarmer.png',
                                () => viewModel.onRoleSelected(
                                  UserRole.CUSTOMER,
                                ),
                                size: farmerImageSize,
                                buttonWidth: isTablet ? 320 : 260,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// HINDI BANNER
                    Container(
                      width: double.infinity,
                      color: const Color(0xFF8A5A2B),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 8.0,
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'अब अपने पशुधन की जन्मपत्री अपने हाथ में',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF9C22E),
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// FOOTER
            SizedBox(
              height: isTablet
                  ? (screenHeight * 0.10).clamp(70.0, 110.0)
                  : screenHeight * 0.10,
              width: double.infinity,
              child: Image.asset(
                'assets/footer.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleItem(
    String title,
    String assetPath,
    VoidCallback onTap, {
    double size = 110,
    double buttonWidth = 160,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: buttonWidth,
            constraints: const BoxConstraints(
              minHeight: 42,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFB4D333),
              border: Border.all(
                color: const Color(0xFF5C3317),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF5C3317),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  RoleSelectionViewModel viewModelBuilder(BuildContext context) =>
      RoleSelectionViewModel();
}
