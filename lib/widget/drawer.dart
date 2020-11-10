import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/main.dart';
import 'package:romduol/screens/admin/a_province.dart';
import 'package:romduol/screens/auth/login.dart';
import 'package:romduol/screens/home/setting.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/widget/networkImage.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key, this.onLangTab, this.onWillPop, @required this.isKH})
      : super(key: key);

  final Function onLangTab, onWillPop;
  final bool isKH;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    final AuthService _auth = AuthService();

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * .8,
        color: Colors.white,
        constraints: BoxConstraints(maxWidth: 280),
        child: Column(
          children: <Widget>[
            user != null
                ? StreamBuilder<UserData>(
                    stream: UserDatabase(uid: user.uid).userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserData userData = snapshot.data;
                        return Stack(
                          children: [
                            _createHeader(
                              name: userData.fname + " " + userData.lname,
                              email: userData.email,
                              imageUrl: userData.image != null
                                  ? userData.image
                                  : null,
                              context: context,
                            ),
                            userData.role == "Admin"
                                ? Positioned(
                                    right: 10.0,
                                    top: 20.0,
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Palette.sky.withOpacity(0.5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        " Admin ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ))
                                : SizedBox(),
                          ],
                        );
                      }
                      return buildLogin(context);
                    })
                : buildLogin(context),
            _createDrawerItem(
              icon: Icons.language,
              text: Lang().of(key: 'changelang', isKH: widget.isKH),
              active: true,
              onTap: () {
                Navigator.pop(context);
                widget.onLangTab();
              },
              context: context,
            ),
            user != null
                ? StreamBuilder<UserData>(
                    stream: UserDatabase(uid: user.uid).userData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserData userData = snapshot.data;
                        if (userData.role == "Admin")
                          return _createDrawerItem(
                            icon: Icons.add_to_drive,
                            text: Lang().of(key: 'addinfo', isKH: widget.isKH),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AdminProvince(isKH: widget.isKH),
                                ),
                              );
                            },
                            context: context,
                          );
                      }
                      return SizedBox();
                    })
                : SizedBox(),
            _createDrawerItem(
              icon: Icons.settings,
              text: Lang().of(key: 'setting', isKH: widget.isKH),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(isKH: widget.isKH),
                  ),
                );
              },
              context: context,
            ),
            _createDrawerItem(
              icon: Icons.contact_page,
              text: Lang().of(key: 'contactus', isKH: widget.isKH),
              onTap: () {},
              context: context,
            ),
            _createDrawerItem(
              icon: Icons.feedback_outlined,
              text: Lang().of(key: 'reportissue', isKH: widget.isKH),
              onTap: () {},
              context: context,
            ),
            user != null
                ? _createDrawerItem(
                    icon: Icons.logout,
                    text: Lang().of(key: 'exitapp', isKH: widget.isKH),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SplashScreen()),
                      );
                      _auth.signOut();
                    },
                    context: context,
                  )
                : SizedBox(),
            ListTile(
              title: Text(
                '0.0.1',
                style: TextStyle(color: Palette.text),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Container buildLogin(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/graphics/materialedge.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: FlatButton.icon(
        height: 48,
        icon: Icon(Icons.login, color: Colors.white),
        label: Text(
          "Log in or Sign up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(isKH: widget.isKH),
            ),
          );
        },
      ),
    );
  }

  Widget _createHeader(
      {String name, String email, String imageUrl, BuildContext context}) {
    return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/graphics/materialedge.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: imageUrl != null
                    ? NetworkImageLoader(
                        width: 52,
                        height: 52,
                        imagelocation: imageUrl,
                        onPressed: () {},
                      )
                    : Container(
                        width: 52,
                        height: 52,
                        child: Icon(Icons.people),
                      ),
              ),
            ),
            SizedBox(width: 13),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    email,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _createDrawerItem(
      {BuildContext context,
      IconData icon,
      String text,
      Function onTap,
      bool active = false}) {
    Color color = active ? Palette.sky : Palette.bgdark.withOpacity(0.7);
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Palette.text, width: 0.2),
        ),
      ),
      child: FlatButton(
        onPressed: onTap,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        splashColor: Colors.transparent,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                Icon(icon, color: color),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 13,
                      color: color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
