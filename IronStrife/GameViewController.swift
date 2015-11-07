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
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks")
        var sceneData: NSData?
        do {
            sceneData = try NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
        } catch _ {
            sceneData = nil
        }
        let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! SKNode
        archiver.finishDecoding()
        return scene
    }
    
    func updateWithTimeSinceLastUpdate(timeSince: NSTimeInterval){}
}

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        SKTextureAtlas.preloadTextureAtlases(Textures.allTextureAtlases, withCompletionHandler: { () -> Void in
            SKTexture.preloadTextures(Textures.allTextures, withCompletionHandler: { () -> Void in
                if let scene = TownScene.unarchiveFromFile("TownScene") as? TownScene {
                    // Configure the view.
                    let skView = self.view as! SKView
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = true
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .AspectFill
                    
                    skView.presentScene(scene)
                    
                    PlayerOverviewManager.sharedInstance.currentScene = scene
                    
                }
            })
        })
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    func transitionScenes(){
        
    }
    
}
