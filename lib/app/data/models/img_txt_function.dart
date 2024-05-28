class ImgTextFunction {
  final String image;
  final String text;
  final void Function() onTap;

  ImgTextFunction({
    required this.image,
    required this.text,
    required this.onTap,
  });
}
