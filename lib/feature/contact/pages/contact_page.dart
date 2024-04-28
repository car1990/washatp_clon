import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clon/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clon/common/models/user_model.dart';
import 'package:whatsapp_clon/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clon/feature/contact/controllers/contacts_controller.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select contact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              '5 contacts',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.search),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerProvider).when(
        data: (allContacts) {
          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length + 1,
            itemBuilder: (context, index) {
              if (index == allContacts[0].length + allContacts[1].length) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Agregar lógica para agregar un nuevo contacto
                        },
                        child: Icon(Icons.person_add),
                      ),
                    ],
                  ),
                );
              } else {
                // Devolver el widget para mostrar el contacto en el índice actual
              }

              UserModel? firebaseContacts;
              UserModel? phoneContacts;

              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }

              return ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 0,
                  bottom: 0,
                ),
                dense: true,
                leading: CircleAvatar(
                  backgroundColor: context.theme.greyColor!.withOpacity(0.3),
                  radius: 20,
                  backgroundImage:
                      firebaseContacts?.profileImageUrl?.isNotEmpty ?? false
                          ? NetworkImage(firebaseContacts!.profileImageUrl!)
                          : null,
                  child: firebaseContacts?.profileImageUrl?.isEmpty ?? true
                      ? Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        )
                      : null,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contacts on  WhatsApp',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      firebaseContacts?.username ?? "no username",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Hey there! I'm using WhatsApp",
                      style: TextStyle(
                        color: context.theme.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        right: 10,
                        top: 0,
                        bottom: 0,
                      ),
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: context.theme.greyColor,
                        radius: 20,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        error: (e, t) {
          // Handle error state
          return Center(
            child: Text('Error fetching contacts'),
          );
        },
        loading: () {
          // Handle loading state
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
