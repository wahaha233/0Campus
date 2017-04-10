//
//  ReviewViewController.swift
//  tableviewcontrol
//
//  Created by GeorgeMao on 2017/3/26.
//  Copyright © 2017年 GeorgeMao. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var rating:String?
    

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    @IBAction func buttonTap(_ sender: UIButton) {
        switch sender.tag{
        case 0: rating = "frown60"
        case 1: rating = "blah60"
        case 2: rating = "bigsmile60"
        default: break
        }
        performSegue(withIdentifier: "unwindtoDetail", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = view.frame
        bgImageView.addSubview(effectView)
        
        let startPos = CGAffineTransform(translationX: 0, y: 500)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)

        ratingStackView.transform = startScale.concatenating(startPos)
        
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
 
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            
            let endPos = CGAffineTransform(translationX: 0, y: 0)
            let endScale = CGAffineTransform.identity
            self.ratingStackView.transform = endScale.concatenating(endPos)
            
        }, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
