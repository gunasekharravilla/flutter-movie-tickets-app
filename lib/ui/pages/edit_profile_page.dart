part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToProfilePage());

        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF2C1F63),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      height: 53,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToProfilePage());
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black)),
                          ),
                          Center(
                            child: Text(
                              "Edit Your\nProfile",
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 104,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (profileImageFile != null)
                                        ? FileImage(profileImageFile)
                                        : (profilePath != "")
                                            ? NetworkImage(profilePath)
                                            : AssetImage("assets/user_pic.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (profilePath == "") {
                                  profileImageFile = await getImage();

                                  if (profileImageFile != null) {
                                    profilePath =
                                        basename(profileImageFile.path);
                                  }
                                } else {
                                  profileImageFile = null;
                                  profilePath = "";
                                }

                                setState(() {
                                  isDataEdited = (nameController.text.trim() !=
                                              widget.user.name ||
                                          profilePath !=
                                              widget.user.profilePicture)
                                      ? true
                                      : false;
                                });
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage((profilePath == "")
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_del_photo.png"))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: nameController,
                      onChanged: (text) {
                        setState(() {
                          isDataEdited = (text.trim() != widget.user.name ||
                                  profilePath != widget.user.profilePicture)
                              ? true
                              : false;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          hintText: "Full Name"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    (isUpdating)
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitFadingCircle(
                              color: Color(0xFF3E9D9D),
                            ))
                        : SizedBox(
                            width: 250,
                            height: 45,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Update My Profile",
                                  style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: (isDataEdited)
                                          ? Colors.white
                                          : Color(0xFFBEBEBE)),
                                ),
                                disabledColor: Color(0xFFE4E4E4),
                                color: Color(0xFF3E9D9D),
                                elevation: 0,
                                onPressed: (isDataEdited)
                                    ? () async {
                                        setState(() {
                                          isUpdating = true;
                                        });

                                        if (profileImageFile != null) {
                                          profilePath = await uploadImage(
                                              profileImageFile);
                                        }

                                        BlocProvider.of<UserBloc>(context).add(
                                            UpdateData(
                                                name: nameController.text,
                                                profileImage: profilePath));

                                        context
                                            .read<PageBloc>()
                                            .add(GoToProfilePage());
                                      }
                                    : null),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
