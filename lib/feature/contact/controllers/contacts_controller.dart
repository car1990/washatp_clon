import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clon/feature/contact/repository/contacts_repository.dart';

final contactControllerProvider = FutureProvider((ref) {
  final ContactRepository = ref.watch(contactsRepositoryProvider);
  return ContactRepository.getAllContacts();
});
