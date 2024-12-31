import 'package:flutter/material.dart';

class CookiesPolicyPage extends StatelessWidget {
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
                'Cookies Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Last updated: August 05, 2024',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              Text(
                'This Cookies Policy explains what Cookies are and how We use them. You should read this policy so You can understand what type of cookies We use, or the information We collect using Cookies and how that information is used. This Cookies Policy has been created with the help of the Cookies Policy Generator.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Cookies do not typically contain any information that personally identifies a user, but personal information that we store about You may be linked to the information stored in and obtained from Cookies. For further information on how We use, store and keep your personal data secure, see our Privacy Policy.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'We do not store sensitive personal information, such as mailing addresses, account passwords, etc. in the Cookies We use.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Interpretation and Definitions'),
              _buildSubSectionTitle('Interpretation'),
              Text(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSubSectionTitle('Definitions'),
              Text(
                'For the purposes of this Cookies Policy:',
                style: TextStyle(fontSize: 16),
              ),
              _buildBulletList([
                'Company (referred to as either "the Company", "We", "Us" or "Our" in this Cookies Policy) refers to BorderRo.',
                'Cookies means small files that are placed on Your computer, mobile device or any other device by a website, containing details of your browsing history on that website among its many uses.',
                'Website refers to BorderRo, accessible from just.ro',
                'You means the individual accessing or using the Website, or a company, or any legal entity on behalf of which such individual is accessing or using the Website, as applicable.'
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('The use of the Cookies'),
              _buildSubSectionTitle('Type of Cookies We Use'),
              Text(
                'Cookies can be "Persistent" or "Session" Cookies. Persistent Cookies remain on your personal computer or mobile device when You go offline, while Session Cookies are deleted as soon as You close your web browser.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'We use both session and persistent Cookies for the purposes set out below:',
                style: TextStyle(fontSize: 16),
              ),
              _buildBulletList([
                'Necessary / Essential Cookies\nType: Session Cookies\nAdministered by: Us\nPurpose: These Cookies are essential to provide You with services available through the Website and to enable You to use some of its features. They help to authenticate users and prevent fraudulent use of user accounts. Without these Cookies, the services that You have asked for cannot be provided, and We only use these Cookies to provide You with those services.',
                'Functionality Cookies\nType: Persistent Cookies\nAdministered by: Us\nPurpose: These Cookies allow us to remember choices You make when You use the Website, such as remembering your login details or language preference. The purpose of these Cookies is to provide You with a more personal experience and to avoid You having to re-enter your preferences every time You use the Website.'
              ]),
              SizedBox(height: 20),
              _buildSubSectionTitle('Your Choices Regarding Cookies'),
              Text(
                'If You prefer to avoid the use of Cookies on the Website, first You must disable the use of Cookies in your browser and then delete the Cookies saved in your browser associated with this website. You may use this option for preventing the use of Cookies at any time.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'If You do not accept Our Cookies, You may experience some inconvenience in your use of the Website and some features may not function properly.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'If You\'d like to delete Cookies or instruct your web browser to delete or refuse Cookies, please visit the help pages of your web browser.',
                style: TextStyle(fontSize: 16),
              ),
              _buildBulletList([
                'For the Chrome web browser, please visit this page from Google: https://support.google.com/accounts/answer/32050',
                'For the Internet Explorer web browser, please visit this page from Microsoft: http://support.microsoft.com/kb/278835',
                'For the Firefox web browser, please visit this page from Mozilla: https://support.mozilla.org/en-US/kb/delete-cookies-remove-info-websites-stored',
                'For the Safari web browser, please visit this page from Apple: https://support.apple.com/guide/safari/manage-cookies-and-website-data-sfri11471/mac',
                'For any other web browser, please visit your web browser\'s official web pages.'
              ]),
              SizedBox(height: 20),
              _buildSubSectionTitle('More Information about Cookies'),
              Text(
                'You can learn more about cookies here: All About Cookies by TermsFeed.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildSubSectionTitle('Contact Us'),
              Text(
                'If you have any questions about this Cookies Policy, You can contact us:',
                style: TextStyle(fontSize: 16),
              ),
              _buildBulletList([
                'By email: justy@gmail.com'
              ]),
              SizedBox(height: 20),
              Text(
                'Cookies Policy generated with the help of the Cookies Policy Generator.',
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

  Widget _buildSubSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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