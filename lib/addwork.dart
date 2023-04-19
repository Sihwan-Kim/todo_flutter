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
          Container
          (
            margin: const EdgeInsets.only(top:20.0), 
            color: const Color.fromARGB(255, 40, 40, 40),
            child: Column
            (
              children:
              [
                TextFormField
                (
                  style: const TextStyle(color: Colors.white, fontSize: 20,),
                  decoration: const InputDecoration
                  (
                    border: OutlineInputBorder(),
                    labelText: 'Work Name' ,
                  ),
                ),
              ],
            ),
          ),
          const PrioritySelect(),
          const EditBox(label: 'Deadline'),
          const EditBox(label: 'Alarm'),      
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
//----------------------------------------------------------------------------
class EditBox extends StatefulWidget 
{
  const EditBox({super.key, required this.label});
  final String label;

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
    try
    {
      myController.text = DateFormat.yMd().add_jm().format(_chosenDateTime!); 
    }
    catch(e)
    {
      myController.text = '' ;
    }
  }

	@override
	Widget build(BuildContext context)
	{
    final String labelName = widget.label ;
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
            onTap: () { showDatePicker(context); },
            readOnly: true,
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
class PrioritySelect extends StatefulWidget
{
  const PrioritySelect({super.key});

  @override
  State<PrioritySelect> createState() => _PrioritySelect();
}
//----------------------------------------------------------------------------
class _PrioritySelect extends State<PrioritySelect>
{	
  final List<bool> _selections = List.generate(4, (index) => false);

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
						onPressed: (int index) { setState(() { _selections.fillRange(0, 4, false) ; _selections[index] = true;}); },
						isSelected: _selections,
						children: const
						[
              Text("NONE", style: TextStyle(color: Colors.white,),),
              Text("P1", style: TextStyle(color: Colors.white,),),
              Text("P2", style: TextStyle(color: Colors.white,),),
              Text("P3", style: TextStyle(color: Colors.white,),),
						],
					),
				]
			),
		);
	}
}
//----------------------------------------------------------------------------
