import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:pashudhan_qr/screens/login/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StackedView<SplashViewModel> {
  final bool skipDelay;

  const SplashView({
    super.key,
    this.skipDelay = false,
  });

  @override
  Widget builder(
    BuildContext context,
    SplashViewModel viewModel,
    Widget? child,
  ) {
    final size = Responsive.size(context);
    final screenHeight = size.height;

    final isTablet = Responsive.isTablet(context);
    final isLandscape = Responsive.isLandscape(context);
    final contentWidth = Responsive.contentWidth(context);

    // Responsive header
    final headerHeight = isTablet
        ? isLandscape
            ? (screenHeight * 0.42).clamp(240.0, 340.0)
            : (screenHeight * 0.36).clamp(240.0, 380.0)
        : screenHeight * 0.40;

    // Responsive QR
    final qrSize = isTablet
        ? (contentWidth * 0.18).clamp(120.0, 190.0)
        : screenHeight * 0.18;

    // Responsive characters section
    final charactersHeight = isTablet
        ? (screenHeight * 0.22).clamp(150.0, 240.0)
        : screenHeight * 0.22;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: contentWidth,
                    ),
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

                        /// HINDI BANNER
                        Container(
                          width: double.infinity,
                          color: const Color.fromARGB(
                            255,
                            155,
                            190,
                            15,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 8.0 : 6.0,
                            horizontal: 8.0,
                          ),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'अब अपने पशुधन की जन्मपत्री अपने हाथ में',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF8A5A2B),
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: isTablet ? 20 : 16,
                        ),

                        /// QR SECTION
                        Center(
                          child: SizedBox(
                            height: qrSize,
                            width: qrSize,
                            child: Image.asset(
                              'assets/scan_qr.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: isTablet ? 20 : 16,
                        ),

                        /// CHARACTERS
                        SizedBox(
                          height: charactersHeight,
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 12,
                                child: Image.asset(
                                  'assets/women1.png',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              const Spacer(flex: 2),
                              Expanded(
                                flex: 12,
                                child: Image.asset(
                                  'assets/doctor1.png',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              const Spacer(flex: 1),
                              Expanded(
                                flex: 10,
                                child: Image.asset(
                                  'assets/men1.png',
                                  fit: BoxFit.contain,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    viewModel.init(skipDelay);
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) => SplashViewModel();
}
