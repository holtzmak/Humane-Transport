import 'package:app/core/view_models/faq_screen_view_model.dart';
import 'package:app/ui/common/style.dart';
import 'package:app/ui/common/view_state.dart';
import 'package:app/ui/widgets/utility/busy_overlay_screen.dart';
import 'package:app/ui/widgets/utility/template_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQScreen extends StatefulWidget {
  static const route = '/FAQ';

  FAQScreen({
    Key key,
  }) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<ExpansionListItem> _faqWrapper = [];

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    super.initState();
    _faqWrapper.addAll([
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease visit these links to find infomation:\n https://inspection.canada.ca/DAM/DAM-animals-animaux/WORKAREA/DAM-animals-animaux/text-texte/livestock_transport_pdf_1528296360187_eng.pdf \n https://inspection.canada.ca/animal-health/humane-transport/transporting-unfit-or-compromised-animals/eng/1582045810428/1582045810850\n",
          ),
          headerValue: "How to make sure that animal is fit for the trip?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nThe requirements for the transport of all animals into, within and out of Canada are found in Part XII of the Health of Animals Regulations.  Please Click this link for more information: \n https://gazette.gc.ca/rp-pr/p2/2019/2019-02-20/html/sor-dors38-eng.html\n",
          ),
          headerValue:
              "What are the requirements/responsibilities for the transport of all animals into, within and out of Canada?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nOnly animals that are fit to handle transport may be loaded. If you are not sure, refer to the National Farm Animal Care Council (NFACC) specific codes of practice or seek the advice of a professional before deciding to load an animal.  Please Click this link for the information: \n https://www.nfacc.ca/codes-of-practice\n",
          ),
          headerValue:
              "I am not sure whether this animal is fit to handle transport or not. Where to find help or more information before deciding to load an animal?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://inspection.canada.ca/animal-health/humane-transport/transporting-unfit-or-compromised-animals/eng/1582045810428/1582045810850\n",
          ),
          headerValue:
              "What are the signs of an unfit animal and compromise animal?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a1-5\n",
          ),
          headerValue:
              "What to expect when inspections are conducted during transportation?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a11\n",
          ),
          headerValue:
              "What are the requirements of animal handling from loading to unloading?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a19\n",
          ),
          headerValue:
              "What are the requirements for Feed, Water and Rest? What are the maximum allowed intervals without feed, water, and rest?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a5\n",
          ),
          headerValue: "What are the requirements for the Contingency plans?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nPlease Click this link for the information: \n https://www.livestocktransport.ca/en/\n",
          ),
          headerValue: "What is Cnadian Livestock Transport(CLT) program?"),
      ExpansionListItem(
          expandedValue: Linkify(
            onOpen: _onOpen,
            text:
                "\nHealth of Animals Regulations Pt. XII(Interpretive Guide): \n https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914\n\n Humane Animal Transport Main Website\n https://inspection.canada.ca/animal-health/humane-transport/eng/1300460032193/1300460096845\n",
          ),
          headerValue: "Find additional links here: "),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBaseViewModel<FAQScreenViewModel>(
        builder: (context, model, child) => BusyOverlayScreen(
            show: model.state == ViewState.Busy,
            child: Scaffold(
                backgroundColor: Beige,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: NavyBlue, //change your color here
                  ),
                  title: const Text('FAQ',
                      style: TextStyle(
                          color: NavyBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: MediumTextSize)),
                  backgroundColor: White,
                ),
                body: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          child: buildExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _faqWrapper[index].isExpanded = !isExpanded;
                                });
                              },
                              items: _faqWrapper)),
                    ],
                  ),
                )))));
  }
}
