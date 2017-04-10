//
//  AreaTableViewController.swift
//  tableviewcontrol
//
//  Created by GeorgeMao on 2017/3/21.
//  Copyright © 2017年 GeorgeMao. All rights reserved.
//

import UIKit
import CoreData


class AreaTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    var areas:[AreaMO] = [
    ]
    
    var fc: NSFetchedResultsController<AreaMO>!
    
    var sc:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchAnimation()
        
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        tableView.tableHeaderView = sc.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchAllData2()
        
    }
    
    private func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
        /*
        fetchAllData()
        tableView.reloadData()
        */
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
            
        default:
            tableView.reloadData()
        }
        
        if let object = controller.fetchedObjects{
            areas = object as! [AreaMO]
        }
    }
    
    
    func fetchAllData2() {
        let request: NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        let sd = NSSortDescriptor(key:"name",ascending:true)
        request.sortDescriptors = [sd]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        do{
            try fc.performFetch()
            if let objects = fc.fetchedObjects{
                areas = objects
            }
        }catch{
            print(error)
        }
        
    }
    
  /*
    func fetchAllData() {
        let appDelagate = UIApplication.shared.delegate as! AppDelegate
        
        do{
            areas = try appDelagate.persistentContainer.viewContext.fetch(AreaMO.fetchRequest())
            
        } catch {
            print(error)
        }
    }
    
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view delegate
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    print("你点击了",indexPath.section,"组",indexPath.row,"行")
        let menu = UIAlertController(title:"非礼啊",message:"你戳了第\(indexPath.row)行",preferredStyle:.actionSheet)
        let option = UIAlertAction(title: "取消", style: .cancel) { (_) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            
        }

        let option1 = UIAlertAction(title: "我去过", style: .default) { (_) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.areas[indexPath.row].visited = true
            
        }
 
        menu.addAction(option)
        menu.addAction(option1)
        
        self.present(menu, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    */
    
    
    // MARK: - Table view data source
 


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        // Configure the cell...
        cell.namelabel.text = areas[indexPath.row].name
        cell.thumbimageview.image = UIImage(data: areas[indexPath.row].areasimage as! Data)
        cell.provincelabel.text = areas[indexPath.row].province
        cell.partlabel.text = areas[indexPath.row].part
        cell.thumbimageview.layer.cornerRadius = cell.thumbimageview.frame.size.width/2
        cell.thumbimageview.clipsToBounds = true
        
        if areas[indexPath.row].visited{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
         } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   */
    
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionshare = UITableViewRowAction(style: .normal, title: "分享") { (_, indexPath) in
            let actionsheet = UIAlertController(title: "分享", message: nil, preferredStyle: .actionSheet)
            let option1 = UIAlertAction(title: "QQ ", style: .default, handler: nil)
            let option2 = UIAlertAction(title: "微信", style: .default, handler: nil)
            let option3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            actionsheet.addAction(option1)
            actionsheet.addAction(option2)
            actionsheet.addAction(option3)
            
            self.present(actionsheet, animated: true, completion: nil)
        }
        
        actionshare.backgroundColor = UIColor.orange
        
        let actiondel = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
           
        //    self.areas.remove(at: indexPath.row)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let contex = appDelegate.persistentContainer.viewContext
            
            contex.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
 
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)

        }
        
        let actiontop = UITableViewRowAction(style: .default, title: "置顶") { (_,_) in

        }
        
        actiontop.backgroundColor = UIColor.blue
        
        return[actiondel,actionshare,actiontop]
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAreaDetail" {
            let dest = segue.destination as! DetailTableViewController
            dest.area = areas[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    

}
