//
//  HelpViewController.swift
//  FinTask
//
//  Created by Иван Незговоров on 06.07.2024.
//

import UIKit

class HelpViewController: UIViewController {
    
    var isLoader: Bool = true
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var textView: UITextView = {
        let text = UITextView(frame: view.bounds.inset(by: UIEdgeInsets(top: 40, left: 20, bottom: 50, right: 20)))
        text.isEditable = false
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .black
        text.backgroundColor = .clear
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup layer
private extension HelpViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(cancelButton)
        if isLoader {
            privacyPolicy()
        } else {
            userAgreement()
        }
        
    }
    
    func userAgreement() {
        textView.text = """
               FinTask Terms of Service
                              FinTask is a mobile application for iOS, developed by IE MARLIN (Administrator). FinTask is an application for personal finance accounting, budget planning and gathering statistics. Your use of the FinTask provided by Administration is subject to the following terms (“ToS”), that are legally binding agreement between you and Administration without any other parties. You can download FinTask from App Store for free. Monetika contains in-app purchases (“Premium plan”), set of features to extend application functionality.
               Acceptance
               These ToS regulate the legal relationship between you and Administrator. You should not use FinTask if you don’t accept them. The ToS are always available to be viewed and downloaded through FinTask application. You must also confirm your acceptance by choosing “I agree to the Terms of Service” when you are creating account (“Sign Up” process) in the application.
               Term and Termination
               The ToS will remain in full force and effect while you use Monetika and until terminated by either you or the Administrator. Termination always includes deletion of your user account and all related data and content, unless your data and content have been shared with other users, and they have not deleted them. You may terminate the ToS at any time and for any reason by sending a written notice to the address of the Administrator or to the e-mail of the Administrator and deleting the Monetika application. Administrator may terminate the ToS at any time and for any reason. In case of immediate termination due to your breach of the ToS you are not entitled to any refunds.
               Amendments
               From time to time, Administrator may amend the ToS at its sole discretion. You will be notified about the planned changes in advance through Monetika application or via e-mail. Updated ToS will be posted to this page 14 days prior to the effective date. By continued use of Monetika, you are expressing your acceptance of the changes. If you don't agree with the changes, you may terminate the Terms at any time. Release of updated version of the Monetika application may precede the effective date of the updated ToS for the existing users. You may be required to accept the updated ToS in order to be able to use all features of updated version of the Monetika application.
               Sign up and User Account
               You must use FinTask only in accordance with the ToS, for the purpose it was intended and obey all of the applicable laws and terms and conditions of third parties. In order to be able to access to Monetika you have to sign up. You agree to provide accurate, truthful and current information and keep it up to date. You must keep your Monetika account login information confidential and secure and you may not share it with anyone. You are solely responsible and liable for any and all activities that occur under your account. The Administration reserves the right to refuse your registration or suspend your Monetika account at any time.
               User content
               You may enter and upload to Monetika or synchronize with it texts, numerical data, photos or other content. You retain copyright and all other rights to your content that qualifies for a legal protection. For such content you grant Administrator a worldwide non-exclusive, no-charge and royalty-free license to use it in the connection with provision of the services, including without limitation, rights to copy, reproduce, modify, create derivative works of, publish, display, upload, transmit, distribute, market and sublicense. You represent that you have all necessary rights and consents to do so. The license lasts for the full term of the copyright or until a termination of the ToS.
               You are solely responsible for any content you provide to Monetika and for any consequences thereof. You may not enter or upload to Monetika or synchronize with it unlawful content or content that infringes copyright or any other third party rights.
               In a case you are a consumer with your normal place of abode or residence in the European Union, by pressing the "BUY" button you also consent that the contractual performance will start immediately and you acknowledge that for this reason you lose your right of withdrawal.
               Payment is due and payable immediately upon completion of the purchase process. Performance starts immediately after a successful transaction by unlocking Premium package in Monetika. It proceeds by electronic means and is not subject to any extra fees.
               If you purchased a subscription, it will automatically renew itself for another term of the same length, unless you cancel it before the current term runs out. The subscription price is charged on the first day of the new term. You can cancel your subscription at any time. The cancellation will take effect the day after the last day of the current subscription term and Monetika will be downgraded.
               Refunds for the in-app purchases are generally not provided by Administrator.
               For purchases made via Apple's App Store, the refund process is handled by Apple exclusively. Unfortunately we have no control over the refunds for purchases made via the iTunes App Store so the refunds remain entirely at Apple's discretion.
               Privacy
               Some features of FinTask may be used only if you consent to your personal data being processed. All information, including the extent and the manner of processing your personal data is included in the "Privacy Policy", which forms an integral part of the ToS.
               You can withdraw your given consent at any time by deleting your Monetika account and the Monetika application.
               Export Control
               You represent and warrant that you are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a terrorist-supporting country and you are not listed on any U.S. Government list of prohibited or restricted parties.
               Language
               English is a primary language of communication between you and the Administration. All information about FinTask is available in the English language. The ToS are available in the English language only. English shall be also the binding and controlling language for the additional contracts concluded pursuant to the ToS.
               Contacts
               IE MARLIN
               e-mail: feedback@getmonetika.com
               You may not upload any content describing or depicting violence or content which is pornographic, discriminatory, racist, defamatory or otherwise illegal and share it with other users of Monetika.
               Administrator does not review the user content, but reserves the right to remove or disable access to any user content for any reason. Administrator has no responsibility for the accuracy of the content you provided to Monetika or synchronized with it or which was created by FinTask based on your input. You are solely responsible for backing up the content you enter or upload to Monetika or synchronize with it.
               License
               FinTask application and all rights therein, including intellectual property rights, shall remain Administrator’s property or the property of its licensors. Nothing in the ToS shall be construed to grant you any rights, except for the limited license granted below.
               Subject to the ToS, Administrator grants you a limited, non-exclusive, non-transferrable, non-sublicensable license, to access and use Monetika and its Premium package purchased pursuant to the ToS on any device that you own and control. The license is granted solely for your personal, non-commercial use. Therefore, you may not rent, lease, lend, sell, transfer, redistribute, or sublicense the FinTask application. Third party services or libraries included in Monetika are licensed to you either under these ToS, or under the third party's license terms, if applicable.
               Based on your license, you may not access Monetika with other means than the mobile phone application, mine or extract any data from FinTask databases, modify, reverse engineer, hack, decode, decrypt, decompile, disassemble or create derivative works of Monetika application or any part thereof and circumvent any technology used to protect the paid Premium features. You also may not remove, delete or obliterate any copyright notices, proprietary labels or private legends placed upon or found within the Monetika application.
               Maintenance and Support
               FinTask is subject to a continuous development and Administration reserves the right, at it's sole discretion, to update the Monetika application, change the nature of Monetika or modify or discontinue some of the features without prior notice to you. You acknowledge that Administrator has no obligation to maintain or update Monetika. Administrator does not guarantee an uninterrupted provision of the services. Monetika or integrated third-party services may be temporary unavailable due to the maintenance, certain technical difficulties, or other events that are beyond Administrator's control. If you have some questions, problems or suggestions, you can reach the Administrator via contacts provided hereafter. However, you acknowledge that the support to non-paying users of Monetika is limited due to the limited capacity of the Administrator.
               Premium Plan
               FinTask application is available for free. Free version allows you to use only the basic features of Monetika. You can unlock Premium package by in-app purchases. Premium plan unlocked by subscriptions. You can choose between 1 month and 12 months term.
               Current detailed information about the in-app purchase offer is always available on the the Monetika application.
               Prices are displayed in your local currency (if supported) and always include the applicable VAT (Value Added Tax).
               Administrator does not guarantee that Monetika or any of its features will always be free and reserves the right, at its sole discretion, to change the pricing at any time.
               Payments and Refunds
               You can purchase Premium package subscriptions simply by pressing the "BUY" button in the platform in-app purchase dialogue, which summarizes information about billing type, price and term.
               By pressing the "BUY" button you enter into an additional contract pursuant to the ToS. Due to the method of conclusion of the contract, the text of the contract is neither saved nor accessible.
               """
        view.addSubview(textView)
    }
    
