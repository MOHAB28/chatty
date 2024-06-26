import 'package:chatty/core/services/database_service/database_services_impl.dart';
import 'package:chatty/domain/models/user/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUsers = StreamProvider.autoDispose<List<UserModel>>(
  (ref) => ref.read(databaseServiceProvider).getUsers(),
);
