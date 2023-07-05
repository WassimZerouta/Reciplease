//
//  NotFindViewController.swift
//  Reciplease
//
//  Created by Wass on 05/07/2023.
//

import UIKit

class NotFindViewController: UIViewController {
    
    

    @IBOutlet weak var alertMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Retour", style: .plain, target: self, action: #selector(backButtonTapped))

        // Assigner le bouton de retour à la propriété leftBarButtonItem
        navigationItem.leftBarButtonItem = backButton

    }
    
    @objc func backButtonTapped() {
        // Méthode appelée lorsque le bouton de retour est tapé
        // Vous pouvez y ajouter le code de traitement du retour
        // Par exemple, vous pouvez utiliser la méthode popViewController pour revenir à l'écran précédent dans une navigation contrôlée par UINavigationController
        navigationController?.popViewController(animated: true)
    }
   

}
