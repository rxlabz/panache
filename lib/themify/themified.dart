import 'package:flutter/material.dart';

class TabItem {
  final String text;
  final IconData icon;

  TabItem(this.text, this.icon);
}

class Themified extends StatefulWidget {
  ThemeData theme;
  Themified(this.theme);
  @override
  State<StatefulWidget> createState() => new ThemifiedState(theme);
}

class ThemifiedState extends State<Themified>
    with SingleTickerProviderStateMixin {
  ThemeData theme;

  double sliderValue = 0.5;

  final tabsItem = [
    new TabItem('Controls', Icons.report),
    new TabItem('Texte Themes', Icons.cloud_queue),
  ];

  ThemifiedState(this.theme);

  get bottomItems => [
        {'label': 'Map', 'icon': Icons.map},
        {'label': 'Description', 'icon': Icons.description},
        {'label': 'Transform', 'icon': Icons.transform},
      ]
          .map((item) => new BottomNavigationBarItem(
              icon: new Icon(item['icon']/*, color: theme.unselectedWidgetColor,*/), title: new Text(item['label'])))
          .toList();

  @override
  void didUpdateWidget(Themified oldWidget) {
    super.didUpdateWidget(oldWidget);
    theme = widget.theme;
  }

  @override
  Widget build(BuildContext context) {
    //final tabController = new TabController(length: 2, vsync: this);
    return new MaterialApp(
        title: 'App Preview',
        debugShowCheckedModeBanner: false,
        /*theme: theme,*/
        home: new Theme(
            data: theme,
            child: new DefaultTabController(
              length: 2,
              child: new Scaffold(
                appBar: new AppBar(
                  title: const Text(
                    'App Preview',
                  ),
                  bottom: _buildTabBar(),
                ),
                body: new TabBarView(
                    children: [_buildTab1Content(), _buildTab2Content()]),
                bottomNavigationBar:
                    new BottomNavigationBar(items: bottomItems),
              ),
            )));
  }

  _buildTabBar() => new TabBar(
      tabs: tabsItem
          .map((t) => new Tab(
                text: t.text,
                icon: new Icon(t.icon),
              ))
          .toList());

  _buildTab1Content() => new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.symmetric(vertical: 16.0),
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new RaisedButton(
                      onPressed: () => print('bt... '),
                      child: const Text("A button"),
                    ),
                    new FloatingActionButton(
                        child: new Icon(
                          Icons.check,
                          color: theme.accentTextTheme.button.color
                            /* theme.accentColorBrightness == Brightness.dark
                              ? theme.accentTextTheme.button.color
                              : theme.accentTextTheme.button.color*/,
                        ),
                        onPressed: () => print('FAB... ')),
                    new FlatButton(
                        onPressed: () => print('flatbutton... '),
                        child: const Text('FlatButton')),
                    new IconButton(
                        icon: new Icon(
                          Icons.restore_from_trash,
                          color: theme.textTheme.button.color,
                        ),
                        onPressed: () => print('IconButton... ')),
                  ])),
          new Divider(),
          new Row(
            children: <Widget>[
              new Checkbox(
                  value: true, onChanged: (v) => print('checkbox... ')),
              new Checkbox(
                  value: false, onChanged: (v) => print('checkbox... ')),
              new Checkbox(value: true, onChanged: null),
              new Checkbox(value: false, onChanged: null),
            ],
          ),
          new Divider(),
          new Row(
            children: <Widget>[
              new Radio(
                  value: false,
                  onChanged: (v) => print('checkbox... '),
                  groupValue: null),
              new Radio(
                  value: true,
                  onChanged: (v) => print('checkbox... '),
                  groupValue: true),
              new Switch(value: false, onChanged: (v) => print('checkbox... ')),
              new Switch(value: true, onChanged: (v) => print('checkbox... ')),
            ],
          ),
          new Divider(),
          new Slider(
              value: sliderValue,
              onChanged: (v) => setState(() => sliderValue = v)),
          new Row(
            children: <Widget>[
              new RaisedButton(
                child: new Text('Dialog'),
                onPressed: () => showDialog(
                    context: context,
                    child: new Theme(
                        child: new Dialog(
                          child: new Container(
                              width: 420.0,
                              height: 420.0,
                              child: new Text(
                                'a simple dialog',
                                style: theme.textTheme.headline,
                              )),
                        ),
                        data: widget.theme)),
              )
            ],
          ),
          new Row(children: [
            new Expanded(
                child: new LinearProgressIndicator(
              value: 0.57,
            )),
            new CircularProgressIndicator(
              value: 0.57,
              backgroundColor: Colors.yellow,
            ),
          ]),
          new IgnorePointer(
              child: new TextField(
            decoration: const InputDecoration(
                labelText: "Label text",
                hintText: "Hint text",
                errorText: "Error text example"),
            controller: new TextEditingController(text: 'a textfield'),
          ))
        ],
      ));

  _buildTab2Content() => new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: <Widget>[
            new Text(
              'Headline',
              style: widget.theme.textTheme.headline,
            ),
            new Text(
              'Subhead',
              style: widget.theme.textTheme.subhead,
            ),
            new Text(
              'Title',
              style: widget.theme.textTheme.title,
            ),
            new Text(
              'Body 1',
            ),
            new Text(
              'Body 1',
              style: widget.theme.textTheme.body1,
            ),
            new Text(
              'Body 2',
              style: widget.theme.textTheme.body2,
            ),
            new FlatButton(
                child: new Text(
                  'button',
                  style: widget.theme.textTheme.button,
                ),
                onPressed: () {}),
            new Text(
              'Display 1',
              style: widget.theme.textTheme.display1,
            ),
            new Text(
              'Display 2',
              style: widget.theme.textTheme.display2,
            ),
            new Text(
              'Display 3',
              style: widget.theme.textTheme.display3,
            ),
            new Text(
              'Display 4',
              style: widget.theme.textTheme.display4,
            ),
          ],
        ),
      );
}
