import 'package:dp_notes_spehere_08/helpers/snack_bars.dart';
import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/note_catergory_card.dart';

class NotesByCategory extends StatefulWidget {
  final String category;
  const NotesByCategory({super.key, required this.category});

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  //intilazed the notes service
  final NoteServices noteService = NoteServices();
  //hold the loadin notes
  List<NoteModel> noteLists = [];

  //load the data from the notes service accroding to the category
  Future<void> _loadNotesByCategory() async {
    noteLists = await noteService.getNotesByCategoryName(widget.category);
    setState(() {
      setState(() {
        print(noteLists.length);
      });
    });
  }

  //edit  note
  void _editNote(NoteModel noteForEdit) {
    //navigate to the noteedit page
    AppRouter.routers.push("/editNote", extra: noteForEdit);
  }

  //remove note
  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (mounted) {
        SnackBarsClass.showSnackBar(context, 'Note deleted Succfully');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.category, style: AppTextStyles.appTitle),
              const SizedBox(height: 12),
              GridView.builder(
                itemCount: noteLists.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstant.kDefaultPadding,
                  mainAxisSpacing: AppConstant.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemBuilder: (context, index) {
                  return NoteCatergoryCard(
                    noteTitle: noteLists[index].title,
                    noteContent: noteLists[index].content,
                    removeNotes: () async {
                      await _removeNote(noteLists[index].id);
                      setState(() {
                        //remove the valus from the ui list
                        noteLists.removeAt(index);
                      });
                    },
                    editNotes: () async {
                      _editNote(noteLists[index]);
                    },
                    viewSignleNote: () {
                      AppRouter.routers.push("/SingleNoteView",extra: noteLists[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
