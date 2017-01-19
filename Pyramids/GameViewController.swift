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
    let randomColor = arc4random_uniform(2) == 0 ? UIColor.red : UIColor.green
    geometry.materials.first?.diffuse.contents = randomColor
    
    // Adds geometry object to Scene
    let geometryNode = SCNNode(geometry: geometry)
    
    // Adds physics to Pyramid
    geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    
    if randomColor == UIColor.red {
      geometryNode.name = "Enemy"
    } else {
      geometryNode.name = "Friend"
    }
    
    
    gameScene.rootNode.addChildNode(geometryNode)
    
    let randomDirection: Float = arc4random_uniform(2) == 0 ? -1.0 : 1.0
    
    let force = SCNVector3(x: randomDirection, y: 15, z: 0)
    
    geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.05, y: 0.05, z: 0.05), asImpulse: true)
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

}
