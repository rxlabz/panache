import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:provider/provider.dart';

enum DriveAction { login, logout, save, list }

class DriveMenu extends StatelessWidget {
  final ThemeModel model;

  const DriveMenu({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return PopupMenuButton(
      child: model.user != null
          ? Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.network(model.user.avatarPath, width: 32),
            )
          : null,
      icon: model.user != null ? null : Icon(Icons.cloud_upload),
      itemBuilder: (BuildContext context) => _buildActions(),
      onSelected: (DriveAction action) {
        switch (action) {
          case DriveAction.login:
            _onLoginRequest(context, model, userService);
            break;
          case DriveAction.save:
            _onExportToDrive(context, model, userService);
            break;
          case DriveAction.logout:
            userService.logout();
            break;
          default:
            break;
        }
      },
    );
  }

  void _onExportToDrive(
    BuildContext context,
    ThemeModel model,
    UserService service,
  ) async {
    final exportService = Provider.of<ExportService>(context);
    final result = await service.exportTheme(exportService.toCode(model.theme));
    Scaffold.of(context).showSnackBar(_buildSnackBar(
        result: result != null,
        successLabel: 'Export success => $result',
        errorLabel: 'Sorry, the export failed... :('));
  }

  void _onLoginRequest(
    BuildContext context,
    ThemeModel model,
    UserService service,
  ) async {
    final result = await service.login();
    if (result)
      Scaffold.of(context).showSnackBar(_buildSnackBar(
          result: result,
          successLabel: 'Logged as ${model.user.name}.',
          errorLabel: 'Authentication failed.'));
  }

  List<PopupMenuItem<DriveAction>> _buildActions() {
    final actions = <PopupMenuItem<DriveAction>>[];
    model.user != null
        ? actions.addAll([
            PopupMenuItem<DriveAction>(
                value: DriveAction.save,
                child: Row(
                  children: <Widget>[
                    Image.asset('assets/google-drive.png', width: 32),
                    Expanded(child: Text('Export', textAlign: TextAlign.right)),
                  ],
                )),
            PopupMenuItem<DriveAction>(
                value: DriveAction.logout,
                child: Align(
                    alignment: Alignment.centerRight, child: Text('Logout'))),
          ])
        : actions.add(PopupMenuItem<DriveAction>(
            value: DriveAction.login,
            child: Row(
              children: <Widget>[
                Image.asset('assets/google.png', width: 32),
                Expanded(child: Text('Login', textAlign: TextAlign.right)),
              ],
            )));
    return actions;
  }
}

SnackBar _buildSnackBar({bool result, String successLabel, String errorLabel}) {
  return SnackBar(
      backgroundColor: result ? Colors.green : Colors.deepOrange,
      content: Row(
        children: <Widget>[
          Icon(result ? Icons.check : Icons.warning),
          Text(result ? successLabel : errorLabel),
        ],
      ));
}
