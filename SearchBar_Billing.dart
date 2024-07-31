import 'package:flutter/material.dart';

Widget searchBar({
  required String hintText,
  required TextEditingController controller,
  Function(String)? onChanged,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(Icons.search),
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                controller.clear();
                if (onChanged != null) {
                  onChanged('');
                }
              },
            )
          : null,
    ),
    onChanged: onChanged,
  );
}
//                         SearchBar(

//   leading: Icon(Linecons.search),
//   controller: _searchController,
//   onChanged: (value) {
//     setState(() {
//       _searchKeyword.value = value;
//     });
//   },
//   hintText: 'Search Item Here...',
//   trailing: _searchController.text.isNotEmpty
//       ? [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               _searchController.clear();
//               _searchKeyword.value = '';
//             });
//           },
//           icon: Icon(Icons.clear, color: AppColor.black),
//         ),
//         ]
//       : null,
// )