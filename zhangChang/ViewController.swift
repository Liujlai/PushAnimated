//
//  ViewController.swift
//  zhangChang
//
//  Created by idea on 2017/12/16.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController ,UINavigationControllerDelegate{

    var selectedCell: MCollectionViewCell!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.delegate = self
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push{
            return MoveTransion()
        }else{
            return nil
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "id" {
            let detailVC = segue.destination as! AViewController
            detailVC.image = self.selectedCell.imgView.image
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MCollectionViewCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCell = collectionView.cellForItem(at: indexPath) as! MCollectionViewCell
        self.performSegue(withIdentifier:"id", sender: nil)
    }

}

