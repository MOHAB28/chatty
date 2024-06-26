import 'package:chatty/core/helper/utils.dart';

extension StringExtension on String {
  bool get isEmail => Utils.isEmail(this);
}
