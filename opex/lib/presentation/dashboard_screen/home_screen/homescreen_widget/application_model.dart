import 'package:cluster/presentation/dashboard_screen/home_screen/homescreen_widget/apps_svg.dart';

class ApplicationModel {
  String title, subTitle, image, url;

  ApplicationModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.url});
}

List<ApplicationModel> applicationList = [
  ApplicationModel(
      title: 'Sidra Go Whatsapp & Sidra Business Whatsapp',
      image: "asset/newbg2.jpg",
      subTitle: "Sidra",
      url: "https://sidra-bazar-uat-products.s3.ap-south-1.amazonaws.com/w_banners/Sidra+Meta+Ad2.mp4"),
  ApplicationModel(
      title: 'Sidra Go Whatsapp & Sidra Business Whatsapp',
      image:
          "asset/newbg.jpg",
      subTitle: "Sidra",
      url: "https://sidra-bazar-uat-products.s3.ap-south-1.amazonaws.com/w_banners/Sidra+GO%26+Business.mp4"),
  // ApplicationModel(
  //     title: 'Rawabi Hypermarket Al Murrah',
  //     image: "https://alrawabigroup.com/uploads/media/news215549.jpg",
  //     subTitle: "Task and operation",
  //     url: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),

];
