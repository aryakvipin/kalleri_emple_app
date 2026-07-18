import 'package:get/get.dart';

/// Holds the currently selected bottom-nav tab index for [UserHomePage].
///
/// Putting this in a GetX controller (instead of local State) lets any
/// widget — even ones pushed on their own route, or nested deep inside
/// a tab's page — switch tabs without needing a BuildContext that's
/// still inside the UserHomePage widget tree.
class NavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}