import 'help.dart';

const primaryColorHelp = HelpData("primaryColor", '''
The background color for major parts of the app (toolbars, tab bars, etc)

The theme's [colorScheme] property contains [ColorScheme.primary], as well as a color that contrasts well with the primary color called [ColorScheme.onPrimary]. It might be simpler to just configure an app's visuals in terms of the theme's [colorScheme].
''');

const accentColorHelp = HelpData("accentColor", '''
The foreground color for widgets (knobs, text, overscroll edge effect, etc).

Accent color is also known as the secondary color.

The theme's [colorScheme] property contains [ColorScheme.secondary], as well as a color that contrasts well with the secondary color called [ColorScheme.onSecondary]. It might be simpler to just configure an app's visuals in terms of the theme's [colorScheme].
''');

const scaffoldColorHelp = HelpData("scaffoldColor", '''
The default color of the [Material] that underlies the [Scaffold].

The background color for a typical material app or a page within the app.
''');
