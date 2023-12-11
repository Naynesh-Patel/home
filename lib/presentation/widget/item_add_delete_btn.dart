import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class ItemAddBtn extends StatelessWidget {
  const ItemAddBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

class ItemSaveBtn extends StatelessWidget {
  const ItemSaveBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,

      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: yellowColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text("Save",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black),),
    );
  }
}

class DeleteIconBtn extends StatelessWidget {
  const DeleteIconBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(
        Icons.delete,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
