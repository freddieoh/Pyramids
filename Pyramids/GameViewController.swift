//
//  GameViewController.swift
//  Pyramids
//
//  Created by Fredrick Ohen on 1/16/17.
//  Copyright © 2017 geeoku. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

  var gameView: SCNView!
  var gameScene: SCNScene!
  var cameraNode: SCNNode!
  var targetCreationTime: TimeInterval = 0
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    initView()
    initScene()
    initCamera()
    createTarget()
      
    }

  func initView() {
    gameView = self.view as! SCNView
    gameView.allowsCameraControl = true
    gameView.autoenablesDefaultLighting = true

  }
  
  func initScene(){
    gameScene = SCNScene()
    gameView.scene = gameScene
    gameView.isPlaying = true
  }
  
  func initCamera(){
    cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
  }

  // Creates red pyramid
  func createTarget(){
    
    let geometry: SCNGeometry = SCNPyramid(width: 1, height: 1, length: 1)
    geometry.materials.first?.diffuse.contents = UIColor.red
    let geometryNode = SCNNode(geometry: geometry)
    gameScene.rootNode.addChildNode(geometryNode)
  }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
