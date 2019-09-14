import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:provider/provider.dart';

import 'action_bar.dart';
import 'panel_header.dart';
import 'panels/dialog_theme_panel.dart';
import 'panels/icon_theme_panel.dart';
import 'panels/input_decoration_theme_panel.dart';
import 'panels/panels.dart';

class ThemeEditor extends StatefulWidget {
  final ThemeModel model;

  ThemeEditor({this.model});

  @override
  State<StatefulWidget> createState() => ThemeEditorState();
}

class ThemeEditorState extends State<ThemeEditor> {
  bool colorPanelExpanded = false;
  bool buttonThemePanelExpanded = false;
  bool iconThemePanelExpanded = false;
  bool sliderThemePanelExpanded = false;
  bool tabBarThemePanelExpanded = false;
  bool chipThemePanelExpanded = false;
  bool dialogThemePanelExpanded = false;
  bool textPanelExpanded = false;
  bool primaryTextPanelExpanded = false;
  bool accentTextPanelExpanded = false;
  bool inputsPanelExpanded = false;

  ScrollController scrollController;

  @override
  void initState() {
    print('widget.model.scrollPosition ${widget.model.scrollPosition}');
    _initPanels();

    scrollController =
        ScrollController(initialScrollOffset: widget.model.scrollPosition ?? 0)
          ..addListener(() {
            widget.model.saveScrollPosition(scrollController.position.pixels);
          });

    super.initState();
  }

  void _initPanels() {
    final panelStates = widget.model.panelStates;
    colorPanelExpanded = panelStates['colorPanelExpanded'];
    buttonThemePanelExpanded = panelStates['buttonThemePanelExpanded'];
    iconThemePanelExpanded = panelStates['iconThemePanelExpanded'];
    sliderThemePanelExpanded = panelStates['sliderThemePanelExpanded'];
    tabBarThemePanelExpanded = panelStates['tabBarThemePanelExpanded'];
    chipThemePanelExpanded = panelStates['chipThemePanelExpanded'];
    textPanelExpanded = panelStates['textPanelExpanded'];
    primaryTextPanelExpanded = panelStates['primaryTextPanelExpanded'];
    accentTextPanelExpanded = panelStates['accentTextPanelExpanded'];
    inputsPanelExpanded = panelStates['accentTextPanelExpanded'];
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.model.theme.primaryColor;
    final orientation = MediaQuery.of(context).orientation;
    final inPortrait = orientation == Orientation.portrait;
    final useLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;

    final exporter = Provider.of<ExportService>(context);

    return Container(
      /*elevation: 4.0,*/
      color: Colors.blueGrey.shade100,
      child: ListView(
        controller: scrollController,
        /*shrinkWrap: true,*/
        children: [
          GlobalThemePropertiesControl(),
          ExpansionPanelList(
            expansionCallback: _onExpansionPanelUpdate,
            children: [
              _buildPanel(widget.model, 'Colors',
                  child: ThemeColorPanel(widget.model),
                  expanded: colorPanelExpanded,
                  activated: exporter.isActivated('mainColors'),
                  icon: Icons.color_lens,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('mainColors', value)),
              _buildPanel(widget.model, 'Button Theme',
                  activated: exporter.isActivated('buttonTheme'),
                  child: ButtonThemePanel(widget.model),
                  expanded: buttonThemePanelExpanded,
                  icon: Icons.touch_app,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('buttonTheme', value)),
              _buildPanel(widget.model, 'Inputs',
                  activated: exporter.isActivated('inputDecorationTheme'),
                  child: InputDecorationThemePanel(widget.model),
                  expanded: inputsPanelExpanded,
                  icon: Icons.keyboard,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('inputDecorationTheme', value)),
              _buildPanel(widget.model, 'TabBar Theme',
                  activated: exporter.isActivated('tabBarTheme'),
                  child: TabBarThemePanel(widget.model),
                  expanded: tabBarThemePanelExpanded,
                  icon: Icons.tab,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('tabBarTheme', value)),
              _buildPanel(widget.model, 'Slider Theme',
                  activated: exporter.isActivated('sliderTheme'),
                  child: SliderThemePanel(widget.model),
                  expanded: sliderThemePanelExpanded,
                  icon: Icons.tune,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('sliderTheme', value)),
              _buildPanel(widget.model, 'Text Theme',
                  activated: exporter.isActivated('textTheme'),
                  child: TypographyThemePanel(
                    model: widget.model,
                    txtTheme: widget.model.theme.textTheme,
                    themeRef: 'textTheme',
                  ),
                  expanded: textPanelExpanded,
                  icon: Icons.font_download,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('textTheme', value)),
              _buildPanel(widget.model, 'Primary Text Theme',
                  activated: exporter.isActivated('primaryTextTheme'),
                  child: TypographyThemePanel(
                      model: widget.model,
                      themeRef: 'primaryTextTheme',
                      txtTheme: widget.model.theme.primaryTextTheme),
                  expanded: primaryTextPanelExpanded,
                  icon: Icons.font_download,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('primaryTextTheme', value)),
              _buildPanel(widget.model, 'Accent Text Theme',
                  activated: exporter.isActivated('accentTextTheme'),
                  child: TypographyThemePanel(
                      model: widget.model,
                      themeRef: 'accentTextTheme',
                      txtTheme: widget.model.theme.accentTextTheme),
                  expanded: accentTextPanelExpanded,
                  icon: Icons.font_download,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('accentTextTheme', value)),
              _buildPanel(widget.model, 'Chips Theme',
                  activated: exporter.isActivated('chipTheme'),
                  child: ChipThemePanel(widget.model),
                  expanded: chipThemePanelExpanded,
                  icon: Icons.dns,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('chipTheme', value)),
              _buildPanel(widget.model, 'Icon Themes',
                  activated: exporter.isActivated('iconTheme'),
                  child: IconThemePanel(widget.model),
                  expanded: iconThemePanelExpanded,
                  icon: Icons.insert_emoticon,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('iconTheme', value)),
              _buildPanel(widget.model, 'Dialog Theme',
                  activated: exporter.isActivated('dialogTheme'),
                  child: DialogThemePanel(widget.model),
                  expanded: dialogThemePanelExpanded,
                  icon: Icons.check_box_outline_blank,
                  color: primaryColor,
                  dense: !useLargeLayout,
                  onChanged: (bool value) =>
                      exporter.activate('dialogTheme', value)),
            ],
          )
        ],
      ),
    );
  }

