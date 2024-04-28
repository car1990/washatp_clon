import 'package:flutter/material.dart';
import 'package:whatsapp_clon/common/utils/coloors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtesion get theme {
    final themeExtension = Theme.of(this)?.extension<CustomThemeExtesion>();
    if (themeExtension != null) {
      return themeExtension;
    } else {
      // Aquí puedes devolver una instancia de CustomThemeExtesion por defecto,
      // o lanzar una excepción si lo prefieres.
      // Por ejemplo, para devolver una instancia por defecto:
      return CustomThemeExtesion
          .lightMode; // O cualquier otra instancia que consideres adecuada.
    }
  }
}

class CustomThemeExtesion extends ThemeExtension<CustomThemeExtesion> {
  static const lightMode = CustomThemeExtesion(
    circleImageColor: Color(0xFF25D366),
    greyColor: Coloors.greyLight,
    blueColor: Coloors.blueLight,
    langbtnBgColor: Color(0xFFF7F8FA),
    langBtnHighlightColor: Color(0xFFE8E8ED),
    authAppbarTextColor: Coloors.greenLight,
    photoIconBgColor: Color(0XFFF0F2F3),
    photoIconColor: Color(0xFF9DAAB3),
  );
  static const darkMode = CustomThemeExtesion(
      circleImageColor: Coloors.greenDark,
      greyColor: Coloors.greyDark,
      blueColor: Coloors.blueDark,
      langbtnBgColor: Color(0xFF182229),
      langBtnHighlightColor: Color(0xFF09141A),
      authAppbarTextColor: Color(0xFFE9EDEF),
      photoIconBgColor: Color(0xFF283339),
      photoIconColor: Color(0xFF61717B));

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langbtnBgColor;
  final Color? langBtnHighlightColor;
  final Color? authAppbarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;

  const CustomThemeExtesion({
    this.authAppbarTextColor,
    this.circleImageColor,
    this.greyColor,
    this.blueColor,
    this.langbtnBgColor,
    this.langBtnHighlightColor,
    this.photoIconBgColor,
    this.photoIconColor,
  });

  @override
  ThemeExtension<CustomThemeExtesion> copyWith({
    Color? circleImageColor,
    Color? greyColor,
    Color? blueColor,
    Color? langbtnBgColor,
    Color? langBtnHighlightColor,
    Color? authAppbarTextColor,
    Color? photoIconBgColor,
    Color? photoIconColor,
  }) {
    return CustomThemeExtesion(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langbtnBgColor: langbtnBgColor ?? this.langbtnBgColor,
      authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
      photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
      photoIconColor: photoIconColor ?? this.photoIconColor,
      langBtnHighlightColor:
          langBtnHighlightColor ?? this.langBtnHighlightColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtesion> lerp(
      ThemeExtension<CustomThemeExtesion>? other, double t) {
    if (other is! CustomThemeExtesion) return this;

    return CustomThemeExtesion(
      circleImageColor: Color.lerp(circleImageColor, other.circleImageColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langbtnBgColor: Color.lerp(langbtnBgColor, other.langbtnBgColor, t),
      photoIconBgColor: Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
      photoIconColor: Color.lerp(photoIconBgColor, other.photoIconColor, t),
      authAppbarTextColor:
          Color.lerp(authAppbarTextColor, other.authAppbarTextColor, t),
      langBtnHighlightColor:
          Color.lerp(langBtnHighlightColor, other.langBtnHighlightColor, t),
    );
  }
}
