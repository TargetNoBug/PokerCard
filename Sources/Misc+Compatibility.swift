//
//  Misc+Compatibility.swift
//  PokerCard
//
//  Created by Weslie on 2019/10/8.
//  Copyright © 2019 Weslie (https://www.iweslie.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

func triggerSelectionChangedHapticFeedback() {
    if #available(iOS 10.0, *) {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}

enum NotificationFeedbackType: Int {
    case success = 0
    case warning
    case error
}
func triggerNotificationHapticFeedback(_ type: NotificationFeedbackType) {
    if #available(iOS 10.0, *) {
        let feedbackType = UINotificationFeedbackGenerator.FeedbackType(rawValue: type.rawValue) ?? .warning
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

func open(_ url: URL) {
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        UIApplication.shared.openURL(url)
    }
}

extension UIImage {
    convenience init?(pointSize: CGFloat, name: String) {
        if #available(iOS 13.0, *) {
            let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .light)
            self.init(systemName: name, withConfiguration: configuration)
        } else {
            self.init()
        }
    }
}
