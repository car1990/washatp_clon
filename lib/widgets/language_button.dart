import 'package:flutter/material.dart';
import 'package:whatsapp_clon/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clon/common/utils/coloors.dart';
import 'package:whatsapp_clon/feature/auth/pages/login_page.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key? key,
  }) : super(key: key);

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                    color: context.theme.greyColor!.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    CustomIconButton(
                      onTap: () => Navigator.of(context).pop(),
                      icon:Icons.close_outlined,
                  ),
                   const SizedBox(width: 10),
                    const Text(
                      'App Language',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: context.theme.greyColor!.withOpacity(0.3),
                  thickness: .5,
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Coloors.greenDark,
                  title: const Text('English'),
                  subtitle: Text(
                    "(phone's language)",
                    style: TextStyle(
                      color: context.theme.greyColor,
                    ),
                  ),
                ),
                RadioListTile(
                  value: true,
                  groupValue: false,
                  onChanged: (value) {},
                  activeColor: Coloors.greenDark,
                  title: const Text('ትዮጵያ'),
                  subtitle: Text(
                    "(Amharic)",
                    style: TextStyle(
                      color: context.theme.greyColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.theme.langbtnBgColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => showBottomSheet(context),
          borderRadius: BorderRadius.circular(20),
          splashFactory: NoSplash.splashFactory,
          highlightColor: context.theme.langBtnHighlightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.language,
                  color: Coloors.greenDark,
                ),
                SizedBox(width: 10),
                Text(
                  'English',
                  style: TextStyle(
                    color: Coloors.greenDark,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Coloors.greenDark,
                ),
              ],
            ),
          ),
        ));
  }
}
