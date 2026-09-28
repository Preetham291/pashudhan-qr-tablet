import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:stacked/stacked.dart';

import 'photo_upload_viewmodel.dart';

class PhotoUploadView extends StackedView<PhotoUploadViewModel> {
  final String uuid;
  final bool? isPet;

  const PhotoUploadView({
    super.key,
    required this.uuid,
    this.isPet,
  });

  static const Color primaryYellow = Color(0xFFEDC93A);
  static const Color primaryGreen = Color(0xFFA1BC2A);
  static const Color darkBrown = Color(0xFF452B14);
  static const Color buttonYellow = Color(0xFFF3D133);

  @override
  void onViewModelReady(PhotoUploadViewModel viewModel) {
    viewModel.init();
  }

  /// Shows a bottom sheet for Camera / Gallery source selection.
  void _showSourcePicker(
    BuildContext context,
    PhotoUploadViewModel viewModel,
  ) {
    final isTablet = Responsive.isTablet(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: isTablet ? 40 : 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Text(
              'Add Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceTile(
                  context: context,
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.pickFromCamera();
                  },
                ),
                _buildSourceTile(
                  context: context,
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.pickFromGallery();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isTablet = Responsive.isTablet(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: isTablet ? 84 : 72,
            height: isTablet ? 84 : 72,
            decoration: BoxDecoration(
              color: primaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: primaryGreen,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: isTablet ? 42 : 36,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w700,
              color: darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget builder(
    BuildContext context,
    PhotoUploadViewModel viewModel,
    Widget? child,
  ) {
    final typeName =
        isPet == true ? 'Pet' : (isPet == false ? 'Livestock' : 'Associate');

    final photoCount = viewModel.selectedImages.length;

    final size = Responsive.size(context);
    final screenWidth = size.width;

    final isTablet = Responsive.isTablet(context);
    final isLandscape = Responsive.isLandscape(context);

    final contentWidth = Responsive.contentWidth(
      context,
      maxWidth: 1100,
    );

    // Tablet-aware padding.
    final horizontalPadding = isTablet ? 28.0 : 16.0;
    final verticalPadding = isTablet ? 20.0 : 16.0;

    // Responsive empty-state width.
    final emptyStateWidth =
        isTablet ? contentWidth.clamp(500.0, 760.0) : screenWidth * 0.82;

    // Responsive grid columns.
    //
    // Phone      -> 2 columns
    // Tablet     -> 3 columns
    // Large tab  -> 3 columns
    final gridColumns = isTablet ? 3 : 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryGreen,
        appBar: AppBar(
          backgroundColor: darkBrown,
          title: Text(
            'UPLOAD $typeName PHOTOS',
            style: TextStyle(
              color: primaryYellow,
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 21 : 18,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: primaryYellow,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: primaryGreen,
            image: DecorationImage(
              image: AssetImage('assets/pattern_bg.png'),
              repeat: ImageRepeat.repeat,
              opacity: 0.15,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: contentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    /// PHOTO COUNT BADGE
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 22 : 18,
                        vertical: isTablet ? 12 : 10,
                      ),
                      decoration: BoxDecoration(
                        color: darkBrown.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_library,
                            color: primaryYellow,
                            size: isTablet ? 21 : 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$photoCount / 5 photos selected',
                            style: TextStyle(
                              color: primaryYellow,
                              fontWeight: FontWeight.w700,
                              fontSize: isTablet ? 16 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// PROGRESS BAR
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: photoCount / 5,
                        minHeight: isTablet ? 10 : 8,
                        backgroundColor: Colors.white30,
                        color: photoCount == 5 ? Colors.green : primaryYellow,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      photoCount < 5
                          ? 'Select exactly 5 photos of the $typeName to continue.'
                          : '✅ All 5 photos selected. Ready to submit!',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: photoCount == 5 ? Colors.white : darkBrown,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    /// PHOTO AREA
                    Expanded(
                      child: photoCount == 0
                          ? Center(
                              child: Container(
                                width: emptyStateWidth,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      isLandscape && isTablet ? 330 : 430,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: isTablet ? 42 : 36,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: isTablet ? 72 : 60,
                                      color: primaryGreen,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No photos selected yet',
                                      style: TextStyle(
                                        fontSize: isTablet ? 19 : 16,
                                        fontWeight: FontWeight.w700,
                                        color: darkBrown,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap the button below to pick photos\n'
                                      'from your camera or gallery.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isTablet ? 15 : 13,
                                        color: const Color(0xFF5A6B87),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    GestureDetector(
                                      onTap: viewModel.isBusy
                                          ? null
                                          : () => _showSourcePicker(
                                                context,
                                                viewModel,
                                              ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isTablet ? 38 : 32,
                                          vertical: isTablet ? 16 : 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: buttonYellow,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.upload_rounded,
                                              color: darkBrown,
                                              size: isTablet ? 26 : 24,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Upload Photo',
                                              style: TextStyle(
                                                color: darkBrown,
                                                fontSize: isTablet ? 19 : 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          /// PHOTO GRID
                          : Column(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(
                                      bottom: 4,
                                    ),
                                    itemCount: photoCount,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridColumns,
                                      crossAxisSpacing: isTablet ? 14 : 10,
                                      mainAxisSpacing: isTablet ? 14 : 10,
                                      childAspectRatio:
                                          isLandscape && isTablet ? 1.15 : 1.0,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.file(
                                              File(
                                                viewModel
                                                    .selectedImages[index].path,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                          /// DELETE
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: viewModel.isBusy
                                                  ? null
                                                  : () => viewModel
                                                      .removeImage(index),
                                              child: CircleAvatar(
                                                radius: isTablet ? 16 : 14,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: isTablet ? 20 : 18,
                                                ),
                                              ),
                                            ),
                                          ),

                                          /// NUMBER
                                          Positioned(
                                            bottom: 5,
                                            left: 5,
                                            child: CircleAvatar(
                                              radius: isTablet ? 14 : 12,
                                              backgroundColor:
                                                  darkBrown.withValues(
                                                alpha: 0.8,
                                              ),
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                  color: primaryYellow,
                                                  fontSize: isTablet ? 12 : 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// CRUD ACTIONS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (photoCount < 5 && !viewModel.isBusy)
                                      _buildIconButton(
                                        icon: Icons.upload_rounded,
                                        label: 'Add More',
                                        onTap: () => _showSourcePicker(
                                          context,
                                          viewModel,
                                        ),
                                        isTablet: isTablet,
                                      ),
                                    if (photoCount > 0 &&
                                        !viewModel.isBusy) ...[
                                      const SizedBox(width: 12),
                                      _buildIconButton(
                                        icon: Icons.delete_sweep,
                                        label: 'Clear All',
                                        onTap: () => viewModel.clearAllImages(),
                                        danger: true,
                                        isTablet: isTablet,
                                      ),
                                    ],
                                  ],
                                ),

                                const SizedBox(height: 16),

                                /// SUBMIT
                                if (viewModel.isBusy)
                                  Column(
                                    children: [
                                      const CircularProgressIndicator(
                                        color: darkBrown,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Uploading photos, please wait…',
                                        style: TextStyle(
                                          color: darkBrown,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTablet ? 16 : 14,
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Opacity(
                                    opacity: viewModel.canSubmit ? 1.0 : 0.45,
                                    child: _buildSubmitButton(
                                      viewModel.canSubmit
                                          ? () => viewModel.uploadPhotos()
                                          : null,
                                      isTablet: isTablet,
                                    ),
                                  ),
                              ],
                            ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
    VoidCallback? onTap, {
    bool isTablet = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isTablet ? 58 : 52,
        width: isTablet ? 260 : 220,
        decoration: BoxDecoration(
          color: buttonYellow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: darkBrown,
            width: 4,
          ),
        ),
        child: Center(
          child: Text(
            'SUBMIT PHOTOS >',
            style: TextStyle(
              color: darkBrown,
              fontSize: isTablet ? 19 : 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool danger = false,
    bool isTablet = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 18 : 14,
          vertical: isTablet ? 10 : 8,
        ),
        decoration: BoxDecoration(
          color: danger ? Colors.red.shade600 : darkBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: primaryYellow,
              size: isTablet ? 21 : 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: primaryYellow,
                fontWeight: FontWeight.w700,
                fontSize: isTablet ? 15 : 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PhotoUploadViewModel viewModelBuilder(BuildContext context) =>
      PhotoUploadViewModel(
        uuid: uuid,
        isPet: isPet,
      );
}
