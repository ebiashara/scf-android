import 'package:flutter/material.dart';
import '../pages/documents/documents_screen.dart';
import '../pages/overdue_transaction_screen.dart/overdue_screen.dart';
import '../pages/upcoming_transaction_screen.dart/upcoming_screen.dart';
import '../widgets/DashboardAction.dart';
import '../configs/constants.dart';

class DasboardCardWidget extends StatelessWidget {
  const DasboardCardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.0, right: 15.0, left: 15.0),
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 15.0)
            ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DashboardAction(
                    cardColor: Colors.purple.withOpacity(0.1),
                    iconSvg: Icons.article,
                    iconColor: Colors.purple,
                    title: Constants.documents,
                    onClick: () {
                      Navigator.pushNamed(context, DocumentsScreen.routeName);
                    },
                  ),
                  DashboardAction(
                    cardColor: Colors.pink.withOpacity(0.1),
                    iconSvg: Icons.outlined_flag_rounded,
                    iconColor: Colors.pink,
                    title: Constants.overdue_transactions,
                    onClick: () {
                      Navigator.pushNamed(context, OverdueScreen.routeName);
                    },
                  ),
                  DashboardAction(
                    cardColor: Colors.orange.withOpacity(0.1),
                    iconSvg: Icons.upload_file,
                    iconColor: Colors.orange,
                    title: Constants.upcoming_settlements,
                    onClick: () {
                      Navigator.pushNamed(context, UpcomingScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
