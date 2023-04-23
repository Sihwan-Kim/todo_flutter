import 'package:flutter/material.dart';


//----------------------------------------------------------------------------
class NewWorkList extends StatelessWidget
{
  const NewWorkList({super.key});

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
            onPressed: () {},
            child: const Text('Confirm', style: TextStyle(fontSize: 15, color: Colors.white),), 
          ),
        ],
      ),
      body: Column
      (
        children: const
        [
          EditWorkName(),
          ListColorSelect(),
          ListFinishSelect(),
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
      ),  
    );
  }
}
//----------------------------------------------------------------------------
class ListColorSelect extends StatefulWidget 
{
  const ListColorSelect({super.key});

  @override
  State<ListColorSelect> createState() => _ListColorSelect();
}
//----------------------------------------------------------------------------
class _ListColorSelect extends State<ListColorSelect>
{
  @override
	Widget build(BuildContext context)
	{
		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: const Color.fromARGB(255, 40, 40, 40),
      height: 60,
      child: const ListTile
      ( 
        tileColor: Color.fromARGB(255, 40, 40, 40),
        title: Text('List Color', style: TextStyle(fontSize: 20, color: Colors.white),),
        trailing: Icon(Icons.circle, color: Colors.red,),
      ),     
    );
  }
}
//----------------------------------------------------------------------------
class ListFinishSelect extends StatefulWidget 
{
  const ListFinishSelect({super.key});

  @override
  State<ListFinishSelect> createState() => _ListFinishSelect();
}
//----------------------------------------------------------------------------
class _ListFinishSelect extends State<ListFinishSelect>
{
  bool _isChecked = false ;

  @override
	Widget build(BuildContext context)
	{
		return Container
    (
      margin: const EdgeInsets.only(top:20.0), 
      color: const Color.fromARGB(255, 40, 40, 40),
      height: 60,
      child: ListTile
      ( 
        tileColor: const Color.fromARGB(255, 40, 40, 40),
        title: const Text('Finished', style: TextStyle(fontSize: 20, color: Colors.white),),
        trailing: Switch
        (
          value: _isChecked,
          onChanged: (value) { setState(() {_isChecked = value ;}); },
        ),
      ),     
    );
  }
}
//----------------------------------------------------------------------------