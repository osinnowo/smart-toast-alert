//
//  SmartToastType
//  SmartToastAlert
//
//  Created by Osinnowo Emmanuel on 05/09/2023.
//

import UIKit

public enum SmartToastType {
    case success, danger, warning
}

public class SmartToastAlert: UIView {
    private let titleLabel: UILabel
    private let toastType: SmartToastType
    
    var finalFrame: CGRect = .zero
    var initialFrame: CGRect = .zero

    public init(title: String, type: SmartToastType) {
        self.titleLabel = UILabel()
        self.toastType = type
        super.init(frame: .zero)
        
        setupUI()
        configure(with: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        switch toastType {
            case .success:
                backgroundColor = UIColor.green
            case .danger:
                backgroundColor = UIColor.red
            case .warning:
                backgroundColor = UIColor.yellow
        }
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    private func configure(with title: String) {
        titleLabel.text = title
    }
    
    func setFrames(initial: CGRect, final: CGRect) {
        self.initialFrame = initial
        self.finalFrame = final
        frame = initialFrame
    }
}


