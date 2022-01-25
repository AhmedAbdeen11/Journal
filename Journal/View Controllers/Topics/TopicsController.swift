//
//  TopicsController.swift
//  Journal
//
//  Created by Abdeen on 1/14/22.
//

import UIKit
import RxSwift
import MaterialComponents
import SDWebImage

class TopicsController: UIViewController {

    // MARK: - View Model
    
    // MARK: - Properties
    
    @IBOutlet weak var viewClose: UIView!
    
    @IBOutlet weak var labelJournalTitle: UILabel!
    
    @IBOutlet weak var labelJournalSubtitle: UILabel!
    
    @IBOutlet weak var collectionViewTopics: UICollectionView!
    
    @IBOutlet weak var subViewContainer: UIView!
    
    // MARK: - Variables
    
    var journal: Journal!
    
    var journalPageController: JournalPageController!
    
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        setData()
    }
    
    private func initViews(){
        viewClose.layer.cornerRadius = 25
        viewClose.addShadow()
    }
    
    private func setData(){
        labelJournalTitle.text = journal.title
        labelJournalSubtitle.text = "(\(journal.subtitle!))"
    }

    // MARK: - Actions
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

     // MARK: - Navigation

     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showTopicQuoteSegue" {
             let topicQuoteController = segue.destination as! TopicQuoteController
            topicQuoteController.topic = sender as? Topic
            topicQuoteController.journalPageController = self.journalPageController
            topicQuoteController.topicsController = self
         }
     }
     

}

//MARK: - Extensions


extension TopicsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return journal.topics!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionViewTopics.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        
        let topic = journal.topics![indexPath.item]
        
        cell.image.sd_setImage(with: URL(string: topic.image ?? ""), placeholderImage: UIImage(named: ""))
        
        cell.title.text = topic.title
        
        if topic.subtitle != nil && !topic.subtitle!.isEmpty {
        
            cell.subTitle.text = "(\(topic.subtitle!))"
            cell.subTitle.isHidden = false
            
        }else{
            cell.subTitle.text = topic.subtitle
            cell.subTitle.isHidden = true
        }
        
        
        cell.containerView.addBorder(color: UIColor(rgb: 0xBFCDDB), width: 1, cornerRadius: 10)
        cell.containerView.addShadow()
        
        cell.subView.layer.cornerRadius = 10
        
        cell.backgroundColor = .clear
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showTopicQuoteSegue", sender: journal.topics![indexPath.row])
        
    }
    
    //To make this work. You have to make Estimate size = none for collection view in storyboard
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = 225
        
        if indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.size.width, height: CGFloat(height))
        }else{
            return CGSize(width: (collectionView.bounds.size.width / 2) - 10, height: CGFloat(height))
        }
        
    }
    
}
