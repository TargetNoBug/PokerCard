//
//  ViewController.swift
//  Example
//
//  Created by Weslie Chen on 2019/9/11.
//  Copyright © 2019 Weslie. All rights reserved.
//

import UIKit
import PokerCard
import MessageUI

class ViewController: UIViewController {
    
    @IBAction func lightStyle(_ sender: Any) {
        if #available(iOS 13.0, *) {
            currentWindow?.overrideUserInterfaceStyle = .light
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
    @IBAction func darkStyle(_ sender: Any) {
        if #available(iOS 13.0, *) {
            currentWindow?.overrideUserInterfaceStyle = .dark
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- Show Alert
    @IBAction func showAlert(_ sender: Any) {
        PokerCard.showAlert(title: "The Alert Title", detail: "Here is some detail information, you may configure the alert view as following...").confirm(title: "Confirm", style: .danger, cancelTitle: nil)
    }
    
    // MARK:- Show Input
    @IBAction func showInput(_ sender: Any) {
        let detail = "Optianal detail, leave it or not🤪You may see your name in the consle when clicking confirm"
        
        PokerCard.showInput(title: "Please input your name", detail: detail)
            .confirm(title: "Done", style: .warn, cancelTitle: "取消") { name in
            print("Hey, \(name)!")
        }
    }
    
    // MARK:- Show Prompt
    @IBAction func showPrompt(_ sender: Any) {
        let warning = """
        Warning: The unauthorized reproduction or distribution of this copyrighted work is illegal. Criminal copyright infringement, including infringement without monetary gain, is investigated by the FBI and is punishable by up to five years in federal prison and a fine of $250,000.
        """
        
        PokerCard.showPromotion(title: "FBI WARNING", promotion: warning, secondaryTitle: "Enter Password")
            .appearance(promotionStyle: .color(.systemPink), placeholder: "******")
            .validate(validatePassword(_:))
            .confirm(title: "Enter", style: .primary, fill: false, cancelTitle: "Quit") { _ in
            print("Hello Agent!")
        }.shouldBecomeFirstResponder()
    }
    
    // MARK:- Show Appearance
    @IBAction func showAppearance(_ sender: Any) {
        if #available(iOS 13.0, *) {
            PokerCard.showAppearanceOptions()
                .config(light: {
                    print("light selected")
                }, dark: {
                    print("dark selected")
                }) {
                    print("auto selected")
            }
            .setTitles(title: "Appearance", light: "Light", dark: "Dark", auto: "Auto")
            .addOption(title: "Show Theme", isChecked: false) { trigger in
                print(trigger)
            }
        } else {
            print("Appearance is available on iOS 13 and later.")
        }
    }
    
    // MARK:- Show Contacts
    @IBAction func showContacts(_ sender: Any) {
        // mail
        let mailEntity = PKContactType.MailEntity()
        let email = PKOption.Contact(type: .email(mailEntity), title: "Email", image: UIImage(named: "mail")!)
        // iMessage
        let messageEntity = PKContactType.MessageEntity()
        messageEntity.recipients = ["iweslie@icloud.com"]
        let message = PKOption.Contact(type: .message(messageEntity), title: "iMessage", image: UIImage(named: "message")!)
        // weibo
        let weibo = PKOption.Contact(type: .weibo("6425782290"), title: "Weibo", image: UIImage(named: "weibo")!)
        // wechat
        let wechat = PKOption.Contact(type: .wechat("weslie-chen"), title: "WeChat", image: UIImage(named: "wechat")!)
        wechat.delay = 1.5
        wechat.action = {
            print("something")
        }
        // github
        let github = PKOption.Contact(type: .github("iWeslie"), title: "GitHub", image: UIImage(named: "github")!)
        
        PokerCard.showContacts()
            .setTitle("Contact Us")
            .addOptions([email, message, weibo, wechat, github], on: self)
            
    }
    
    // MARK:- Show Language Picker
    @IBAction func showLanguagePicker(_ sender: Any) {
        PokerCard.showLanguagePicker()
            .config(en: {
                print("en selected")
            }, zh: {
                print("zh selected")
            }) {
                print("auto selected")
            }
        .setTitle("Language")
        .setImages(en: UIImage(named: "enLang")!, zh: UIImage(named: "zhLang")!, auto: UIImage(named: "autoLang")!, checkmark: UIImage(named: "checkmark")!)
    }
    
    func validatePassword(_ password: String) -> Bool {
        if password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func showAccessGranter(_ sender: Any) {
        
        let camera = PKOption.Auth(type: .camera, title: "Camera", image: UIImage())
        let location = PKOption.Auth(type: .location, title: "Location", image: UIImage())
        
        PokerCard.showAccessGranter()
            .setTitle("Auth")
            .addOptions([camera, location])
    }
}

// MARK: - MFMessageComposeViewControllerDelegate
extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true) {
            if result == .cancelled {
                print("cancel")
            }
        }
    }
}
