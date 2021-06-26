import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_directory_admin/provider/data_provider.dart';
import 'package:media_directory_admin/variables/static_variables.dart';
import 'package:provider/provider.dart';
class SideBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Container(
      width: size.width<1200? 0.0: size.width*.2,
      height: size.height,
      color: Colors.blueGrey,
      //color: Colors.white,
      child:  ListView.builder(
        itemCount: Variables.sideBarMenuList().length,
        itemBuilder: (context, index)=>EntryItemTile(
            Variables.sideBarMenuList()[index],
            size,dataProvider),
      ),
    );
  }
}


class EntryItemTile extends StatelessWidget {
  final Entry entry;
  final Size size;
  DataProvider dataProvider;
  EntryItemTile(this.entry,this.size,this.dataProvider);
  String? _category;
  String? _subCategory;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        onTap: (){
          _subCategory=root.title;
          dataProvider.category= _category!;
          dataProvider.subCategory= _subCategory!;
        },
        contentPadding: EdgeInsets.only(left: 40),
        dense: true,
        title: Text(root.title,style: TextStyle(color: Colors.white,fontSize: size.height*.02)),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(root.iconData,size: size.height*.03,color: Colors.white),
          SizedBox(width: size.height*.02),
          Text(root.title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: size.height*.022,color: Colors.white)),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
      onExpansionChanged: (val){
        _category= root.title;
      },
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}