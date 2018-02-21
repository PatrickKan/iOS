//
//  HIDateHeader.swift
//  HackIllinois
//
//  Created by Rauhul Varma on 11/22/17.
//  Copyright © 2017 HackIllinois. All rights reserved.
//

import Foundation
import UIKit

class HIDateHeader: UITableViewHeaderFooterView {
    var titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let backgroundView = HIView(style: .background)
        self.backgroundView = backgroundView

        titleLabel.backgroundColor = HIApplication.Color.paleBlue
        titleLabel.textColor = HIApplication.Color.darkIndigo
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: 14).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor, constant: -14).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used.")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
