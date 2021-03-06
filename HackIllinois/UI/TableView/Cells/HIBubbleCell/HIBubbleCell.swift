//
//  HIBubbleCell.swift
//  HackIllinois
//
//  Created by Rauhul Varma on 2/21/18.
//  Copyright © 2018 HackIllinois. All rights reserved.
//  This file is part of the Hackillinois iOS App.
//  The Hackillinois iOS App is open source software, released under the University of
//  Illinois/NCSA Open Source License. You should have received a copy of
//  this license in a file with the distribution.
//

import Foundation
import UIKit

class HIBubbleCell: UITableViewCell {
    // MARK: - Properties
    var defaultColor: UIColor {
        return HIApplication.Palette.current.contentBackground
    }

    var activeColor: UIColor {
        return HIApplication.Palette.current.actionBackground
    }

    var animator: UIViewPropertyAnimator?

    var bubbleView = HIView(style: .content)

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        addSubview(bubbleView)
        bubbleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true

        NotificationCenter.default.addObserver(self, selector: #selector(refreshForThemeChange), name: .themeDidChange, object: nil)
        refreshForThemeChange()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be used.")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Themeable
    @objc func refreshForThemeChange() {
        contentView.backgroundColor = HIApplication.Palette.current.background
    }

    // MARK: - UITableViewCell
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setActive(highlighted)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        setActive(selected)
    }

    func setActive(_ active: Bool) {
        let finalColor = active ? activeColor : defaultColor
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear)
        animator?.addAnimations { [weak self] in
            self?.bubbleView.backgroundColor = finalColor
        }
        animator?.startAnimation()
    }
}
