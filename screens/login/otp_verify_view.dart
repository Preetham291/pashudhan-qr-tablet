import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:pashudhan_qr/screens/login/otp_verify_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'otp'),
])
class OtpVerifyView extends StackedView<OtpVerifyViewModel> {
  final String phoneNumber;
  final int otpId;

  const OtpVerifyView({
    super.key,
    required this.phoneNumber,
    required this.otpId,
  });

  @override
  Widget builder(
    BuildContext context,
    OtpVerifyViewModel viewModel,
    Widget? child,
  ) {
    final size = Responsive.size(context);
    final screenHeight = size.height;

    final isTablet = Responsive.isTablet(context);
    final isLandscape = Responsive.isLandscape(context);
    final contentWidth = Responsive.contentWidth(context);

    // Header
    final headerHeight = isTablet
        ? isLandscape
            ? (screenHeight * 0.42).clamp(240.0, 340.0)
            : (screenHeight * 0.34).clamp(240.0, 360.0)
        : screenHeight * 0.35;

    // Responsive OTP field
    final otpWidth = isTablet ? 280.0 : 240.0;
    final otpFontSize = isTablet ? 24.0 : 22.0;

    // Responsive QR size
    final qrSize = isTablet
        ? (contentWidth * 0.16).clamp(120.0, 180.0)
        : screenHeight * 0.16;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            /// SCROLLABLE MAIN CONTENT
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
                          color: const Color(0xFF8A5A2B),
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

                        /// OTP FIELD
                        Center(
                          child: SizedBox(
                            width: otpWidth,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFB4D333),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF5C3317),
                                  width: 3.0,
                                ),
                              ),
                              child: TextField(
                                onChanged: viewModel.setOtp,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: otpFontSize,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: '56**',
                                  counterText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: isTablet ? 14 : 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// OTP LABEL
                        Text(
                          'Enter OTP Recieved On Mobile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: isTablet ? 20 : 18,
                            color: const Color(0xFF5C3317),
                          ),
                        ),

                        SizedBox(
                          height: isTablet ? 18 : 20,
                        ),

                        /// QR IMAGE
                        SizedBox(
                          height: qrSize,
                          width: qrSize,
                          child: Image.asset(
                            'assets/scan_qr.png',
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(
                          height: isTablet ? 20 : 20,
                        ),

                        /// SUBMIT BUTTON
                        GestureDetector(
                          onTap: viewModel.isBusy ? null : viewModel.onVerify,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 48 : 40,
                              vertical: isTablet ? 14 : 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFB4D333),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFF5C3317),
                                width: 2.0,
                              ),
                            ),
                            child: viewModel.isBusy
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'SUBMIT >',
                                    style: TextStyle(
                                      fontSize: isTablet ? 20 : 18,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF5C3317),
                                    ),
                                  ),
                          ),
                        ),

                        /// RESEND OTP
                        TextButton(
                          onPressed:
                              viewModel.isBusy ? null : viewModel.resendOtp,
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: isTablet ? 17 : 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF5C3317),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
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
  OtpVerifyViewModel viewModelBuilder(BuildContext context) =>
      OtpVerifyViewModel(
        phoneNumber: phoneNumber,
        otpId: otpId,
      );
}
