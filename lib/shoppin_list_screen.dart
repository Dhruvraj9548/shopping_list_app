import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_app/shopping_list_model.dart';

import 'database_helper.dart';

class ListScreen extends StatelessWidget {
  final Item? item;
  const ListScreen({
    Key? key,
    this.item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if(item != null){
      titleController.text = item!.title;
      descriptionController.text = item!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? 'Add an item' : 'Edit item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text('Which item do you want to add?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    labelText: 'Item Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )
                    )
                ),
              ),),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'What is this item about?',
                  labelText: 'Item description',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )
                  )
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()async{
                    final title = titleController.value.text;
                    final description = titleController.value.text;

                    if (title.isEmpty || description.isEmpty){
                      return;
                    }


                    final Item model = Item(title: title, description: description, id: item?.id);
                    if(item == null){
                      await DatabaseHelper.addItem(model);
                    }else{
                      await DatabaseHelper.updateItem(model);
                    }


                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 0.75,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )
                          ))
                  ),
                  child: Text( item == null ? 'Save' : 'Edit',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),)
          ],
        ),
      ),
    );
  }
}
