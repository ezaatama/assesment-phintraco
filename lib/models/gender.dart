class RadioGenderModel {
  bool isSelected;
  final String image;
  final String text;

  RadioGenderModel(
      {this.isSelected = false, required this.image, required this.text});

  static int genderValue = 1;

  static final List<RadioGenderModel> gender = [
    RadioGenderModel(image: "assets/icons/icon_pria.png", text: "PRIA"),
    RadioGenderModel(image: "assets/icons/icon_wanita.png", text: "WANITA"),
  ];
}
