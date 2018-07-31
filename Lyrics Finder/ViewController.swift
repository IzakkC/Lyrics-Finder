//
//  ViewController.swift
//  Lyrics Finder
//
//  Created by Izakk Carrillo on 7/31/18.
//  Copyright © 2018 Izakk Carrillo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var lyricsTextField: UITextView!
    
    let baseURL = "https://api.lyrics.ovh/v1/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        artistNameTextField.resignFirstResponder()
        songNameTextField.resignFirstResponder()
        
        guard let artistName = artistNameTextField.text, artistName != "", let songTitle = songNameTextField.text, songTitle != "" else {
            return
        }
        artistNameTextField.text = ""
        songNameTextField.text = ""
        
        let artistNameURLComponent = artistName.replacingOccurrences(of: " ", with: "+")
        let songTitleURLComponent = songTitle.replacingOccurrences(of: " ", with: "+")
        
        let fullURL = baseURL + artistNameURLComponent + "/" + songTitleURLComponent
        
        
        Alamofire.request(fullURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.lyricsTextField.text = json["lyrics"].stringValue
            case .failure(let error):
                self.lyricsTextField.text = "Invalid selection entered ot an error occured. Please try again."
                print(error)
            }
        }
    }
}

