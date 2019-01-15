//
//  StartViewController.swift
//  AssignmentApp
//
//  Created by Dawid  on 21/02/2018.
//  Copyright © 2018 Dawid Bazan. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var textPostcode: UITextField!
    @IBOutlet weak var textName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textPostcode.delegate = self
        textName.delegate = self
        textPostcode.isHidden = true
        textName.isHidden = true
        
    }

    @IBAction func toggle(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            textPostcode.isHidden = true
            textName.isHidden = true
        }
        
        if sender.selectedSegmentIndex == 1 {
            textPostcode.isHidden = false
            textName.isHidden = true
        }
        
        if sender.selectedSegmentIndex == 2 {
            textPostcode.isHidden = true
            textName.isHidden = false
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
       performSegue(withIdentifier: "secondView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if let destination = segue.destination as? ViewController {
            destination.passPostcode = (textPostcode.text?.uppercased())!
            destination.passName = textName.text!
            
        }
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextFielf(textField: textPostcode, moveDistance: -70, up: true)
        moveTextFielf(textField: textName, moveDistance: -70, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextFielf(textField: textPostcode, moveDistance: -70, up: false)
        moveTextFielf(textField: textName, moveDistance: -70, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextFielf(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.4
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx:0, dy: movement)
        UIView.commitAnimations()
    }

}
