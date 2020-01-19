import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:dbsheets/setdata.dart';

class OfflineWidget extends StatelessWidget {
  OfflineWidget({Key key, this.pdata}) : super(key: key);
  final pdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order')),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Stack(
            fit: StackFit.expand,
            children: [
              child,
              AnimatedPositioned(
                height: connected ? 0 : 32.0,
                left: 0.0,
                right: 0.0,
                duration: const Duration(milliseconds: 750),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: connected
                        ? Text('ONLINE')
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('OFFLINE'),
                              SizedBox(width: 8.0),
                              SizedBox(
                                width: 12.0,
                                height: 12.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          );
        },
        child: SetData(pdata: pdata),
      ),
    );
  }
}
