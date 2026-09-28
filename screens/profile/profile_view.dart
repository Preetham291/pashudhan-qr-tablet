import 'package:flutter/material.dart';
import 'package:pashudhan_qr/core/responsive.dart';
import 'package:pashudhan_qr/screens/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({super.key});

  static const Color primaryYellow = Color(0xFFEDC93A);
  static const Color primaryGreen = Color(0xFFA1BC2A);
  static const Color buttonYellow = Color(0xFFF3D133);
  static const Color darkBrown = Color(0xFF452B14);
  static const Color lightBrown = Color(0xFF8A5A2B);
  static const Color cream = Color(0xFFFFF8E7);

  @override
  void onViewModelReady(ProfileViewModel viewModel) => viewModel.init();

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    final isTablet = Responsive.isTablet(context);
    final contentWidth = Responsive.contentWidth(
      context,
      maxWidth: 900,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: cream,
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  color: darkBrown,
                ),
              )
            : CustomScrollView(
                slivers: [
                  /// HEADER
                  SliverToBoxAdapter(
                    child: _buildHeader(
                      context,
                      viewModel,
                      isTablet: isTablet,
                    ),
                  ),

                  /// DETAILS
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      isTablet ? 32 : 20,
                      isTablet ? 38 : 30,
                      isTablet ? 32 : 20,
                      isTablet ? 36 : 30,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: contentWidth,
                          ),
                          child: Column(
                            children: [
                              /// EDIT MODE
                              if (viewModel.isEditing) ...[
                                _buildEditSection(
                                  viewModel,
                                  isTablet: isTablet,
                                ),
                              ] else ...[
                                if (viewModel.userRole.toUpperCase() ==
                                    'CUSTOMER') ...[
                                  _buildDetailTile(
                                    icon: Icons.person_rounded,
                                    label: 'Full Name',
                                    value: (viewModel.customer?.name != null &&
                                            viewModel.customer!.name.isNotEmpty)
                                        ? viewModel.customer!.name
                                        : viewModel.userName,
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.phone_android_rounded,
                                    label: 'Mobile Number',
                                    value:
                                        (viewModel.customer?.userName != null &&
                                                viewModel.customer!.userName
                                                    .isNotEmpty)
                                            ? viewModel.customer!.userName
                                            : viewModel.userPhone,
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.badge_rounded,
                                    label: 'Aadhar Number',
                                    value:
                                        viewModel.customer?.aadharNumber ?? '—',
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.pin_drop_rounded,
                                    label: 'Pincode',
                                    value: viewModel.customer?.pincode
                                            ?.toString() ??
                                        '—',
                                    isTablet: isTablet,
                                  ),
                                ] else ...[
                                  _buildDetailTile(
                                    icon: Icons.person_rounded,
                                    label: 'Full Name',
                                    value: viewModel.associate?.fullName ??
                                        viewModel.userName,
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.phone_android_rounded,
                                    label: 'Mobile Number',
                                    value: viewModel.associate?.userName ??
                                        viewModel.userName,
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.badge_rounded,
                                    label: 'ID Number',
                                    value: viewModel.associate?.idNo ?? '—',
                                    isTablet: isTablet,
                                  ),
                                  _buildDetailTile(
                                    icon: Icons.verified_rounded,
                                    label: 'Approval Status',
                                    value: viewModel.associate != null
                                        ? (viewModel.associate!.approved
                                            ? 'Approved'
                                            : 'Pending Review')
                                        : '—',
                                    valueColor:
                                        viewModel.associate?.approved == true
                                            ? const Color(0xFF2E7D32)
                                            : const Color(0xFFE65100),
                                    trailing: viewModel.associate != null
                                        ? Icon(
                                            viewModel.associate!.approved
                                                ? Icons.check_circle
                                                : Icons.hourglass_top_rounded,
                                            color: viewModel.associate!.approved
                                                ? const Color(0xFF2E7D32)
                                                : const Color(0xFFE65100),
                                            size: isTablet ? 26 : 22,
                                          )
                                        : null,
                                    isTablet: isTablet,
                                  ),
                                ],

                                SizedBox(
                                  height: isTablet ? 36 : 30,
                                ),

                                /// DEACTIVATE ACCOUNT
                                GestureDetector(
                                  onTap: viewModel.isBusy
                                      ? null
                                      : viewModel.deleteAccount,
                                  child: Container(
                                    width: double.infinity,
                                    height: isTablet ? 66 : 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFDE8E8),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFF8B4B4),
                                        width: 2.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete_forever_rounded,
                                          color: Colors.red,
                                          size: isTablet ? 28 : 24,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Deactivate Account',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: isTablet ? 18 : 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
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

  // ================================================================
  // HEADER
  // ================================================================

  Widget _buildHeader(
    BuildContext context,
    ProfileViewModel viewModel, {
    required bool isTablet,
  }) {
    final displayName = viewModel.userRole.toUpperCase() == 'CUSTOMER'
        ? (viewModel.customer?.name ?? viewModel.userName)
        : (viewModel.associate?.fullName ?? viewModel.userName);

    final avatarSize = isTablet ? 150.0 : 120.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// GREEN HEADER
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: isTablet ? 22 : 16,
            bottom: isTablet ? 65 : 50,
          ),
          decoration: const BoxDecoration(
            color: primaryGreen,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(36),
            ),
          ),
          child: Column(
            children: [
              /// TOP ROW
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 24 : 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: darkBrown,
                        size: isTablet ? 30 : 26,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        'My Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkBrown,
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    if (!viewModel.isEditing &&
                        viewModel.userRole.toUpperCase() != 'CUSTOMER')
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: darkBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.edit_rounded,
                            color: primaryYellow,
                            size: isTablet ? 20 : 18,
                          ),
                        ),
                        onPressed: viewModel.startEditing,
                      )
                    else
                      SizedBox(
                        width: isTablet ? 56 : 48,
                      ),
                  ],
                ),
              ),

              SizedBox(
                height: isTablet ? 20 : 16,
              ),

              /// AVATAR
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonYellow,
                      border: Border.all(
                        color: darkBrown,
                        width: 3.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: darkBrown.withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: viewModel.isUploadingPic ||
                            viewModel.isDeletingPic ||
                            viewModel.isFetchingPic
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: darkBrown,
                              strokeWidth: 3,
                            ),
                          )
                        : ClipOval(
                            child: viewModel.profilePicBytes != null
                                ? Image.memory(
                                    viewModel.profilePicBytes!,
                                    width: avatarSize,
                                    height: avatarSize,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _defaultAvatar(
                                      displayName,
                                      size: avatarSize,
                                    ),
                                  )
                                : _defaultAvatar(
                                    displayName,
                                    size: avatarSize,
                                  ),
                          ),
                  ),

                  /// CAMERA BUTTON
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () => _showPhotoOptions(context, viewModel),
                      child: Container(
                        padding: EdgeInsets.all(
                          isTablet ? 8 : 7,
                        ),
                        decoration: BoxDecoration(
                          color: darkBrown,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryYellow,
                            width: 2.5,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: primaryYellow,
                          size: isTablet ? 19 : 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: isTablet ? 18 : 14,
              ),

              /// NAME
              Text(
                displayName.isNotEmpty ? displayName : 'User',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isTablet ? 26 : 22,
                  fontWeight: FontWeight.w900,
                  color: darkBrown,
                ),
              ),

              const SizedBox(height: 6),

              /// ROLE BADGE
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 20 : 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: darkBrown,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _formatRole(viewModel.userRole),
                  style: TextStyle(
                    color: primaryYellow,
                    fontWeight: FontWeight.w700,
                    fontSize: isTablet ? 14 : 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// YOUR DETAILS LABEL
        Positioned(
          bottom: -18,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 30 : 26,
                vertical: isTablet ? 11 : 10,
              ),
              decoration: BoxDecoration(
                color: darkBrown,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: darkBrown.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Your Details',
                style: TextStyle(
                  color: primaryYellow,
                  fontWeight: FontWeight.w800,
                  fontSize: isTablet ? 15 : 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // DETAIL TILE
  // ================================================================

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    Widget? trailing,
    bool isTablet = false,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: isTablet ? 14 : 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 16,
        vertical: isTablet ? 17 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: darkBrown.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isTablet ? 48 : 42,
            height: isTablet ? 48 : 42,
            decoration: BoxDecoration(
              color: primaryGreen.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: darkBrown,
              size: isTablet ? 23 : 20,
            ),
          ),
          SizedBox(
            width: isTablet ? 16 : 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isTablet ? 13 : 11,
                    fontWeight: FontWeight.w600,
                    color: lightBrown,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.w800,
                    color: valueColor ?? darkBrown,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  // ================================================================
  // EDIT SECTION
  // ================================================================

  Widget _buildEditSection(
    ProfileViewModel viewModel, {
    bool isTablet = false,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: isTablet ? 14 : 12,
      ),
      padding: EdgeInsets.all(
        isTablet ? 26 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryGreen,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: darkBrown.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.edit_note_rounded,
                color: primaryGreen,
                size: isTablet ? 28 : 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Edit Your Details',
                style: TextStyle(
                  fontSize: isTablet ? 19 : 16,
                  fontWeight: FontWeight.w900,
                  color: darkBrown,
                ),
              ),
            ],
          ),
          SizedBox(
            height: isTablet ? 24 : 20,
          ),
          _editField(
            label: 'Full Name',
            initialValue: viewModel.editedName,
            icon: Icons.person_rounded,
            onChanged: viewModel.setEditedName,
            isTablet: isTablet,
          ),
          SizedBox(
            height: isTablet ? 16 : 14,
          ),
          _editField(
            label: 'ID Number',
            initialValue: viewModel.editedIdNo,
            icon: Icons.badge_rounded,
            onChanged: viewModel.setEditedIdNo,
            isTablet: isTablet,
          ),
          SizedBox(
            height: isTablet ? 24 : 22,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: viewModel.cancelEditing,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 16 : 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: darkBrown,
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet ? 17 : 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: isTablet ? 16 : 12,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: viewModel.isBusy ? null : viewModel.saveProfile,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 16 : 14,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: darkBrown,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.isBusy ? 'Saving…' : 'Save',
                        style: TextStyle(
                          color: darkBrown,
                          fontWeight: FontWeight.w800,
                          fontSize: isTablet ? 17 : 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // EDIT FIELD
  // ================================================================

  Widget _editField({
    required String label,
    required String initialValue,
    required IconData icon,
    required void Function(String) onChanged,
    bool isTablet = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: TextStyle(
        color: darkBrown,
        fontWeight: FontWeight.w700,
        fontSize: isTablet ? 17 : 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: lightBrown,
          fontWeight: FontWeight.w600,
          fontSize: isTablet ? 14 : 13,
        ),
        prefixIcon: Icon(
          icon,
          color: primaryGreen,
          size: isTablet ? 24 : 22,
        ),
        filled: true,
        fillColor: cream,
        contentPadding: EdgeInsets.symmetric(
          vertical: isTablet ? 17 : 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: primaryGreen,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: darkBrown,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: primaryGreen.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // DEFAULT AVATAR
  // ================================================================

  Widget _defaultAvatar(
    String name, {
    double size = 120,
  }) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      width: size,
      height: size,
      color: buttonYellow,
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: size * 0.43,
            fontWeight: FontWeight.w900,
            color: darkBrown,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // PHOTO OPTIONS
  // ================================================================

  void _showPhotoOptions(
    BuildContext context,
    ProfileViewModel viewModel,
  ) {
    final isTablet = Responsive.isTablet(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          isTablet ? 40 : 24,
          20,
          isTablet ? 40 : 24,
          isTablet ? 34 : 28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Profile Photo',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontWeight: FontWeight.w900,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _sourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  color: primaryGreen,
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.uploadProfilePicFromCamera();
                  },
                  isTablet: isTablet,
                ),
                _sourceOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  color: primaryGreen,
                  onTap: () {
                    Navigator.pop(context);
                    viewModel.uploadProfilePicFromGallery();
                  },
                  isTablet: isTablet,
                ),
                if (viewModel.profilePicBytes != null)
                  _sourceOption(
                    icon: Icons.delete_outline_rounded,
                    label: 'Remove',
                    color: Colors.red.shade400,
                    onTap: () {
                      Navigator.pop(context);
                      viewModel.deleteProfilePic();
                    },
                    isTablet: isTablet,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SOURCE OPTION
  // ================================================================

  Widget _sourceOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isTablet = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: isTablet ? 78 : 66,
            height: isTablet ? 78 : 66,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: isTablet ? 36 : 30,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 15 : 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HELPERS
  // ================================================================

  String _formatRole(String role) {
    switch (role.toUpperCase()) {
      case 'ASSOCIATE':
        return 'ASSOCIATE';
      case 'CUSTOMER':
        return 'CUSTOMER';
      case 'ADMIN':
        return 'ADMIN';
      default:
        return role.toUpperCase();
    }
  }
}
