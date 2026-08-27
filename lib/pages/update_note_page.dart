import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/helpers/snack_bars.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel updateNote;
  const UpdateNotePage({super.key, required this.updateNote});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  //varible to stor the dropdownselection value
  String category = '';
  //form key
  final _formKey = GlobalKey<FormState>();
  //controller
  final _newNoteTitleTextEdtingController = TextEditingController();
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
    //loadin the values from the other class
    _newContentTextEdtingController.text = widget.updateNote.content;
    _newNoteTitleTextEdtingController.text = widget.updateNote.title;
    category = widget.updateNote.category;
  }

  //dispose the every controllers
  @override
  void dispose() {
    super.dispose();
    _newContentTextEdtingController.dispose();
    _newNoteTitleTextEdtingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Note')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  //load the value from the other page
                  value: category,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please select a category';
                    } else {
                      return null;
                    }
                  },
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
                      //this load the defauls value
                      value: oneElement,
                      child: Text(oneElement, style: AppTextStyles.appButton),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      category = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: AppTextStyles.appDescriptionSmall,
                  controller: _newNoteTitleTextEdtingController,

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please entre a note title';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _newContentTextEdtingController,
                  style: AppTextStyles.appDescriptionSmall,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please writte somethings';
                    } else {
                      return null;
                    }
                  },
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
                      onPressed: () {
                        //save the note
                        if (_formKey.currentState!.validate()) {
                          try {
                            //access the noteservice class
                            note.updatenote(
                              NoteModel(
                                title: _newNoteTitleTextEdtingController.text,
                                category: category,
                                content: _newContentTextEdtingController.text,
                                date: DateTime.now(),
                                id: widget.updateNote.id,
                              ),
                            );

                            //snackbar message from other class
                            SnackBarsClass.showSnackBar(
                              context,
                              'Sucsfully Record updated..',
                            );

                            _newContentTextEdtingController.clear();
                            _newNoteTitleTextEdtingController.clear();
                            AppRouter.routers.push("/notespage");
                          } catch (error) {
                            print(error);
                            //snackbar message from other class
                            SnackBarsClass.showSnackBar(
                              context,
                              'Fail to Update..',
                            );
                          }
                        }
                      },
                      child: Text(
                        "update note",
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
