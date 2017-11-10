/************************************************************************************************************************************/
/** @file		ViewController.swift
 *  @project    0_1 - Table (resizing)
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	4/14/16
 * 	@last rev	x
 *
 *  @section    Request
 *
 *              Hi Justin,
 *               I would like to dynamically size a UITableView based on how many rows are needed (the table should scale between 1
 *              to 4 rows).
 *
 *               I do a lot of work in storyboard (bad choice, I know) but this is most likely something that needs to be done
 *              programmatically.
 *
 *               I first tried setting the height of the table frame in viewWillAppear, but that didn't alter the height at all. The 
 *              next thing I was going to try was updating the constraints, as shown in the UIView Class Reference:Triggering Auto
 *              Layout Section
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 			none current
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @objc let rowHeight   : CGFloat = 75;
    
    @objc var numRows     : Int = 1;          //changes with button interactions
    @objc var titleBar    : UILabel!;
    
    @objc var addButton   : UIButton!;        //upper button to add a row
    @objc var remButton   : UIButton!;        //upper button to remove a row
    
    @objc var tableView   : UITableView!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;
        
        self.init_ui();
        self.init_table();
        
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    /********************************************************************************************************************************/
    /**	@fcn		init_ui()
     *  @brief		initialize a fresh UI onto a blank UIView
     *  @details	generate the title bar, buttons & table
     *
     *  @section	Opens
     *  	x
     *
     *	@section	Todo
     *		x
     */
    /********************************************************************************************************************************/
    @objc func init_ui() {
        
        /****************************************************************************************************************************/
        /*															TITLEBAR                                                        */
        /****************************************************************************************************************************/
        self.titleBar = UILabel(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 40));
        
        self.titleBar.text = "Adjustable Table";
        self.titleBar.textAlignment = .center;
        self.titleBar.backgroundColor = UIColor.white;

        self.view.addSubview(self.titleBar);
        
        //fill
        let upperEww = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20));
        upperEww.backgroundColor = UIColor.white;
        self.view.addSubview(upperEww);

        //border
        let titleBarBottBorder = UIView(frame: CGRect(x: 0, y: 60-1, width: UIScreen.main.bounds.width, height: 1));
        titleBarBottBorder.backgroundColor = UIColor.gray;
        self.view.addSubview(titleBarBottBorder);

        
        /****************************************************************************************************************************/
        /*															ADD                                                             */
        /****************************************************************************************************************************/
        self.addButton = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width-30), y: 26, width: 20, height: 30));
        
        self.addButton.setTitle("+", for:  UIControlState());
        
        self.addButton.setTitleColor(UIColor.red, for: UIControlState());
        
        self.addButton.titleLabel!.font =  self.addButton.titleLabel!.font.withSize(30);
        
        self.addButton.addTarget(self, action: #selector(ViewController.addRow(_:)), for:  .touchUpInside);
        
        self.view.addSubview(self.addButton);
        
        
        /****************************************************************************************************************************/
        /*												   		   REMOVE                                                           */
        /****************************************************************************************************************************/
        self.remButton = UIButton(frame: CGRect(x: 10, y: 26, width: 100, height: 30));
        
        self.remButton.setTitle("-", for:  UIControlState());
        
        self.remButton.setTitleColor(UIColor.red, for: UIControlState());
        
        self.remButton.titleLabel!.font =  self.remButton.titleLabel!.font.withSize(30);
        
        self.remButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
        
        self.remButton.addTarget(self, action: #selector(ViewController.removeRow(_:)), for:  .touchUpInside);
        
        self.view.addSubview(self.remButton);
        
        
        /****************************************************************************************************************************/
        /*															BACKGROUND                                                      */
        /****************************************************************************************************************************/
        self.view.backgroundColor = UIColor.green;
        
        
        return;
    }
    

    /********************************************************************************************************************************/
    /**	@fcn		init_table()
     *  @brief
     *  @details
     *
     *  @section	Opens
     *  	x
     *
     *	@section	Todo
     *		x
     */
    /********************************************************************************************************************************/
    @objc func init_table() {
        
        //Init
        self.tableView = UITableView(frame:CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: self.rowHeight+10));
        
        self.tableView.delegate   = self;                                                            //Set both to handle clicks & provide data
        self.tableView.dataSource = self;
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;                            //Std
        
        self.tableView.separatorColor = .clear;
        self.tableView.separatorStyle = .singleLine;
        
        //Safety
        self.tableView.backgroundColor = UIColor.black;
        
        //Set the row height
        self.tableView.rowHeight = self.rowHeight;
        
        //Add it!
        self.view.addSubview(self.tableView);
        
        return;
    }


    @objc func addRow(_ sender: UIButton!) {
        
        print("Tootles");
        
        self.numRows = self.numRows + 1;
        
        //(key)resize
        self.refreshTableHeight();
        
        return;
    }

    
    @objc func removeRow(_ sender: UIButton!) {
        
        print("Frootles?");
        
        self.numRows = (self.numRows>0) ? (self.numRows-1) : 0;
        
        self.refreshTableHeight();
        
        return;
    }

    @objc func refreshTableHeight() {
        
        let miscYOffs : CGFloat = 80;
        
        //Calc height
        let newHeight : CGFloat = (CGFloat(self.numRows) * self.rowHeight) + 10;
        
        
        self.tableView.frame = CGRect(x: 0, y: miscYOffs, width: UIScreen.main.bounds.width, height: newHeight);
        
        self.tableView.reloadData();

        return;
    }
    
/************************************************************************************************************************************/
/*                                      UITableViewDataSource, UITableViewDelegate Interfaces                                       */
/************************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numRows;                                                                 //return how many rows you want printed!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        cell?.textLabel?.text = "ABCD";                                                      //text
        cell?.textLabel?.font = UIFont(name: (cell?.textLabel!.font.fontName)!, size: 20);       //font
        cell?.textLabel?.textAlignment = NSTextAlignment.center;                             //alignment

        cell?.selectionStyle = UITableViewCellSelectionStyle.gray;   //Options are 'Gray/Blue/Default/None'
        
        if(verbose){ print("'ABCD' was added to the table"); }
        
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(verbose){ print("ViewController.tableView():         handling a cell tap of row \(indexPath.item)"); }
        
        tableView.deselectRow(at: indexPath, animated:true);
        
        let currCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        print("\(String(describing: currCell.textLabel?.text)) was pressed");
        
        return;

    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning(); }
}



