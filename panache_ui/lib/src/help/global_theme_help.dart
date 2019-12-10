import 'help.dart';

const brightnessHelp = HelpData(
  "ThemeData.brightness",
'''
The brightness of the overall theme of the application. Used by widgets like buttons to determine what color to pick when not using the primary or accent color.
When the [Brightness] is dark, the canvas, card, and primary colors are all dark. When the [Brightness] is light, the canvas and card colors are bright, and the primary color's darkness varies as described by primaryColorBrightness. The primaryColor does not contrast well with the card and canvas colors when the brightness is dark; 
when the brightness is dark, use Colors.white or the accentColor for a contrasting color.''',
);

const primaryColorHelp = HelpData("ThemeData.primaryColor", '''
The background color for major parts of the app (toolbars, tab bars, etc)

The theme's [colorScheme] property contains [ColorScheme.primary], as well as a color that contrasts well with the primary color called [ColorScheme.onPrimary]. It might be simpler to just configure an app's visuals in terms of the theme's [colorScheme].
''');

const primaryColorLightHelp = HelpData("ThemeData.primaryColorLight", '''
A lighter version of the [primaryColor].

Used in [CircleAvatar] widget for background or foreground color 
''');
const primaryColorDarkHelp = HelpData("ThemeData.primaryColorDark", '''
A darker version of the [primaryColor].

Used in [CircleAvatar] widget for background or foreground color 
''');

const primaryColorBrightnessHelp = HelpData("ThemeData.primaryColorBrightness", '''
The brightness of the [primaryColor]. Used to determine the color of text and icons placed on top of the primary color (e.g. toolbar text).''');

const accentColorHelp = HelpData("ThemeData.accentColor", '''
The foreground color for widgets (knobs, text, overscroll edge effect, etc).

Accent color is also known as the secondary color.

The theme's [colorScheme] property contains [ColorScheme.secondary], as well as a color that contrasts well with the secondary color called [ColorScheme.onSecondary]. It might be simpler to just configure an app's visuals in terms of the theme's [colorScheme].
''');


const accentColorBrightnessHelp = HelpData("ThemeData.accentColorBrightness", '''
The brightness of the [accentColor].
Used to determine the color of text and icons placed on top of the accent color (e.g. the icons on a floating action button).
''');

const canvasColorHelp = HelpData("ThemeData.canvasColor", '''
The default color of [MaterialType.canvas] [Material].
''');

const scaffoldColorHelp = HelpData("ThemeData.scaffoldColor", '''
The default color of the [Material] that underlies the [Scaffold].

The background color for a typical material app or a page within the app.
''');

const bottomAppBarColorHelp = HelpData("ThemeData.bottomAppBarColor", '''
The default color of the [BottomAppBar].

This can be overridden by specifying [BottomAppBar.color].
''');

const cardColorHelp = HelpData("ThemeData.cardColor", '''
The color of [Material] when it is used as a [Card].
''');

const dividerColorHelp = HelpData("ThemeData.dividerColor", '''
The color of [Divider]s and [PopupMenuDivider]s, also used between [ListTile]s, between rows in [DataTable]s, and so forth.
To create an appropriate [BorderSide] that uses this color, consider [Divider.createBorderSide].
''');

const focusColorHelp = HelpData("ThemeData.focusColor", '''
The focus color used indicate that a component has the input focus.
''');

const hoverColorHelp = HelpData("ThemeData.hoverColor", '''
The hover color used to indicate when a pointer is hovering over a component.
''');

const highlightColorHelp = HelpData("ThemeData.highlightColor", '''
The highlight color used during ink splash animations or to indicate an item in a menu is selected.
''');

const splashColorHelp = HelpData("ThemeData.splashColor", '''
The color of ink splashes. See [InkWell].
''');

const selectedRowColorHelp = HelpData("ThemeData.selectedRowColor", '''
The color used to highlight selected rows.
''');

const unselectedWidgetColorHelp = HelpData("ThemeData.unselectedWidgetColor", '''
The color used for widgets in their inactive (but enabled) state. For example, an unchecked checkbox. Usually contrasted with the [accentColor]. See also [disabledColor].
''');

const disabledColorHelp = HelpData("ThemeData.disabledColor", '''
The color used for widgets that are inoperative, regardless of their state. For example, a disabled checkbox (which may be checked or unchecked).
''');

const buttonColorHelp = HelpData("ThemeData.buttonColor", '''
Defines the default configuration of button widgets, like [RaisedButton] and [FlatButton].
''');

const secondaryHeaderColorHelp = HelpData("ThemeData.secondaryHeaderColor", '''
According to the spec for data tables: https://material.io/archive/guidelines/components/data-tables.html#data-tables-tables-within-cards
...this should be the "50-value of secondary app color".
''');

const textSelectionColorHelp = HelpData("ThemeData.textSelectionColor", '''
The color of text selections in text fields, such as [TextField].
''');

const cursorColorHelp = HelpData("ThemeData.cursorColor", '''
The color of cursors in Material-style text fields, such as [TextField].
''');

const textSelectionHandleColorHelp = HelpData("ThemeData.textSelectionHandleColor", '''
The color of the handles used to adjust what part of the text is currently selected.
''');

const backgroundColorHelp = HelpData("ThemeData.backgroundColor", '''
A color that contrasts with the [primaryColor], e.g. used as the remaining part of a progress bar.
''');

const dialogBackgroundColorHelp = HelpData("ThemeData.dialogBackgroundColor", '''
The background color of [Dialog] elements.
''');

const indicatorColorHelp = HelpData("ThemeData.indicatorColor", '''
The color of the selected tab indicator in a tab bar.
''');

const hintColorHelp = HelpData("ThemeData.hintColor", '''
The color to use for hint text or placeholder text, e.g. in [TextField] fields.
''');

const errorColorHelp = HelpData("ThemeData.errorColor", '''
The color to use for input validation errors, e.g. in [TextField] fields.
''');

const toggleableActiveColorHelp = HelpData("ThemeData.toggleableActiveColor", '''
The color used to highlight the active states of toggleable widgets like [Switch], [Radio], and [Checkbox].
''');
