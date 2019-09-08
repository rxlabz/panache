import 'help.dart';

const textThemeHelp = HelpData("textTheme", '''
- Normal : Button text is black or white depending on ThemeData.brightness.
- Primary : Button text is based on ThemeData.primaryColor.
- Accent : Button text is ThemeData.accentColor.
''');

const buttonColorHelp = HelpData("buttonColor", '''
The background fill color for RaisedButtons.

If the button is in the focused, hovering, or highlighted state, then the
focusColor, hoverColor, or highlightColor will take precedence over
the focusColor.
''');

const disabledColorHelp = HelpData("disabledColor", '''
The background fill color for disabled RaisedButtons.
''');

const highlightColorHelp = HelpData("highlightColor", '''
The color of the overlay that appears when a button is pressed.
''');

const splashColorHelp = HelpData("splashColor", '''
The color of the ink "splash" overlay that appears when a button is tapped.
''');

const focusColorHelp = HelpData("focusColorColor", '''
The fill color of the button when it has the input focus.

If the button is in the hovering or highlighted state, then the hoverColor
or highlightColor will take precedence over the focusColor.
''');

const hoverColorHelp = HelpData("hoverColorColor", '''
The fill color of the button when a pointer is hovering over it.

Returns the button's MaterialButton.hoverColor if it is non-null.
Otherwise the focus color depends on ButtonThemeData.getTextColor(button):
''');
