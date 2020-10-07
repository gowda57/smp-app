//
//  LoginViewController.swift
//  SamplePartnerApp
//
//  Created by Gowtham Gowda TC on 07/10/20.
//  Copyright © 2020 ODCEM TECHNOLOGIES PRIVATE LIMITED. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var isPrechatRequired: Bool = true
    
    let loginTitle: UITextView = {
            let textView = UITextView()
    //        textView.text = "Raise Service Ticket"
            textView.isEditable = false
            return textView
        }()
    
    let textView: UITextView = {
        let textView = UITextView()
//        textView.layer.cornerRadius = 10.0
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.gray.cgColor
        return textView
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(
            self,
            action: #selector(submitButtonPressed),
            for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textView)
        view.addSubview(submitButton)
        view.addSubview(loginTitle)
        setupMsgField()
        setupSubmitButton()
        setupLoginTitle()
        
        self.hideKeyboardWhenTappedAround()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: #selector(onLogout))
        
        let switchTitle = UILabel(frame:CGRect(x: 0, y: 250, width: view.frame.width, height: 30))
        switchTitle.text = "Is prechat required?"
        switchTitle.textAlignment = .center
        self.view.addSubview(switchTitle)
        
        let switchDemo = UISwitch(frame:CGRect(x: 150, y: 300, width: 0, height: 0))
        switchDemo.isOn = true
        switchDemo.setOn(true, animated: false)
        switchDemo.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        self.view.addSubview(switchDemo)
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        
        if (sender.isOn == true){
            self.isPrechatRequired = true
        }
        else{
            self.isPrechatRequired = false
        }
    }
    
    @objc func onLogout() {
        print("logout")
    }
    
    @objc func submitButtonPressed(sender: UIButton!) {
        
        // store brandCustomerId in user defaults of partner app. while app is opened after removing from recent apps, in app delegate of partner app -> check if brandCustomerId == "". if so prompt login screen. else open launchviewcontroller.
        
        guard let text = textView.text else { return }
        
        if text == "" { return }
        
        UserDefaults.standard.setValue(text, forKey: "brandCustomerId")
        
        let vc = LaunchViewController(brandCustomerId: text, isPrechatRequired: self.isPrechatRequired)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupLoginTitle() {
        loginTitle.translatesAutoresizingMaskIntoConstraints = false //set this for Auto Layout to work!
        loginTitle.text = "Enter brand customer id"
        loginTitle.topAnchor.constraint(
            equalTo: view.topAnchor, constant: 40).isActive = true
        
        loginTitle.heightAnchor.constraint(
        equalToConstant: 40).isActive = true
        
        loginTitle.leftAnchor.constraint(
        equalTo: view.leftAnchor).isActive = true
        
        loginTitle.rightAnchor.constraint(
        equalTo: view.rightAnchor).isActive = true
        
        loginTitle.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
    }
    
    func setupMsgField(){
        textView.translatesAutoresizingMaskIntoConstraints = false //set this for Auto Layout to work!
        
        textView.topAnchor.constraint(
            equalTo: loginTitle.bottomAnchor, constant: 20).isActive = true
        
        textView.leftAnchor.constraint(
            equalTo: view.leftAnchor).isActive = true
//
        textView.rightAnchor.constraint(
            equalTo: view.rightAnchor).isActive = true
        
        textView.heightAnchor.constraint(
        equalToConstant: 40).isActive = true
        
        textView.becomeFirstResponder()
        
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func setupSubmitButton(){
        submitButton.translatesAutoresizingMaskIntoConstraints = false //set this for Auto Layout to work!
        
        submitButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        submitButton.heightAnchor.constraint(
        equalToConstant: 30).isActive = true
        
        submitButton.leftAnchor.constraint(
        equalTo: view.leftAnchor).isActive = true
        
        submitButton.rightAnchor.constraint(
        equalTo: view.rightAnchor).isActive = true
        
        submitButton.backgroundColor = .blue
        submitButton.setTitleColor(.white, for: .normal)
        
        submitButton.layer.cornerRadius = 10
    }
}

