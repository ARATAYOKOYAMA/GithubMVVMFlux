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
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.font = titleLabel.font.withSize(20)
            titleLabel.textColor = UIColor.blue
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = descriptionLabel.font.withSize(16)
            descriptionLabel.textColor = UIColor.gray
        }
    }
    @IBOutlet private weak var languageLabel: UILabel! {
        didSet {
            languageLabel.font = languageLabel.font.withSize(12)
            languageLabel.textColor = UIColor.gray
        }
    }
    @IBOutlet private weak var staraLabel: UILabel! {
        didSet {
            staraLabel.font = staraLabel.font.withSize(12)
            staraLabel.textColor = UIColor.gray
        }
    }
    @IBOutlet private weak var forksLabel: UILabel! {
        didSet {
            forksLabel.font = forksLabel.font.withSize(12)
            forksLabel.textColor = UIColor.gray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func seetupCell(ropository: TrendRepositoryElement) {
        titleLabel.text = L10n.TableCell.Trend.title(ropository.author, ropository.name)
        descriptionLabel.text = ropository.description
        languageLabel.text = ropository.language
        staraLabel.text = String(ropository.stars)
        forksLabel.text = String(ropository.forks)
    }

}
