import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
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
                    removeNotes: ()async{},
                    editNotes:  ()async{},
                  );
                },
              ),

              // NoteCatergoryCard(
              //   noteContent:
              //       'ffrgrggrgkfndjfl nfbfjkfbe febkfbrejer jl.bljb.eb',
              //   noteTitle: 'This is main Titlle',
              //   removeNotes: () async {},
              //   editNotes: () async {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
