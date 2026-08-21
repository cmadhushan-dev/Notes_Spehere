import 'package:dp_notes_spehere_08/models/note_model.dart';
import 'package:dp_notes_spehere_08/services/note_services.dart';
import 'package:dp_notes_spehere_08/utitlites/colors.dart';
import 'package:dp_notes_spehere_08/utitlites/constnat.dart';
import 'package:dp_notes_spehere_08/utitlites/router.dart';
import 'package:dp_notes_spehere_08/utitlites/text_styles.dart';
import 'package:dp_notes_spehere_08/widgets/notes_card.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //insatnce for noteService
  final NoteServices noteService = NoteServices();

  //list of notes arry for loading
  List<NoteModel> allNotes = [];
  //load the data from the service class
  Map<String, List<NoteModel>> notesWithCategory = {};

  //check whether user is new
  void _checkWhetherUserisNewAndCreateIntialNote() async {
    final bool isnewuser = await noteService.isNewUser();
    //if the user is new create the intial new
    if (isnewuser) {
      await noteService.createInitalNotes();
    }
    //load the note when come
    _loadNotesFromTheServiceClass();
  }

  //load the notes
  Future<void> _loadNotesFromTheServiceClass() async {
    final List<NoteModel> lodedNotes = await noteService.loadNotes();
    final Map<String, List<NoteModel>> notesByCategory = noteService
        .getNotesByCategoryMap(lodedNotes);
    setState(() {
      allNotes = lodedNotes;
      print(allNotes.length);
      notesWithCategory = notesByCategory;
      print(notesWithCategory);
    });
  }

  @override
  void initState() {
    super.initState();
    _checkWhetherUserisNewAndCreateIntialNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.routers.go('/homePage');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: AppColors.kWhiteColor, width: 2),
        ),

        child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstant.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: AppTextStyles.appTitle),
            const SizedBox(height: 30),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "No Notes are availble please click the plus button to add a new note",
                        style: AppTextStyles.appDescriptionSmall,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: notesWithCategory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppConstant.kDefaultPadding,
                          childAspectRatio: 6 / 4,
                          mainAxisSpacing: AppConstant.kDefaultPadding,
                        ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //go to the notes by category page
                          AppRouter.routers.push(
                            '/notebycategory',
                            extra: notesWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          noteCategory: notesWithCategory.keys.elementAt(index),
                          numberOfNotes: notesWithCategory.values
                              .elementAt(index)
                              .length,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
