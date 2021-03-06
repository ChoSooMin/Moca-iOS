//
//  CommunityContentCell.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class CommunityContentCell: UITableViewCell {
    var review: CommunityReview? {
        didSet { setUpData() }
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpData() {
        guard let review = review else { return }
//        nameLabel.text = review.
        contentLabel.text = review.reviewContent
        timeLabel.text = review.time
    }
    
    private func setUpView() {
        profileImageView.applyRadius(radius: 20)
    }

}
