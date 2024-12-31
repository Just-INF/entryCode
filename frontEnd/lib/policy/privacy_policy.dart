import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Last Updated On 04-Aug-2024\nEffective Date 04-Aug-2024',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              Text(
                'This Privacy Policy describes the policies of Just INF, Romania, email: justy@gmail.com on the collection, use and disclosure of your information that we collect when you use our website (https://justinf.ro) (the “Service”). By accessing or using the Service, you are consenting to the collection, use and disclosure of your information in accordance with this Privacy Policy. If you do not consent to the same, please do not access or use the Service.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'We may modify this Privacy Policy at any time without any prior notice to you and will post the revised Privacy Policy on the Service. The revised Policy will be effective 180 days from when the revised Policy is posted in the Service and your continued access or use of the Service after such time will constitute your acceptance of the revised Privacy Policy. We therefore recommend that you periodically review this page.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Information We Collect:'),
              _buildParagraph('We will collect and process the following personal information about you:'),
              _buildBulletList(['Email', 'Usernames', 'Passwords']),
              SizedBox(height: 20),
              _buildSectionTitle('How We Use Your Information:'),
              _buildParagraph('We will use the information that we collect about you for the following purposes:'),
              _buildBulletList(['Creating user account', 'Support', 'Administration info', 'Manage user account']),
              _buildParagraph('If we want to use your information for any other purpose, we will ask you for consent and will use your information only on receiving your consent and then, only for the purpose(s) for which grant consent unless we are required to do otherwise by law.'),
              SizedBox(height: 20),
              _buildSectionTitle('Retention Of Your Information:'),
              _buildParagraph('We will retain your personal information with us for 90 days to 2 years after users terminate their accounts or for as long as we need it to fulfill the purposes for which it was collected as detailed in this Privacy Policy. We may need to retain certain information for longer periods such as record-keeping / reporting in accordance with applicable law or for other legitimate reasons like enforcement of legal rights, fraud prevention, etc. Residual anonymous information and aggregate information, neither of which identifies you (directly or indirectly), may be stored indefinitely.'),
              SizedBox(height: 20),
              _buildSectionTitle('Your Rights:'),
              _buildParagraph('Depending on the law that applies, you may have a right to access and rectify or erase your personal data or receive a copy of your personal data, restrict or object to the active processing of your data, ask us to share (port) your personal information to another entity, withdraw any consent you provided to us to process your data, a right to lodge a complaint with a statutory authority and such other rights as may be relevant under applicable laws. To exercise these rights, you can write to us at justy@gmail.com. We will respond to your request in accordance with applicable law.'),
              _buildParagraph('Do note that if you do not allow us to collect or process the required personal information or withdraw the consent to process the same for the required purposes, you may not be able to access or use the services for which your information was sought.'),
              SizedBox(height: 20),
              _buildSectionTitle('Cookies Etc.'),
              _buildParagraph('To learn more about how we use these and your choices in relation to these tracking technologies, please refer to our Cookie Policy.'),
              SizedBox(height: 20),
              _buildSectionTitle('Security:'),
              _buildParagraph('The security of your information is important to us and we will use reasonable security measures to prevent the loss, misuse or unauthorized alteration of your information under our control. However, given the inherent risks, we cannot guarantee absolute security and consequently, we cannot ensure or warrant the security of any information you transmit to us and you do so at your own risk.'),
              SizedBox(height: 20),
              _buildSectionTitle('Third Party Links & Use Of Your Information:'),
              _buildParagraph('Our Service may contain links to other websites that are not operated by us. This Privacy Policy does not address the privacy policy and other practices of any third parties, including any third party operating any website or service that may be accessible via a link on the Service. We strongly advise you to review the privacy policy of every site you visit. We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.'),
              SizedBox(height: 20),
              _buildSectionTitle('Grievance / Data Protection Officer:'),
              _buildParagraph('If you have any queries or concerns about the processing of your information that is available with us, you may email at Just INF, email: justy@gmail.com. We will address your concerns in accordance with applicable law.'),
              SizedBox(height: 20),
              Text(
                'Privacy Policy generated with CookieYes.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => _buildBulletItem(item)).toList(),
      ),
    );
  }

  Widget _buildBulletItem(String item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(
            item,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}