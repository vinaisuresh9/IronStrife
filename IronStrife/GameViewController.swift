//
//  GameViewController.swift
//  IronStrife
//
//  Created by Vinai Suresh on 6/18/14.
//  Copyright (c) 2014 Vinai Suresh. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        
        let path = Bundle.main.path(forResource: file as String, ofType: "sks")
        var sceneData: Data?
        do {
            sceneData = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        } catch _ {
            sceneData = nil
        }
        let archiver = NSKeyedUnarchiver(forReadingWith: sceneData!)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
        archiver.finishDecoding()
        return scene
    }
    
    func updateWithTimeSinceLastUpdate(_ timeSince: TimeInterval){}
}

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        SKTextureAtlas.preloadTextureAtlases(Textures.allTextureAtlases, withCompletionHandler: {[weak self] () -> Void in
            SKTexture.preload(Textures.allTextures, withCompletionHandler: { () -> Void in
                guard let strongSelf = self else { return }
                if let scene = TownScene.unarchiveFromFile("TownScene") as? TownScene {
                    // Configure the view.
                    let skView = strongSelf.view as! SKView
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = true
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .aspectFill
                    
                    skView.presentScene(scene)
                    
                    PlayerOverviewManager.sharedInstance.currentScene = scene
                    
                }
            })
        })
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    func transitionScenes(){
        
    }
    
}
