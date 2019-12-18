//
//  TrendTableViewCell.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import SkeletonView

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
            titleLabel.isSkeletonable = true
            titleLabel.showAnimatedGradientSkeleton()
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = descriptionLabel.font.withSize(16)
            descriptionLabel.textColor = UIColor.gray
            descriptionLabel.text = "samplesamplesamplesamplesamplesamplesample"
            descriptionLabel.isSkeletonable = true
            descriptionLabel.showAnimatedGradientSkeleton()
        }
    }
    @IBOutlet private weak var languageLabel: UILabel! {
        didSet {
            languageLabel.font = languageLabel.font.withSize(12)
            languageLabel.textColor = UIColor.gray
            languageLabel.isSkeletonable = true
            languageLabel.showAnimatedGradientSkeleton()
        }
    }
    @IBOutlet private weak var staraLabel: UILabel! {
        didSet {
            staraLabel.font = staraLabel.font.withSize(12)
            staraLabel.textColor = UIColor.gray
            staraLabel.isSkeletonable = true
            staraLabel.showAnimatedGradientSkeleton()
        }
    }
    @IBOutlet private weak var forksLabel: UILabel! {
        didSet {
            forksLabel.font = forksLabel.font.withSize(12)
            forksLabel.textColor = UIColor.gray
            forksLabel.isSkeletonable = true
            forksLabel.showAnimatedGradientSkeleton()
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

        titleLabel.hideSkeleton()
        descriptionLabel.hideSkeleton()
        languageLabel.hideSkeleton()
        staraLabel.hideSkeleton()
        forksLabel.hideSkeleton()

        titleLabel.text = L10n.TableCell.Trend.title(ropository.author, ropository.name)
        descriptionLabel.text = ropository.description
        languageLabel.text = ropository.language
        staraLabel.text = String(ropository.stars)
        forksLabel.text = String(ropository.forks)
    }

}
