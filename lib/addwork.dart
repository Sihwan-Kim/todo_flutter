import 'package:flutter/material.dart';

class AppendList extends StatelessWidget 
{
  const AppendList({super.key});

  @override
	Widget build(BuildContext context)
	{
		return Scaffold
    (
      appBar:	AppBar
      (
        backgroundColor: const Color.fromARGB(255, 40, 40, 40),
        title: const Text('Append Work', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        leading: TextButton
        (
          style: TextButton.styleFrom(foregroundColor: Colors.white,), 
          onPressed: () {},
          child: const Text('Cancel', style: TextStyle(fontSize: 15, color: Colors.white),), 
        ),
        leadingWidth: 100,
        actions:
        [ 
          TextButton
          (
            style: TextButton.styleFrom(foregroundColor: Colors.white,), 
            onPressed: () {},
            child: const Text('Confirm', style: TextStyle(fontSize: 15, color: Colors.white),), 
          ),
        ],
      ),
      body: Column
      (
        children: 
        [
          const EditBox(label: 'Work Name', readOnly: false),
          SingleSelect(),
          const EditBox(label: 'Deadline', readOnly: true),
          const EditBox(label: 'Alarm', readOnly: true),        
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
//----------------------------------------------------------------------------
class EditBox extends StatelessWidget
{
	const EditBox({super.key, required this.label, required this.readOnly});
  final String label;
  final bool readOnly;

	@override
	Widget build(BuildContext context)
	{
		return Container
		(
			margin: const EdgeInsets.only(top:20.0), 
			color: const Color.fromARGB(255, 40, 40, 40),
      child: Column
      (
        children:
        [
          Text( label, style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),),
          TextFormField
          (
            readOnly: readOnly,
            decoration: const InputDecoration
            (
              fillColor: Colors.white,
              
            )
          ),
        ],
      ),
    );
	}
}
//----------------------------------------------------------------------------
class SingleSelect extends StatelessWidget
{
	SingleSelect({super.key});
	final _selections1 = [false, true, false];

	@override
	Widget build(BuildContext context)
	{
		return Container
		(
			color: const Color.fromARGB(255, 40, 40, 40),
			child: Row
			(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children:
				[
					const Text('Priority', style: TextStyle(color: Colors.white), ),
					ToggleButtons
					(
						onPressed: (int index) {},
						isSelected: _selections1,
						children: const
						[
							Icon(Icons.ac_unit, color: Colors.white,),
							Icon(Icons.call, color: Colors.white,),
							Text("WIFI"),
						],
					),
				]
			),
		);
	}
}
//----------------------------------------------------------------------------
