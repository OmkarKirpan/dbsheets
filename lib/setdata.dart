import 'package:flutter/material.dart';

import './model/user.dart';

class SetData extends StatefulWidget {
  SetData({Key key, this.pdata}) : super(key: key);

  final pdata;

  @override
  _SetDataState createState() => _SetDataState();
}

class _SetDataState extends State<SetData> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  void initState() {
    super.initState();
    this.setState(() {
      _user.pname = widget.pdata['name'];
      _user.sku = widget.pdata['sku'];
      _user.price = widget.pdata['price'].toString();
    });
    print(_user.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() => _user.name = val),
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your address.';
                        }
                        return null;
                      },
                      onSaved: (val) => setState(() => _user.address = val)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Product Info:'),
                        Divider(),
                        Text('Product Name: ' + _user.pname ?? ''),
                        Text('Product SKU: ' + _user.sku ?? ''),
                        Text('Product Price: ₹' + _user.price ?? ''),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: RaisedButton(
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              setData(_user);
                              _showDialog(context);
                            }
                          },
                          child: Text('Save'))),
                ]),
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form ' + _user.name)));
  }
}

// _user.pname
// _user.sku
//  _user.price
