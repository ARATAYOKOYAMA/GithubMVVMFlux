//
//  TrendTableViewCell.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit

final class TrendTableViewCell: UITableViewCell {

    @IBOutlet private weak var backView: UIView! {
        didSet {
            backView.backgroundColor = UIColor.white
            backView.layer.borderColor = UIColor.black.cgColor
            backView.layer.borderWidth = 1
        }
    }
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var staraLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func seetupCell(ropository: TrendRepositoryElement) {
        authorLabel.text = ropository.author
        nameLabel.text = ropository.name
        descriptionLabel.text = ropository.description
        languageLabel.text = ropository.language
        staraLabel.text = String(ropository.stars)
        forksLabel.text = String(ropository.forks)
    }

}
