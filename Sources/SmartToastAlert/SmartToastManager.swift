//
//  SmartToastManager.swift
//
//  Created by Osinnowo Emmanuel on 05/09/2023.
//

import UIKit

public class SmartToastManager {
    public static let shared = SmartToastManager()
    private var toastQueue: [SmartToastAlert] = []
    private var isShowingToast = false

    private init() {}

    func showToast(with title: String, type: SmartToastType, position: SmartToastPosition) {
        let toast = SmartToastAlert(title: title, type: type)
        toast.alpha = 0.0
        
        var initialFrame: CGRect
        var finalFrame: CGRect
        
        switch position {
            case .top:
                initialFrame = CGRect(x: 0, y: -toast.frame.height, width: UIScreen.main.bounds.width, height: toast.frame.height)
                finalFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: toast.frame.height)
            case .bottom:
                initialFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: toast.frame.height)
                finalFrame = CGRect(x: 0, y: UIScreen.main.bounds.height - toast.frame.height, width: UIScreen.main.bounds.width, height: toast.frame.height)
            case .left:
                initialFrame = CGRect(x: -toast.frame.width, y: 0, width: toast.frame.width, height: UIScreen.main.bounds.height)
                finalFrame = CGRect(x: 0, y: 0, width: toast.frame.width, height: UIScreen.main.bounds.height)
            case .right:
                initialFrame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: toast.frame.width, height: UIScreen.main.bounds.height)
                finalFrame = CGRect(x: UIScreen.main.bounds.width - toast.frame.width, y: 0, width: toast.frame.width, height: UIScreen.main.bounds.height)
        }
        
        toast.frame = initialFrame
        
        toastQueue.append(toast)
        
        if !isShowingToast {
            showNextToast()
        }
    }

    private func showNextToast() {
        guard let toast = toastQueue.first else { return }
        
        isShowingToast = true
        UIApplication.shared.keyWindow?.addSubview(toast)
        
        UIView.animate(withDuration: 0.5, animations: {
            toast.alpha = 1.0
            toast.frame = toast.finalFrame
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.hideToast(toast)
            }
        })
    }

    private func hideToast(_ toast: SmartToastAlert) {
        UIView.animate(withDuration: 0.5, animations: {
            toast.alpha = 0.0
            toast.frame = toast.initialFrame
        }, completion: { _ in
            toast.removeFromSuperview()
            self.toastQueue.removeFirst()
            self.isShowingToast = false

            if !self.toastQueue.isEmpty {
                self.showNextToast()
            }
        })
    }
}