    func privacyPolicy() {
        textView.text = """
               Privacy Policy

               If you disagree with the terms of our Privacy Policy please do not use the “Monetika” application!

               IE “MARLIN” (hereinafter “FinTask” or Administration) shall keep your information confidential. Your privacy is important to us. It is Monetika's policy to respect your privacy regarding any information we may collect from you through our app, Monetika.
               We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we’re collecting it and how it will be used.
               We respect your privacy. We do not store your data on our servers. All your transactions, accounts and statistics will only be stored on your device and can be backed up to your iCloud.
               Information collection
               App Administration may collect the following information about application users:
                • E-mail address
                • Name
               Information use
               Some of the ways that user personal information may be used are described below:
                • Sending various e-mails
                • Compiling statistical data
               We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we’ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorised access, disclosure, copying, use or modification.
               We don’t share any personally identifying information publicly or with third-parties, except when required to by law.
               Our app may link to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and cannot accept responsibility or liability for their respective privacy policies.
               You are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some of your desired services.
               Your continued use of our application will be regarded as acceptance of our practices around privacy and personal information. If you have any questions about how we handle user data and personal information, feel free to contact us.
               This policy is effective as of 13 September 2019.
               """
        view.addSubview(textView)
    }
    
    @objc func cancelButtonTap() {
        dismiss(animated: true)
    }
}
