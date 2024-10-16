import 'package:flutter/material.dart';

Future<bool?> myAlertBSheet({
  required BuildContext context,
}) async {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10),
              Icon(
                Icons.delete,
                size: 70,
                color: Colors.redAccent,
              ),
              Text(
                "Are You Sure You Want To Delete That ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dialogbutton(
                      context: context,
                      name: "Y E S",
                      padding: EdgeInsets.only(left: 30),
                      color: Theme.of(context).colorScheme.surface,
                      booling: true),
                  dialogbutton(
                      context: context,
                      name: "N O",
                      padding: EdgeInsets.only(right: 30),
                      color: Theme.of(context).colorScheme.surface,
                      booling: false),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}

// import 'package:flutter/material.dart';

// class MyAlertBSheet extends StatelessWidget {
//   const MyAlertBSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       title:
// content:
//       actions: [

//       ],
//     );
//   }
// }

Padding dialogbutton(
    {required BuildContext context,
    required String name,
    required EdgeInsetsGeometry padding,
    required Color color,
    required bool booling}) {
  return Padding(
    padding: padding,
    child: InkWell(
      onTap: () => Navigator.of(context).pop(booling),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Text(
          name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
