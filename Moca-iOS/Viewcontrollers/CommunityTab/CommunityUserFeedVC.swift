//
//  CommunityUserFeedVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 8..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit

class CommunityUserFeedVC: UIViewController {
    @IBOutlet weak var communityTableView: UITableView!
    
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiY29jbyIsImlzcyI6IkRvSVRTT1BUIn0.Rplge4ISuuCrFzrddjOl55TCeRQ2QUD9yuwSMmOZ5X0"
    var userId = "first"
    var user: CommunityUser? {
        didSet { communityTableView.reloadData() }
    }
    var reviews: [CommunityReview]? {
        didSet { communityTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        initUserData()
        initReviewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initUserData() {
        CommunityUserService.shareInstance.getUser(userId: userId, token: token, completion: { (res) in
            self.user = res
            self.title = res.userName
            print("유저 프로필 성공")
        }) { (err) in
            print(self.userId)
            print("유저 프로필 실패")
        }
    }
    
    private func initReviewData() {
        CommunityReviewService.shareInstance.getUserReview(userId: userId, token: token, completion: { (res) in
            self.reviews = res
            print("유저 피드 성공")
        }) { (err) in
            print(self.userId)
            self.reviews = []
            print("유저 피드 실패")
        }
    }
    
    private func setUpView() {
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    
    @IBAction func followerAction(_ sender: UIButton) {
        guard let user = user else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityFollowVC") as? CommunityFollowVC {
            vc.path = "follower"
            vc.userId = user.userID
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func followingAction(_ sender: UIButton) {
        guard let user = user else { return }
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityFollowVC") as? CommunityFollowVC {
            vc.path = "following"
            vc.userId = user.userID
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func profileButtonAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "CommunityTab", bundle: nil).instantiateViewController(withIdentifier: "CommunityReviewWrittingVC") as? CommunityReviewWrittingVC {
            self.present(vc, animated: true)
        }
    }
    
}

extension CommunityUserFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reviews = reviews, let _ = user else { return 0 }
        if section == 0 {
            return 1
        } else {
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let reviews = reviews, let user = user else { return cell }

        if indexPath.section == 0 {
            if let userCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityUserProfileCell") as? CommunityUserProfileCell {
                userCell.user = user
                cell = userCell
            }
        } else if indexPath.section == 1 {
            if let feedCell = communityTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                feedCell.review = reviews[indexPath.row]
                cell = feedCell
            }
        }
        
        return cell
    }
}
