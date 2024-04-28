import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clon/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clon/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_clon/common/repository/firebase_storage_repository.dart';
import 'package:whatsapp_clon/common/utils/coloors.dart';
import 'package:whatsapp_clon/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clon/common/widgets/short_h_bart.dart';
import 'package:whatsapp_clon/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clon/feature/auth/pages/login_page.dart';
import 'package:whatsapp_clon/feature/auth/widgets/custom_text_field.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key, this.profileImageUrl});

  final String? profileImageUrl;

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernamecontroller;

  saveUserDataToFirebase() async {
    String username = usernamecontroller.text;

    if (username.isEmpty) {
      return showAlerDialog(
          context: context, message: 'Please provide a username');
    } else if (username.length < 3 || username.length > 20) {
      return showAlerDialog(
          context: context,
          message: 'A username length should be between 3-20');
    }
    print('Saving user data to Firestore...');
    print('Username: $username');
    print('Profile Image: ${imageCamera ?? imageGallery ?? ''}');

    try {
      String imageUrl = await ref
          .read(FirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
              'profile_images/$username.jpg', imageCamera ?? imageGallery!);

      // Llama a la función para guardar la información del usuario en Firestore
      ref.read(autControllerProvider).saveUserInfotoFirestore(
            username: username,
            profileImage:
                imageCamera ?? imageGallery ?? widget.profileImageUrl ?? '',
            context: context,
            mounted: mounted,
            imageUrl: imageUrl, // Agrega la URL de la imagen aquí
          );

      // Por ejemplo, podrías enviar la URL de la imagen junto con el nombre de usuario a Firestore
      // ref.read(autControllerProvider).saveUserInfotoFirestore(username: username, imageUrl: imageUrl);
    } catch (e) {
      print('Error saving image to Firebase Storage: $e');
      showAlerDialog(
          context: context, message: 'Error saving image to Firebase Storage');
    }
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShortHBar(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Profile photo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                CustomIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 15),
              ],
            ),
            Divider(
              color: context.theme.greyColor!.withOpacity(0.3),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(width: 15),
                imagePickerIcon(
                  onTap: pickImageFromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                SizedBox(width: 15),
                imagePickerIcon(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    setState(() {
                      imageGallery = File(image.path).readAsBytesSync();
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'Gallery',
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  pickImageFromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        imageCamera = File(image.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlerDialog(context: context, message: e.toString());
    }
  }

  Widget imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          iconColor: Coloors.greenDark,
          minWidth: 50,
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernamecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Profile info',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional photo',
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : context.theme.greyColor!.withOpacity(0.4),
                  ),
                  image: imageCamera != null ||
                          imageGallery != null ||
                          widget.profileImageUrl != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: imageGallery != null
                              ? MemoryImage(imageGallery!)
                              : widget.profileImageUrl != null
                                  ? NetworkImage(widget.profileImageUrl!)
                                  : FileImage(imageCamera!) as ImageProvider,
                        )
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: imageCamera == null && imageGallery == null && widget.profileImageUrl == null
                        ? context.theme.photoIconColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: usernamecontroller,
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme.photoIconColor,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: saveUserDataToFirebase,
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
