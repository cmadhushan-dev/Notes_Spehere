import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class CreateNewNote extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  //controller
  final _newCategoryTextEdtingController = TextEditingController();
  final _newNoteTextEdtingController = TextEditingController();
  final _newContentTextEdtingController = TextEditingController();

  //lsi that hold the all notes categries
  List<String> categires = [];
  //pbject for note service
  final note = NoteServices();
  //function for load the notes (init state cant load the async methods)
  Future _loadCategires() async {
    categires = await note.getAllCtegries();
    //setstate for add the itme to the list
    setState(() {
      print(categires.length);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategires();
  }

  //dispose the every controllers
  @override
  void dispose() {
    super.dispose();
    _newCategoryTextEdtingController.dispose();
    _newContentTextEdtingController.dispose();
    _newNoteTextEdtingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewCategory ? 'New Category' : 'Create Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isNewCategory
                    ? TextFormField(
                        controller: _newCategoryTextEdtingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          hintText: "New Category",
                          hintStyle: AppTextStyles.appDescriptionLarge.copyWith(
                            color: AppColors.kWhiteColor.withOpacity(0.4),
                          ),
                        ),
                      )
                    : DropdownButtonFormField(
                        style: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        isExpanded: false,
                        hint: Text('Category'),
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.6),
                            ),
                          ),
                        ),

                        items: categires.map((String oneElement) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: oneElement,
                            child: Text(
                              oneElement,
                              style: AppTextStyles.appButton,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _newNoteTextEdtingController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor.withOpacity(0.6),
                      ),
                    ),
                    hintText: "Note Title",
                    hintStyle: AppTextStyles.appDescriptionLarge.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _newNoteTextEdtingController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: AppColors.kWhiteColor.withOpacity(0.6),
                      ),
                    ),
                    hintText: "Note Content",
                    hintStyle: AppTextStyles.appDescriptionLarge.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  color: AppColors.kWhiteColor.withOpacity(0.2),
                  thickness: 1,
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kFabColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Save note",
                        style: AppTextStyles.appDescriptionSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
