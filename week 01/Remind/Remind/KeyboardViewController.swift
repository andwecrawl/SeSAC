//
//  KeyboardViewController.swift
//  Remind
//
//  Created by yeoni on 2023/07/20.
//

import UIKit

class KeyboardViewController: UIViewController {

    
    @IBOutlet weak var newButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // apple system button
        var config = UIButton.Configuration.filled()
        
        //  button에 display되는 큰 제목과 subtitle
        config.title = "hello!"
        config.subtitle = "My name is..."
        
        // 이외 여러가지....
        config.image = UIImage(systemName: "pencil")
        // newButton.backgroundColor = .blue
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .yellow
        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.titleAlignment = .trailing
        
        config.cornerStyle = .capsule
        newButton.configuration = config
        
        
    }
    
    
    // Any
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
