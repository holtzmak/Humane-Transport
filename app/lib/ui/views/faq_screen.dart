import 'package:app/ui/common/style.dart';
import 'package:app/ui/widgets/models/expansion_list_item.dart';
import 'package:flutter/material.dart';
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
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/DAM/DAM-animals-animaux/WORKAREA/DAM-animals-animaux/text-texte/livestock_transport_pdf_1528296360187_eng.pdf\n\nhttps://inspection.canada.ca/animal-health/humane-transport/transporting-unfit-or-compromised-animals/eng/1582045810428/1582045810850",
            ),
          ),
          headerValue:
              "How do I make sure that an animal is fit for the trip?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "The requirements for the transport of all animals into, within, and out of Canada are found in Part XII of the Health of Animals Regulations\nhttps://gazette.gc.ca/rp-pr/p2/2019/2019-02-20/html/sor-dors38-eng.html",
            ),
          ),
          headerValue:
              "What are the requirements/responsibilities for the transport of all animals into, within, and out of Canada?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "Only animals that are fit to handle transport may be loaded. If you are not sure, refer to the National Farm Animal Care Council specific codes of practice or seek the advice of a professional before deciding to load an animal.\nhttps://www.nfacc.ca/codes-of-practice",
            ),
          ),
          headerValue:
              "I am not sure whether this animal is fit to handle transport or not.\n\nWhere do I find help or more information before deciding to load an animal?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/animal-health/humane-transport/transporting-unfit-or-compromised-animals/eng/1582045810428/1582045810850",
            ),
          ),
          headerValue: "What are the signs of an unfit or compromised animal?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a1-5",
            ),
          ),
          headerValue:
              "What to expect when inspection is conducted during transport?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a11",
            ),
          ),
          headerValue:
              "What are the requirements of animal handling from loading to unloading?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a19",
            ),
          ),
          headerValue:
              "What are the requirements for feed, water, and rest?\n\nWhat are the maximum allowed intervals without feed, water, and rest?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  "See the Inspections Canada website for more information\nhttps://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914#a5",
            ),
          ),
          headerValue: "What are the requirements for the contingency plan?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  '''See the Livestock Transport website for more information\nhttps://www.livestocktransport.ca/en/''',
            ),
          ),
          headerValue: "What is the Canadian Livestock Transport program?"),
      ExpansionListItem(
          expandedValue: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: Linkify(
              onOpen: _onOpen,
              text:
                  '''Health of Animals Regulations Pt. XII (Interpretive Guide) 
                    https://inspection.canada.ca/animal-health/humane-transport/health-of-animals-regulations-part-xii/eng/1582126008181/1582126616914
                    \nHumane Animal Transport Main Website
                    https://inspection.canada.ca/animal-health/humane-transport/eng/1300460032193/1300460096845''',
            ),
          ),
          headerValue: "Additional Inspections Canada links"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: buildExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _faqWrapper[index].isExpanded = !isExpanded;
                  });
                },
                items: _faqWrapper)),
      ),
    );
  }
}
