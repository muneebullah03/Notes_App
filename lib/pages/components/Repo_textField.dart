import 'package:flutter/material.dart';
import 'package:hive_myprojcet/utiles/App_String.dart';

class RepoTextFormField extends StatelessWidget {
  const RepoTextFormField({
    super.key,
    required this.controller,
    this.isFordescroption = false,
    required this.onFieldSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isFordescroption;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isFordescroption ? 6 : null,
          cursorHeight: !isFordescroption ? 60 : null,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              border: isFordescroption ? InputBorder.none : null,
              counter: Container(),
              hintText: isFordescroption ? AppStr.addNote : null,
              prefixIcon: isFordescroption
                  ? const Icon(Icons.bookmark_border, color: Colors.grey)
                  : null,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 30, 24, 24)))),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
