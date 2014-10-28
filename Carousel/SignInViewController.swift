//
//  SignInViewController.swift
//  Carousel
//
//  Created by Andrew Lyons on 20 Oct 14.
//  Copyright (c) 2014 Andrew Lyons. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate
{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var formBackImage: UIImageView!
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signInButtonView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject)
    {
        navigationController!.popViewControllerAnimated(true)
    }

    func keyboardWillShow(notification: NSNotification!)
    {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations:
            {
                // Set view properties in here that you want to match with the animation of the keyboard
                // If you need it, you can use the kbSize property above to get the keyboard width and height.
                self.scrollView.contentOffset.y += self.textImage.frame.height
                self.signInButtonView.center.y -= kbSize.height
            }, completion: nil)
        
    }
    
    func keyboardWillHide(notification: NSNotification!)
    {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations:
        {
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
                self.scrollView.contentOffset.y -= self.textImage.frame.height
                self.signInButtonView.center.y += kbSize.height
        }, completion: nil)
        
    }
    
    @IBAction func onSignInButton(sender: AnyObject)
    {
        var alertView = UIAlertView(title: "Email Required", message: "Please enter your email address", delegate: self, cancelButtonTitle: "OK")
        var delayView = UIAlertView(title: "Signing in...", message: "", delegate: self, cancelButtonTitle: nil)
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if emailTextField.text == ""
        {
            alertView.show()
        } else if passwordTextField.text == ""
        {
            alertView.title = "Password Required"
            alertView.message = "Please enter your password"
            alertView.show()
        } else
        {
            // Display a loading alert for 2 seconds:
            delayView.show()
            delay(2)
            {
                delayView.dismissWithClickedButtonIndex(0, animated: false)
                if self.passwordTextField.text != "password"
                {
                    
                    alertView.title = "Sign-in Failed"
                    alertView.message = "Incorrect email or password"
                    alertView.show()
                } else
                {
                    self.performSegueWithIdentifier("tutorialSeque", sender: self)
                }
            }
        }
            
    }
    
    @IBAction func doScrollTap(sender: AnyObject)
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
