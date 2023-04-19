import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//----------------------------------------------------------------------------
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
class EditBox extends StatefulWidget 
{
  const EditBox({super.key, required this.label, required this.readOnly});
  final String label;
  final bool readOnly;

  @override
  State<EditBox> createState() => _EditBox();
}
//----------------------------------------------------------------------------
class _EditBox extends State<EditBox>
{
  DateTime? _chosenDateTime;
  final myController = TextEditingController();

  void showDatePicker(ctx)    // Show the modal that contains the CupertinoDatePicker
  {    
    showCupertinoModalPopup  // showCupertinoModalPopup is a built-in function of the cupertino library
    (
      context: ctx,
      builder: (_) => Container
      (
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column
        (
          children: 
          [
            SizedBox
            (
              height: 400,
              child: CupertinoDatePicker
              (
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (val) { setState(() { _chosenDateTime = val;}); }
              ),
            ),                 
            CupertinoButton   // Close the modal
            (
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      )
    );
  }

  void _printLatestValue() 
  {
    myController.text = DateFormat.yMd().add_jm().format(_chosenDateTime!); 
  }

	@override
	Widget build(BuildContext context)
	{
    final String labelName = widget.label ;
    final bool readOnly = widget.readOnly;
    myController.addListener( _printLatestValue );

		return Container
		(
			margin: const EdgeInsets.only(top:20.0), 
			color: const Color.fromARGB(255, 40, 40, 40),
      child: Column
      (
        children:
        [
          Text(labelName, style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),),
          TextFormField
          (
            controller: myController,
            style: const TextStyle(color: Colors.white, fontSize: 20,),
            onTap: () { if(readOnly == true) showDatePicker(context); },
            readOnly: readOnly,
            decoration: const InputDecoration
            (
    	        border: OutlineInputBorder(),
    	        labelText: '' ,
            ),
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
							Icon(Icons.width_normal_outlined, color: Colors.white,),
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
