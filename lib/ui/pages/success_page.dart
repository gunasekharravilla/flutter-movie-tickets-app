part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: Scaffold(
          backgroundColor: Color(0xFF2C1F63),
          body: SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
              child: FutureBuilder(
                  future: ticket != null
                      ? processingTicketOrder(context)
                      : processingTopUp(context),
                  builder: (_, snapshot) => (snapshot.connectionState ==
                          ConnectionState.done)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 150,
                              height: 150,
                              margin: EdgeInsets.only(bottom: 70),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(ticket == null
                                          ? "assets/top_up_done.png"
                                          : "assets/ticket_done.png"))),
                            ),
                            Text(
                              (ticket == null)
                                  ? "Emmm Yummy!"
                                  : "Happy Watching!",
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              (ticket == null)
                                  ? "You have succesfully\ntop up the wallet"
                                  : "You have succesfully\nbought the ticket",
                              style: blackTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              margin: EdgeInsets.only(top: 70, bottom: 20),
                              child: RaisedButton(
                                  elevation: 0,
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    (ticket == null)
                                        ? "My Wallet"
                                        : "My Tickets",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (ticket == null) {
                                      context
                                          .read<PageBloc>()
                                          .add(GoToWalletPage(GoToMainPage()));
                                    } else {
                                      context.read<PageBloc>().add(
                                          GoToMainPage(bottomNavbarIndex: 1));
                                    }
                                  }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Discover new movie? ",
                                  style: greyTextFont.copyWith(
                                      fontWeight: FontWeight.w400),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PageBloc>()
                                        .add(GoToMainPage());
                                  },
                                  child: Text(
                                    "Back to Home",
                                    style: purpleTextFont,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: SpinKitFadingCircle(
                            color: mainColor,
                            size: 50,
                          ),
                        )),
            ),
          ),
        ));
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(Purchase(ticket.totalPrice));
    BlocProvider.of<TicketBloc>(context)
        .add(BuyTicket(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
