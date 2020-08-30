import 'package:romduol/screens/screens.dart';

class HeaderText extends StatelessWidget {
  final String headerText;

  const HeaderText({Key key, @required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: TextStyle(
              color: Palette.text,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Divider(
            color: Palette.text,
          )
        ],
      ),
    );
  }
}
