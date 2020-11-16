part of 'pages.dart';

class ChangePasswordPage extends StatefulWidget {
  final User user;

  ChangePasswordPage(this.user);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToProfilePage());

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
                                          .bloc<PageBloc>()
                                          .add(GoToProfilePage());
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    )),
                              ),
                              Center(
                                child: Text(
                                  "Change Your\nPassword",
                                  style: blackTextFont.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(child: BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) {
                          if (userState is UserLoaded) {
                            User user = userState.user;

                            return Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  width: 90,
                                  height: 90,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: SpinKitFadingCircle(
                                            color: mainColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: (user.profilePicture !=
                                                        "")
                                                    ? NetworkImage(
                                                        user.profilePicture)
                                                    : AssetImage(
                                                        "assets/user_pic.png"))),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin,
                                  child: Text(
                                    user.name,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: blackTextFont.copyWith(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin,
                                  margin: EdgeInsets.only(top: 8, bottom: 20),
                                  child: Text(
                                    user.email,
                                    textAlign: TextAlign.center,
                                    style: greyTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
                        SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Change Your Password",
                                  style: whiteTextFont.copyWith(fontSize: 15.5),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                            color: Colors.red[400],
                            onPressed: () async {
                              await AuthServices.resetPassword(
                                  widget.user.email);

                              Flushbar(
                                duration: Duration(milliseconds: 2000),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "The link to change your password has been sent to your email.",
                              )..show(context);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
