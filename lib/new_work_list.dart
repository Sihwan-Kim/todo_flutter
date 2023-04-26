import 'package:flutter/material.dart';
import 'model.dart';
import 'viewmodel.dart';

class NewWorkList extends StatefulWidget
{
  const NewWorkList({super.key});

  @override
  State<NewWorkList> createState() => _NewWorkList();
}
//----------------------------------------------------------------------------
class _NewWorkList extends State<NewWorkList>
{
  var _visibility = false;  
  set setVisible(value) => setState(() {_visibility = value;});

  var _colorIndex = 0;  
  set setColor(value) => setState(() {_colorIndex = value;});

  var _workName = '';
  set setName(value) => setState(() {_workName = value;});

  void _addWorkList()
  {     
    DatabaseControl().insertData(WorkListProperty(_workName, 0, _colorIndex)) ;
    listValueControl.append( WorkListProperty(_workName, 0, _colorIndex));
  }

  @override
	Widget build(BuildContext context)
	{
		return Scaffold
    (
      appBar:	AppBar
      (
        backgroundColor: const Color.fromARGB(255, 40, 40, 40),
        title: const Text('New Work List', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        leading: TextButton
        (
          style: TextButton.styleFrom(foregroundColor: Colors.white,), 
          onPressed: () { Navigator.pop(context); },
          child: const Text('Cancel', style: TextStyle(fontSize: 15, color: Colors.white),), 
        ),
        leadingWidth: 100,
        actions:
        [ 
          TextButton
          (
            style: TextButton.styleFrom(foregroundColor: Colors.white,), 
            onPressed: () => _addWorkList(),
            child: const Text('Confirm', style: TextStyle(fontSize: 15, color: Colors.white),), 
          ),
        ],
      ),   
      body: Column
      (
        children:
        [
          const EditWorkName(),
          ListColorSelect(colorIndex: _colorIndex,),
          Visibility
          (
            visible: _visibility,
            child: const ColorSelect(),
          ),  
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
  @override
	Widget build(BuildContext context)
	{
    _NewWorkList? parent = context.findAncestorStateOfType<_NewWorkList>(); 

		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: const Color.fromARGB(255, 40, 40, 40),
      child: TextFormField
      (
        style: const TextStyle(color: Colors.white, fontSize: 20,),
        decoration: const InputDecoration
        (
          border: OutlineInputBorder(),
          labelText: 'List Name' ,
          labelStyle: TextStyle(color: Colors.blueGrey ),
        ),  
        onChanged: (value) => parent!.setName = value ,
      ),  
    );
  }
}
//----------------------------------------------------------------------------
class ListColorSelect extends StatefulWidget 
{  
  const ListColorSelect({super.key, required this.colorIndex});
  final int colorIndex ;

  @override
  State<ListColorSelect> createState() => _ListColorSelect();
}
//----------------------------------------------------------------------------
class _ListColorSelect extends State<ListColorSelect>
{
  @override
	Widget build(BuildContext context)
	{
     _NewWorkList? parent = context.findAncestorStateOfType<_NewWorkList>(); 

		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: const Color.fromARGB(255, 40, 40, 40),
      height: 60,
      child: ListTile
      ( 
        tileColor: const Color.fromARGB(255, 40, 40, 40),
        title: const Text('List Color', style: TextStyle(fontSize: 20, color: Colors.white),),
        trailing: InkWell
        (
          onTap: () { parent!.setVisible = true; },
          child: Icon(Icons.circle, color: WorkListColor[widget.colorIndex],),
        ),
      ),     
    );
  }
}
//----------------------------------------------------------------------------
class ColorSelect extends StatefulWidget
{
  const ColorSelect({super.key});

  @override
  State<ColorSelect> createState() => _ColorSelect();
}
//----------------------------------------------------------------------------
class _ColorSelect extends State<ColorSelect>
{
  final List<bool> _selections = List.generate(5, (index) => false);

  @override
	Widget build(BuildContext context)
	{
    _NewWorkList? parent = context.findAncestorStateOfType<_NewWorkList>(); 

		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: Colors.white,
      height: 60,
      child: ToggleButtons
      (
        onPressed: (int index) 
        { 
          parent!.setVisible = false; 
          parent.setColor = index;
        },
        isSelected: _selections,
        children: const
        [
          Icon(Icons.circle, color: Colors.red,),
          Icon(Icons.circle, color: Colors.yellow,),
          Icon(Icons.circle, color: Colors.green,),
          Icon(Icons.circle, color: Colors.blue,),
          Icon(Icons.circle, color: Colors.purple,),
        ]
      ),
    );
  }
}
//----------------------------------------------------------------------------