  void _onExpansionPanelUpdate(int panelIndex, bool isExpanded) {
    switch (panelIndex) {
      case 0:
        colorPanelExpanded = !isExpanded;
        break;
      case 1:
        buttonThemePanelExpanded = !isExpanded;
        break;
      case 2:
        inputsPanelExpanded = !isExpanded;
        break;
      case 3:
        tabBarThemePanelExpanded = !isExpanded;
        break;
      case 4:
        sliderThemePanelExpanded = !isExpanded;
        break;
      case 5:
        textPanelExpanded = !isExpanded;
        break;
      case 6:
        primaryTextPanelExpanded = !isExpanded;
        break;
      case 7:
        accentTextPanelExpanded = !isExpanded;
        break;
      case 8:
        chipThemePanelExpanded = !isExpanded;
        break;
      case 9:
        iconThemePanelExpanded = !isExpanded;
        break;
      case 10:
        dialogThemePanelExpanded = !isExpanded;
        break;
    }

    final panelStates = <String, bool>{
      'colorPanelExpanded': colorPanelExpanded,
      'buttonThemePanelExpanded': buttonThemePanelExpanded,
      'inputsPanelExpanded': inputsPanelExpanded,
      'tabBarThemePanelExpanded': tabBarThemePanelExpanded,
      'sliderThemePanelExpanded': sliderThemePanelExpanded,
      'textPanelExpanded': textPanelExpanded,
      'primaryTextPanelExpanded': primaryTextPanelExpanded,
      'accentTextPanelExpanded': accentTextPanelExpanded,
      'chipThemePanelExpanded': chipThemePanelExpanded,
      'iconThemePanelExpanded': iconThemePanelExpanded,
      'dialogThemePanelExpanded': dialogThemePanelExpanded
    };
    widget.model.saveEditorState(panelStates, scrollController.position.pixels);

    setState(() {});
  }

  ExpansionPanel _buildPanel(
    ThemeModel model,
    String label, {
    @required bool activated,
    @required ValueChanged<bool> onChanged,
    @required IconData icon,
    @required Color color,
    @required Widget child,
    bool expanded: false,
    bool dense,
  }) {
    return ExpansionPanel(
      isExpanded: expanded,
      headerBuilder: (context, isExpanded) => ExpanderHeader(
        icon: icon,
        color: color,
        label: label,
        dense: dense,
        disabled: activated,
        onChanged: onChanged,
      ),
      body: child,
    );
  }
}
