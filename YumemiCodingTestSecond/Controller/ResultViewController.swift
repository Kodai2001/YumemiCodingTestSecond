//
//  ResultViewViewController.swift
//  YumemiCodingTest
//
//  Created by system on 2021/10/25.
//

import UIKit

class ResultViewController: UIViewController {
    
    let vc = ViewController()
    var indexPathRow: Int = 0
    var items: [Repository.Item] = []
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.tintColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.text = "languageLabel"
        label.numberOfLines = 2
        label.tintColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.text = "starsLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let watchersLabel: UILabel = {
        let label = UILabel()
        label.text = "watchersLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.text = "forksLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.text = "issuesLabel"
        label.tintColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // getText()
        getImage()
        addSubviews()
    }
    
    // ?????????????????????????????????????????????
    private func getText() {
        let item = items[indexPathRow]
        languageLabel.text = "Written in \(item.language ?? "")"
        starsLabel.text = "\(item.starsCount ?? 0) stars"
        watchersLabel.text = "\(item.watchersCount ?? 0) watchers"
        forksLabel.text = "\(item.forksCount ?? 0) forks"
        issuesLabel.text = "\(item.openIssuesCount ?? 0) open issues"
    }
    
    // imageView???????????????
    private func getImage() {
        let item = items[indexPathRow]
        titleLabel.text = item.fullName ?? ""
        
        if let owner = item.owner {
            if let imgURL = owner.avatarUrl {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }.resume()
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(languageLabel)
        view.addSubview(starsLabel)
        view.addSubview(watchersLabel)
        view.addSubview(forksLabel)
        view.addSubview(issuesLabel)
    }
    
    override func viewDidLayoutSubviews() {
        
        let widthSize = (view.frame.size.width)/2.0
        imageView.frame = CGRect(x: widthSize-widthSize/2.0,
                                 y: view.safeAreaInsets.top+100,
                                 width: widthSize,
                                 height: widthSize)
        
        titleLabel.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top+widthSize+130,
                                  width: view.frame.size.width,
                                  height: 60)
        
        languageLabel.frame = CGRect(x: 20,
                                     y: view.safeAreaInsets.top+widthSize+200,
                                     width: widthSize,
                                     height: 60)
        
        starsLabel.frame = CGRect(x: widthSize,
                                  y: view.safeAreaInsets.top+widthSize+200,
                                  width: widthSize-10,
                                  height: 30)
        
        watchersLabel.frame = CGRect(x: widthSize,
                                     y: view.safeAreaInsets.top+widthSize+250,
                                     width: widthSize-10,
                                     height: 30)
        
        forksLabel.frame = CGRect(x: widthSize,
                                  y: view.safeAreaInsets.top+widthSize+300,
                                  width: widthSize-10,
                                  height: 30)
        
        issuesLabel.frame = CGRect(x: widthSize,
                                   y: view.safeAreaInsets.top+widthSize+350,
                                   width: widthSize-10,
                                   height: 30)
    }
}
