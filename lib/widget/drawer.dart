import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * .8,
        color: Colors.white,
        constraints: BoxConstraints(maxWidth: 280),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.home,
              text: 'រំដួល',
              active: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              icon: Icons.settings,
              text: 'ការកំណត់',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.contact_page,
              text: 'ទាក់ទង់ពួកយើង',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.feedback_outlined,
              text: 'កម្មវិធីមានបញ្ហា',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'ចាកចេញ',
              onTap: () {},
            ),
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

  Widget _createHeader() {
    return Container(
      height: 80,
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
              child: Image.asset(
                'assets/home/profile.png',
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 13),
          Flexible(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text(
                  "Sok Chan",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Text(
                  "sokchan@romduol.com",
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
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, Function onTap, bool active = false}) {
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
        highlightColor: Palette.text.withOpacity(0.01),
        splashColor: Palette.text.withOpacity(0.05),
        color: Colors.white,
        child: Row(
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
      ),
    );
  }
}
