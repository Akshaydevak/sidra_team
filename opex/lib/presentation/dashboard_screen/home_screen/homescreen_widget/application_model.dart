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
      title: 'Al Rawabi Group of Companies- Corporate Ad',
      image:
          "https://rawabihypermarket.com/wp-content/uploads/2021/07/r1.jpg",
      subTitle: "New add",
      url: "https://youtu.be/JznIwGjczCg?si=busBQ2dCFS6M5uU-"),
  ApplicationModel(
      title:
          'ലോകത്തെ ആദ്യ കുടുംബ കേന്ദ്രീകൃത ഹൈപ്പർമാർക്കറ്റുമായി അൽറവാബി ഗ്രൂപ്പ് ഓഫ് കമ്പനീസ്',
      image:
          "https://menafn.com/updates/pr/2023-03/11/GT_2c0d9image_story.jpeg",
      subTitle: "Task and operation",
      url: "https://youtu.be/pRc92jBKroY?si=eHf6bwcCLjOOTUzV"),
  ApplicationModel(
      title: 'Rawabi Hypermarket Al Murrah',
      image: "https://alrawabigroup.com/uploads/media/news215549.jpg",
      subTitle: "Task and operation",
      url: "https://youtu.be/CTpZBJS9B6M?si=e8SN8RBIVSn_8sIF"),

];
