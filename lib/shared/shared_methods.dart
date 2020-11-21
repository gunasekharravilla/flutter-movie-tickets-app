part of 'shared.dart';

Future<File> getImage() async {
  PickedFile pickedFile =
      await ImagePicker().getImage(source: ImageSource.gallery);
  var image = File(pickedFile.path);
  return image;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 8;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
