//
//  ScreenRecordingGuardian.swift
//  PreventScreenShot
//
//  Created by Daniel Bonates on 10/02/23.
//

import UIKit

final class ScreenRecordingGuardian: NSObject {
    
    static var shared: ScreenRecordingGuardian = ScreenRecordingGuardian()
    
    public func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(preventRecord), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc func preventRecord() {
        guard UIScreen.main.isCaptured else {
            print("is not recording...")
            clearWarningScreen()
            return
        }

        showWarningScreen()

        UIViewController.delay(7) {
            fatalError()
        }
    }
    
    func showWarningScreen() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("no window!")
        }

        let warningView = UIView(frame: window.frame)
        warningView.backgroundColor = .red
        warningView.tag = 1234;

        let lblWarining = UILabel(frame: .zero)
        lblWarining.textColor = .white
        lblWarining.font = .boldSystemFont(ofSize: 32)
        lblWarining.lineBreakMode = .byWordWrapping
        lblWarining.textAlignment = .center
        lblWarining.numberOfLines = 0
        lblWarining.text = "Copying training videos is not allowed.\n\nThis incident is being reported on the platform."
        lblWarining.translatesAutoresizingMaskIntoConstraints = false
        warningView.addSubview(lblWarining)

        let constant: CGFloat = 30
        NSLayoutConstraint.activate([
            lblWarining.topAnchor.constraint(equalTo: warningView.topAnchor, constant: constant),
            lblWarining.leftAnchor.constraint(equalTo: warningView.leftAnchor, constant: constant),
            lblWarining.bottomAnchor.constraint(equalTo: warningView.bottomAnchor, constant: -constant),
            lblWarining.rightAnchor.constraint(equalTo: warningView.rightAnchor, constant: -constant)
            ])

        window.addSubview(warningView)
    }
    
    func clearWarningScreen() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("no window!")
        }
        
        guard let warningView = window.subviews.first( where: { $0.tag == 1234 }) else { return }
        warningView.removeFromSuperview()
        
    }
}

extension UIViewController {
    static func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
