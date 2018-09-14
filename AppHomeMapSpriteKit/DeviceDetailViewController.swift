//
//  DeviceDetailViewController.swift
//  AppHomeMapSpriteKit
//
//  Created by Video on 13/09/18.
//  Copyright © 2018 EHE. All rights reserved.
//

import UIKit
import SpriteKit

class DeviceDetailViewController: UIViewController {
    
    var myDevice:DeviceRecord = DeviceRecord(name: "", place: "", description: "");
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var iconSKView: SKView!
    var node: SKSpriteNode?
    
    var scene = SKScene(size: CGSize(width: 400, height: 130))


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.text = myDevice.deviceName
        descTextView.text = myDevice.deviceDescription
        
        scene.backgroundColor = .white
        iconSKView.frame.size = scene.size
        

        var imgFound = false
        if myDevice.deviceName.range(of:"Light") != nil {
            let node = SKSpriteNode(imageNamed: "light.png")
            node.scale(to: CGSize(width: 130, height: 130))
            node.position.x = scene.size.width/2
            node.position.y = scene.size.height/2
            scene.addChild(node)
            imgFound = true
        }
        if myDevice.deviceName.range(of:"Cofee") != nil {
            let node = SKSpriteNode(imageNamed: "cofee.jpg")
            node.scale(to: CGSize(width: 130, height: 130))
            node.position.x = scene.size.width/2
            node.position.y = scene.size.height/2
            scene.addChild(node)
            imgFound = true
        }
        if myDevice.deviceName.range(of:"Modem") != nil {
            let node = SKSpriteNode(imageNamed: "modem.png")
            node.scale(to: CGSize(width: 130, height: 130))
            node.position.x = scene.size.width/2
            node.position.y = scene.size.height/2
            scene.addChild(node)
            imgFound = true
        }
        if myDevice.deviceName.range(of:"Fan") != nil {
            let node = SKSpriteNode(imageNamed: "fan.png")
            node.scale(to: CGSize(width: 130, height: 130))
            node.position.x = scene.size.width/2
            node.position.y = scene.size.height/2
            scene.addChild(node)
            imgFound = true
        }
        if !imgFound {
            let node = SKSpriteNode(imageNamed: "default.png")
            node.scale(to: CGSize(width: 130, height: 130))
            node.position.x = scene.size.width/2
            node.position.y = scene.size.height/2
            scene.addChild(node)
        }
        
        iconSKView.presentScene(scene)
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
    
    /*private lazy var animationView = SKView()
    
    override func loadView() {
        super.loadView()
        view.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make sure we don't recreate the scene when the view re-appears
        guard animationView.scene == nil else {
            return
        }
        
        let scene = makeScene()
        animationView.frame.size = scene.size
        animationView.presentScene(scene)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationView.center.x = view.bounds.midX
        animationView.center.y = view.bounds.midY
    }*/

}
