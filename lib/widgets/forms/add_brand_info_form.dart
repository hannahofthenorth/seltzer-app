import 'package:flutter/material.dart';

class AddBrandInfoForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String brandName,
    String imageUrl,
  ) submitFn;

  AddBrandInfoForm(this.isLoading, this.submitFn);

  @override
  _AddBrandInfoFormState createState() => _AddBrandInfoFormState();
}

class _AddBrandInfoFormState extends State<AddBrandInfoForm> {
  final _formKey = GlobalKey<FormState>();
  var _brand = '';
  var _imageUrl = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _brand.trim(),
        _imageUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('brand'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter brand name',
                    ),
                    //TODO: validate on whether or not the brand already exists in the brands list
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a brand';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _brand = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('imageUrl'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter image URL';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _imageUrl = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter image URL'),
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text('Enter Brand Info'),
                      onPressed: _trySubmit,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
