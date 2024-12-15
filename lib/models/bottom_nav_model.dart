import '../utilities/assets_manager.dart';

class NavigationBarModel {
  final int id;
  final String imagePath;
  final String name;

  NavigationBarModel({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<NavigationBarModel> navigationBarButtons = [
  NavigationBarModel(id: 0, imagePath: AssetsManager.homeIcon, name: "Home"),
  NavigationBarModel(id: 1, imagePath: AssetsManager.manageIcon, name: "Chats"),
  NavigationBarModel(
      id: 2, imagePath: AssetsManager.graphIconIcon, name: "Orders"),
  NavigationBarModel(
      id: 3, imagePath: AssetsManager.profileIconIcon, name: "Settings"),
];
