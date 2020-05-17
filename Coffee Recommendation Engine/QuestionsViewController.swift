//
//  QuestionsViewController.swift
//  Coffee Recommendation Engine
//
//  Created by Karthik Venkatesh on 5/16/20.
//  Copyright © 2020 Karthik Venkatesh. All rights reserved.
//

import UIKit

struct Question {
    var question: String?
    var options: [String]?
}

class QuestionsViewController: UIViewController {

    @IBOutlet var questionCountLabel: UILabel!
    @IBOutlet var questionsLabel: UILabel!
    @IBOutlet var optionsCollectionView: UICollectionView!
    
    var currentQuestionIndex = 0
    let coffeeModel = CoffeeClassifier()
    var keywords = [String]()
    
    var productLinks = ["Grand Aroma" : URL(string: "https://pandurangacoffee.com/products/grand-aroma")!,
                        "Aroma Gold" : URL(string: "https://pandurangacoffee.com/products/aroma-gold")!,
                        "Brown Gold" : URL(string: "https://pandurangacoffee.com/products/brown-gold")!,
                        "French Blend" : URL(string: "https://pandurangacoffee.com/products/french-blend")!,
    ]
    
    var questions = [Question(question: "What roast levels do you enjoy?", options: ["Light Roast", "Dark Roast", "Medium Roast","I defer to you"]),
    Question(question: "How do you make you coffee?", options: ["French Press", "South Indian Filter", "Moka Pot"]),
    Question(question: "How do you like your coffee to taste?", options: ["Classic and Traditional","Hints of something different","Surprising"]),
    Question(question: "How do you like your coffee?", options: ["Medium","Strong"]),
    Question(question: "Do you buy ground coffee or whole beans?", options: ["Ground", "Whole Beans"]),
    Question(question: "Where do you intend to use the coffee?", options: ["Home","Restaurant","Catering"]),
    Question(question: "Which Altitude?", options: ["High", "Regular"])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestionCount()
        configureCollectionView()
        questionsLabel.text = questions[currentQuestionIndex].question
    }
    
    @IBAction func backTapped(_ sender: Any) {
        previousQuestion()
    }
    func configureCollectionView() {
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
    }
    
    func configureQuestionCount() {
        questionCountLabel.text = "\(currentQuestionIndex + 1) of \(questions.count)"
    }
    
    func previousQuestion() {
        if let _ = keywords.last {
            keywords.removeLast()
        }
        currentQuestionIndex -= 1
        configureQuestionAndOptions()
    }
    
    func configureQuestionAndOptions() {
        if questions.indices.contains(currentQuestionIndex) {
            questionsLabel.text = questions[currentQuestionIndex].question
            optionsCollectionView.reloadData()
            configureQuestionCount()
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        configureQuestionAndOptions()
    }
}

extension QuestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questions[currentQuestionIndex].options!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath) as? OptionCell else { return UICollectionViewCell()}
        
        let question =  questions[currentQuestionIndex]
        cell.configureOption(with: question.options![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        let keyword = questions[currentQuestionIndex].options![indexPath.item]
        keywords.append(keyword)
        
        if currentQuestionIndex == questions.count - 1 {
            let keywords = self.keywords.joined(separator: " ")
            
            getPrediction(for: keywords)
        }
        else {
            nextQuestion()
        }
 
    }
    
    func getPrediction(for keywords: String) {
        do {
            let prediction = try coffeeModel.prediction(text: keywords)
            
            // the property names are dependent up on the structure of the model
            print(prediction.label)
            
            let productLink = productLinks[prediction.label]
            UIApplication.shared.open(productLink!)
            
        } catch {
            print("Error on prediction")
        }
    }
}
