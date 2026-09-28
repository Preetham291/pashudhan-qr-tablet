import 'package:flutter/material.dart';
import 'package:pashudhan_qr/screens/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    final size = MediaQuery.sizeOf(context);
    final screenHeight = size.height;
    final screenWidth = size.width;

    // Detect tablet using the shortest screen dimension.
    final isTablet = size.shortestSide >= 600;

    // Keep content from becoming excessively wide on 10-inch/tablet
    // landscape screens.
    final contentWidth = isTablet
        ? screenWidth.clamp(600.0, 900.0)
        : screenWidth;

    // Responsive header and character heights.
    final headerHeight = isTablet
        ? (contentWidth * 0.48).clamp(260.0, 430.0)
        : screenHeight * 0.38;

    final charactersHeight = isTablet
        ? (contentWidth * 0.25).clamp(150.0, 240.0)
        : screenHeight * 0.20;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            /// MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      children: [
                        /// HEADER IMAGE
                        SizedBox(
                          height: headerHeight,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/header1.png',
                            fit: BoxFit.fill,
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

                        SizedBox(
                          height: isTablet ? 20 : 24,
                        ),

                        /// PHONE FIELD
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 50 : 40,
                          ),
                          child: TextField(
                            onChanged: viewModel.setPhoneNumber,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 22,
                              fontWeight: FontWeight.w900,
                            ),
                            decoration: InputDecoration(
                              hintText: '80910569**',
                              counterText: '',
                              filled: true,
                              fillColor: const Color(0xFFB4D333),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// LABEL
                        Text(
                          'Enter Your Mobile Number',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// GET STARTED BUTTON
                        GestureDetector(
                          onTap: viewModel.isBusy
                              ? null
                              : viewModel.onGetStarted,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 24 : 20,
                              vertical: isTablet ? 12 : 10,
                            ),
                            decoration: BoxDecoration(
                              color: viewModel.isBusy
                                  ? const Color(0xFFC8A000)
                                  : const Color(0xFFF9C22E),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: viewModel.isBusy
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'GET STARTED',
                                    style: TextStyle(
                                      fontSize: isTablet ? 20 : 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// CHARACTERS
                        SizedBox(
                          height: charactersHeight,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/women1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/doctor1.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/men1.png',
                                  fit: BoxFit.contain,
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
  void onViewModelReady(LoginViewModel viewModel) => viewModel.init();

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}