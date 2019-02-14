//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Mustafa Muhammad on 2/14/19.
//  Copyright © 2019 Ara Tech. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Vars
    var selectedMeme:Meme?
    
    //Outlets
    @IBOutlet weak var memeTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.memeTableView.reloadData()
    }
    

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMemeEditor"{
            if  segue.destination is MemeViewController{
                (segue.destination as! MemeViewController).meme = self.selectedMeme
            }
        }
    }
 
    
    //MARK: Table View Delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.selectedMeme = MemesManager().getMemes()[indexPath.row]
        performSegue(withIdentifier: "openMemeEditor", sender: self)
    }

    
    //MARK: Table View Datasource
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = memeTableView.dequeueReusableCell(withIdentifier: "memeTableImage") as? MemeTableViewCell
        if let cell = cell{
        let meme = MemesManager().getMemes()[indexPath.row]
            cell.bindData(meme: meme)
            return cell
        }
        return UITableViewCell()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return MemesManager().getMemes().count
    }
    
    @IBAction func addMemeButtonPressed(_ sender: Any) {
        self.selectedMeme = nil
        performSegue(withIdentifier: "openMemeEditor", sender: self)
    }
    
    
}
