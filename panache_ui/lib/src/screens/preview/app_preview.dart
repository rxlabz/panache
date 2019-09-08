import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:panache_core/panache_core.dart';
import 'package:scoped_model/scoped_model.dart';

import 'code_preview.dart';
import 'subscreens/chips_preview.dart';
import 'subscreens/inputs_preview.dart';
import 'subscreens/others_preview.dart';
import 'subscreens/slider_preview.dart';
import 'subscreens/typography_preview.dart';
import 'subscreens/widgets_preview.dart';

const kIPhone5 = const Size(640 / 2, 1136 / 2);

const kIPhone6 = const Size(750 / 2, 1334 / 2);

const kS6 = const Size(1440 / 4, 2560 / 4);

class TabItem {
  final String text;
  final IconData icon;

  TabItem(this.text, this.icon);
}

class AppPreviewContainer extends StatefulWidget {
  final Size size;
  final bool showCode;

  AppPreviewContainer(this.size, {this.showCode});

  @override
  AppPreviewContainerState createState() {
    return new AppPreviewContainerState();
  }
}

class AppPreviewContainerState extends State<AppPreviewContainer> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, model) {
      return Material(
        child: widget.showCode
            ? ThemeCodePreview(model)
            : Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.blueGrey.shade800)),
                    color: Colors.blueGrey.shade700),
                child: Center(
                  child: Container(
                    width: widget.size.width,
                    height: widget.size.height,
                    child: ThemePreviewApp(
                      model: model,
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

class ThemePreviewApp extends StatefulWidget {
  final ThemeModel model;

  ThemeData get theme => model.theme;

  const ThemePreviewApp({Key key, this.model}) : super(key: key);

  @override
  ThemePreviewAppState createState() => ThemePreviewAppState();
}

class ThemePreviewAppState extends State<ThemePreviewApp>
    with SingleTickerProviderStateMixin {
  // RepaintBoundary key
  GlobalKey _globalKey = new GlobalKey();

  final _tabsItem = [
    TabItem('Controls', Icons.check_box),
    TabItem('Buttons', Icons.touch_app),
    TabItem('Inputs', Icons.keyboard),
    TabItem('Slider', Icons.tune),
    TabItem('Chips', Icons.dns),
    TabItem('Others', Icons.people),
    TabItem('Text', Icons.text_fields),
    TabItem('Primary Text', Icons.text_fields),
    TabItem('Accent Text', Icons.text_fields),
    /*TabItem('Color scheme', Icons.color_lens),*/
  ];

  TabController tabBarController;

  bool showFAB = true;

  get bottomItems => [
        {'label': 'Map', 'icon': Icons.map},
        {'label': 'Description', 'icon': Icons.description},
        {'label': 'Transform', 'icon': Icons.transform},
      ]
          .map<Widget>((item) => IconButton(
                    icon: Icon(item['icon']),
                    onPressed: () {},
                  )
              /*BottomNavigationBarItem(
                icon: Icon(item['icon']),
                title: Text(item['label']),
              )*/
              )
          .toList();

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: _tabsItem.length, vsync: this);
    tabBarController.addListener(() {
      setState(() {
        showFAB = tabBarController.index == 0;
      });
    });
    widget.model.initScreenshooter(_screenshot);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: AnimatedTheme(
        data: widget.theme,
        child: DefaultTabController(
          length: _tabsItem.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("App Preview"),
              bottom: _buildTabBar(),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.add_a_photo), onPressed: _screenshot),
                /*IconButton(
                      icon: Icon(Icons.create_new_folder),
                      onPressed: () => Scaffold.of(context).openDrawer()),*/
              ],
            ),
            floatingActionButton: tabBarController.index == 0
                ? FloatingActionButton(
                    child: Icon(
                      Icons.check,
                      /*color: widget.theme?.accentTextTheme?.button?.color,*/
                    ),
                    onPressed: () {})
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Text('Drawer'),
                ],
              ),
            ),
            body: TabBarView(controller: tabBarController, children: [
              WidgetPreview1(theme: widget.theme),
              ButtonPreview(theme: widget.theme),
              InputsPreview(theme: widget.theme),
              SliderPreview(theme: widget.theme),
              ChipsPreview(theme: widget.theme),
              OthersPreview(theme: widget.theme),
              TypographyPreview(
                textTheme: widget.theme.textTheme,
                brightness: widget.theme.brightness,
              ),
              TypographyPreview(
                textTheme: widget.theme.primaryTextTheme,
                brightness: widget.theme.primaryColorBrightness,
              ),
              TypographyPreview(
                textTheme: widget.theme.accentTextTheme,
                brightness: widget.theme.accentColorBrightness,
              ),
            ]),
            bottomNavigationBar: BottomAppBar(
              child: Row(children: bottomItems),
              shape: CircularNotchedRectangle(),
            ),
          ),
        ),
      ),
    );
  }

  _buildTabBar() => TabBar(
      isScrollable: true,
      controller: tabBarController,
      tabs:
          _tabsItem.map((t) => Tab(text: t.text, icon: Icon(t.icon))).toList());

  Future<Uint8List> _screenshot() async {
    ByteData bytedata;
    RenderRepaintBoundary boundary;

    if (_globalKey.currentContext == null) return Future.value(null);
    try {
      boundary = _globalKey.currentContext.findRenderObject();
      final capture = await boundary.toImage();
      bytedata = await capture.toByteData(format: ImageByteFormat.png);
      if (bytedata.lengthInBytes == 0) bytedata = null;
    } catch (error) {
      print('ThemePreviewAppState._screenshot => ERROR !\n$error');
      return Future.value(null);
    }

    return bytedata != null ? bytedata.buffer.asUint8List() : null;
  }
}
