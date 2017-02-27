/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UIApplication {
    
    // MARK: - Private properties
    
    fileprivate static let mailURL = URL(string: "message://")!
    fileprivate static let composeURL = URL(string: UIApplication.composeURLScheme + ":")!
    fileprivate static let composeURLScheme = "mailto"

    
    /**
     Check for whether the Mail app can be opened.
     
     - returns: `True` if Mail can be opened; otherwise `false`
     */
    public static func canOpenMail() -> Bool {
        return UIApplication.shared.canOpenURL(UIApplication.mailURL)
    }
    
    /**
     Opens the Mail app without composing an email.
     */
    public static func openMail() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(mailURL)
        }
    }
    
    /**
     Check for whether an email can be composed.
     
     - returns: `True` if an email can be composed; otherwise `false`
     */
    public static func canComposeMail() -> Bool {
        return UIApplication.shared.canOpenURL(composeURL)
    }
    
    /**
     Starts composing an email by opening the default mail client, including any specified parameters
     
     - Parameters:
        - recipient: Optional email address of recipient
        - subject: Optional subject line for email
        - body: Optional body text for email
     */
    public static func composeMail(to recipient: String? = nil, subject: String? = nil, body: String? = nil) {
        var components = URLComponents()
        components.scheme = UIApplication.composeURLScheme
        components.host = recipient
        var queryItems = [URLQueryItem]()
        if let subject = subject {
            queryItems.append(URLQueryItem(name: "subject", value: subject))
        }
        if let body = body {
            queryItems.append(URLQueryItem(name: "body", value: body))
        }
        components.queryItems = queryItems
        guard let link = components.url else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(link)
        }
    }
    
}
