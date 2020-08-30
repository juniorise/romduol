import 'package:romduol/screens/screens.dart';

class ThreeLayerCard extends StatelessWidget {
  const ThreeLayerCard(
      {Key key, @required this.onPressed, this.describe, this.title, this.path})
      : super(key: key);

  final String describe, title, path;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      height: 170,
      constraints: BoxConstraints(minWidth: 250, maxWidth: 360),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                '$path',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Palette.green80,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Palette.background,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      describe,
                      style: TextStyle(
                        color: Palette.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      highlightColor: Palette.yellow50,
                      color: Palette.yellow60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: onPressed,
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.info,
                            size: 12,
                            color: Palette.background,
                          ),
                          Text(
                            "  ព័ត៍មានបន្ថែម",
                            style: TextStyle(
                              color: Palette.background,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
