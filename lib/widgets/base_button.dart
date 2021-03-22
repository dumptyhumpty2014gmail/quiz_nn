import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/share_style.dart';

class BaseButtonPage extends StatelessWidget {
  final String title;
  final Widget toPage;

  BaseButtonPage({Key key, this.title, this.toPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  _createRoute()
                  // MaterialPageRoute(
                  //   builder: (context) => toPage,
                  // ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                // maxWidth: 300,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: baseGradient1),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: whiteTextStyle1,
                ),
              ),
            );
  }
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,//
        Animation<double> secondaryAnimation) {
      return toPage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, //
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
}

class BaseButtonExit extends StatelessWidget {
  final String title;
  // final Function toPage;
static Future<void> _popExit({bool animated}) async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
}
  BaseButtonExit({Key key, this.title}) //, this.toPage
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
            GestureDetector(
              onTap: () { _popExit();},
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                // maxWidth: 300,
                constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: baseGradient1),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: whiteTextStyle1,
                ),
              ),
            );
  }
}