import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//----------------------------------------------------------------------------
class AppendList extends StatelessWidget
{
  AppendList({super.key});

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
          const EditWorkName(),
          const PrioritySelect(),
          Container(margin: const EdgeInsets.only(top:20.0),),
          const EditBox(label: 'Deadline'),
          const EditBox(label: 'Alarm'),   
          const WorkListSelect(),   
        ],
      ),  
      backgroundColor: Colors.black,  
    ); 
  }
}
//----------------------------------------------------------------------------
class EditWorkName extends StatefulWidget 
{
  const EditWorkName({super.key});

  @override
  State<EditWorkName> createState() => _EditWorkName();
}
//----------------------------------------------------------------------------
class _EditWorkName extends State<EditWorkName>
{
  bool _isChecked = false ;

  @override
	Widget build(BuildContext context)
	{
		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: const Color.fromARGB(255, 40, 40, 40),
      child: Row
      (
        children :
        [ 
          Switch
          (
            value: _isChecked,
            onChanged: (value) { setState(() {_isChecked = value ;}); },
          ),
          Flexible
          (
            child: TextFormField
            (
              style: const TextStyle(color: Colors.white, fontSize: 20,),
              decoration: const InputDecoration
              (
                border: OutlineInputBorder(),
                labelText: 'Work Name' ,
                labelStyle: TextStyle(color: Colors.blueGrey ),
              ),  
            ),  
          ),
        ],
      ),
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
  DateTime? _chosenDateTime = DateTime.now();
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
    myController.addListener( _printLatestValue );

		return Container
		(
			color: const Color.fromARGB(255, 40, 40, 40),
      child: TextFormField
      (
        controller: myController,
        style: const TextStyle(color: Colors.white, fontSize: 20,),
        onTap: () { showDatePicker(context); },
        readOnly: true,
        decoration: InputDecoration
        (
          border: const OutlineInputBorder(),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.blueGrey),
        ),
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
					const Text('Priority', style: TextStyle(color: Colors.white, fontSize: 18), ),
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
class WorkListSelect extends StatefulWidget
{
  const WorkListSelect({super.key});

  @override
  State<WorkListSelect> createState() => _WorkListSelect();
}
//----------------------------------------------------------------------------
class _WorkListSelect extends State<WorkListSelect>
{	
  List<String> dropdownList = ['Purchase', 'My Work'];
  String selectedDropdown = 'Purchase';

	@override
	Widget build(BuildContext context)
  {
    return Container
		(
      margin: const EdgeInsets.only(top:20.0), 
			color: const Color.fromARGB(255, 40, 40, 40),
      child: Row
      (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          const Text('List', style: TextStyle(color: Colors.white, fontSize: 18),),
          DropdownButton
          (
            value: selectedDropdown,
            items: dropdownList.map
            ( 
              (String item) 
              { 
                return DropdownMenuItem<String>(child: Text('$item', style: TextStyle(color: Colors.red),), value: item,);
              }
            ).toList(),
            onChanged: (dynamic value) { setState(() { selectedDropdown = value;});},
          ),
        ]
      )
    );
  }
}
//----------------------------------------------------------------------------