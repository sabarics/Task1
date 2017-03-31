//
//  ViewController.swift
//  Task1
//
//  Created by Sabari on 3/31/17.
//  Copyright © 2017 Sabari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var stepTitle: UILabel!
    @IBOutlet weak var stepDescription: UILabel!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var calenderCollection1: UICollectionView!
    @IBOutlet weak var CallenderCollection: UICollectionView!
    var urlString = Url()
    var session = URLSession()
    var task = URLSessionDataTask()
    var jsonCollection1Data = NSDictionary()
    var jsonCollection2Data = NSDictionary()
    var getArrayjson1 = NSArray()
    var getArrayjson2 = NSArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        session = URLSession.shared
        //set corner radius and border for button
        ShareButton.layer.cornerRadius = 5
        ShareButton.layer.masksToBounds = true
        ShareButton.layer.borderColor = UIColor.lightGray.cgColor
        ShareButton.layer.borderWidth = 1
        self.getCollection1Data()
        self.getCollection2Data()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == CallenderCollection)
        {
            return getArrayjson1.count
        }
        if(collectionView == calenderCollection1)
        {
            return getArrayjson2.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        if(collectionView == CallenderCollection)
        {
            if(indexPath.row % 2 == 0)
            {
                let cell1 = self.CallenderCollection.dequeueReusableCell(withReuseIdentifier: "Calendercell1", for: indexPath) as! CalenderCollectionViewCell1
                cell1.dayTextWord.text = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "DayText") as? String
                cell1.dayTextNum.text = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "DayNum") as? String
                let imageName = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "ImgName") as? String
                cell1.img.image = UIImage(named: imageName!)
                cell1.countTextNum.text = (self.getArrayjson1[indexPath.row] as AnyObject).value(forKey: "Value") as? String
                return cell1
            }
            else
            {
                let cell2 = self.CallenderCollection.dequeueReusableCell(withReuseIdentifier: "Calendercell2", for: indexPath) as! CalenderCollectionViewCell2
                
                cell2.dayTextWord.text = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "DayText") as? String
                cell2.dayTextNum.text = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "DayNum") as? String
                let imageName = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "ImgName") as? String
                cell2.img.image = UIImage(named: imageName!)
                cell2.countTextNum.text = (self.getArrayjson1[indexPath.item] as AnyObject).value(forKey: "Value") as? String
                
                
                return cell2
            }
        }
        if(collectionView == calenderCollection1)
        {
            let cell3 = self.calenderCollection1.dequeueReusableCell(withReuseIdentifier: "Calendercell3", for: indexPath) as! CallenderCollectionViewCell3
            cell3.layer.cornerRadius = 5
            cell3.layer.masksToBounds = true
            
            cell3.titleText.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Title") as? String
            cell3.descriptionText.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Description") as? String
            let imageName = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "Image") as? String
            
            cell3.mainImage.image = UIImage(named: imageName!)
            return cell3
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == calenderCollection1)
        {
            let cell3 = self.calenderCollection1.dequeueReusableCell(withReuseIdentifier: "Calendercell3", for: indexPath) as! CallenderCollectionViewCell3
            cell3.contentView.backgroundColor = UIColor.white
            stepTitle.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "StepTotal") as? String
            stepDescription.text = (self.getArrayjson2[indexPath.item] as AnyObject).value(forKey: "StepDescription") as? String
            
        }
    }
    func getCollection1Data()
    {
        
        let urlValue = URL(string: urlString.collectionUrl)!
        task = session.dataTask(with: urlValue, completionHandler: {(data, response, error)in
            
            if(error != nil)
            {
                print(error!.localizedDescription)
            }
            else
            {
                do
                {
                    self.jsonCollection1Data = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.getArrayjson1 = self.jsonCollection1Data.value(forKey: "Collection1") as! NSArray
                    DispatchQueue.main.async {
                        self.CallenderCollection.reloadData()
                    }
                    
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }
        })
        task.resume()
    }
    func getCollection2Data()
    {
        
        let urlValue = URL(string: urlString.collectionUrl2)!
        task = session.dataTask(with: urlValue, completionHandler: {(data, response, error)in
            
            if(error != nil)
            {
                print(error!.localizedDescription)
            }
            else
            {
                do
                {
                    self.jsonCollection2Data = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    self.getArrayjson2 = self.jsonCollection2Data.value(forKey: "Collection2") as! NSArray
                    DispatchQueue.main.async {
                        self.calenderCollection1.reloadData()
                    }
                    
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }
        })
        task.resume()
    }
    
    
}

