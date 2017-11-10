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

    let rowHeight   : CGFloat = 75;
    
    var numRows     : Int = 1;          //changes with button interactions
    var titleBar    : UILabel!;
    
    var addButton   : UIButton!;        //upper button to add a row
    var remButton   : UIButton!;        //upper button to remove a row
    
    var tableView   : UITableView!;
    
    
    
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
    func init_ui() {
        
        /****************************************************************************************************************************/
        /*															TITLEBAR                                                        */
        /****************************************************************************************************************************/
        self.titleBar = UILabel(frame: CGRectMake(0, 20, UIScreen.mainScreen().bounds.width, 40));
        
        self.titleBar.text = "Adjustable Table";
        self.titleBar.textAlignment = .Center;
        self.titleBar.backgroundColor = UIColor.whiteColor();

        self.view.addSubview(self.titleBar);
        
        //fill
        let upperEww = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20));
        upperEww.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(upperEww);

        //border
        let titleBarBottBorder = UIView(frame: CGRectMake(0, 60-1, UIScreen.mainScreen().bounds.width, 1));
        titleBarBottBorder.backgroundColor = UIColor.grayColor();
        self.view.addSubview(titleBarBottBorder);

        
        /****************************************************************************************************************************/
        /*															ADD                                                             */
        /****************************************************************************************************************************/
        self.addButton = UIButton(frame: CGRectMake((UIScreen.mainScreen().bounds.width-30), 26, 20, 30));
        
        self.addButton.setTitle("+", forState:  .Normal);
        
        self.addButton.setTitleColor(UIColor.redColor(), forState: .Normal);
        
        self.addButton.titleLabel!.font =  self.addButton.titleLabel!.font.fontWithSize(30);
        
        self.addButton.addTarget(self, action: #selector(ViewController.addRow(_:)), forControlEvents:  .TouchUpInside);
        
        self.view.addSubview(self.addButton);
        
        
        /****************************************************************************************************************************/
        /*												   		   REMOVE                                                           */
        /****************************************************************************************************************************/
        self.remButton = UIButton(frame: CGRectMake(10, 26, 100, 30));
        
        self.remButton.setTitle("-", forState:  .Normal);
        
        self.remButton.setTitleColor(UIColor.redColor(), forState: .Normal);
        
        self.remButton.titleLabel!.font =  self.remButton.titleLabel!.font.fontWithSize(30);
        
        self.remButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        
        self.remButton.addTarget(self, action: #selector(ViewController.removeRow(_:)), forControlEvents:  .TouchUpInside);
        
        self.view.addSubview(self.remButton);
        
        
        /****************************************************************************************************************************/
        /*															BACKGROUND                                                      */
        /****************************************************************************************************************************/
        self.view.backgroundColor = UIColor.greenColor();
        
        
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
    func init_table() {
        
        //Init
        self.tableView = UITableView(frame:CGRectMake(0, 80, UIScreen.mainScreen().bounds.width, self.rowHeight+10));
        
        self.tableView.delegate   = self;                                                            //Set both to handle clicks & provide data
        self.tableView.dataSource = self;
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;                            //Std
        
        self.tableView.separatorColor = .clearColor();
        self.tableView.separatorStyle = .SingleLine;
        
        //Safety
        self.tableView.backgroundColor = UIColor.blackColor();
        
        //Set the row height
        self.tableView.rowHeight = self.rowHeight;
        
        //Add it!
        self.view.addSubview(self.tableView);
        
        return;
    }


    func addRow(sender: UIButton!) {
        
        print("Tootles");
        
        self.numRows = self.numRows + 1;
        
        //(key)resize
        self.refreshTableHeight();
        
        return;
    }

    
    func removeRow(sender: UIButton!) {
        
        print("Frootles?");
        
        self.numRows = (self.numRows>0) ? (self.numRows-1) : 0;
        
        self.refreshTableHeight();
        
        return;
    }

    func refreshTableHeight() {
        
        let miscYOffs : CGFloat = 80;
        
        //Calc height
        let newHeight : CGFloat = (CGFloat(self.numRows) * self.rowHeight) + 10;
        
        
        self.tableView.frame = CGRectMake(0, miscYOffs, UIScreen.mainScreen().bounds.width, newHeight);
        
        self.tableView.reloadData();

        return;
    }
    
/************************************************************************************************************************************/
/*                                      UITableViewDataSource, UITableViewDelegate Interfaces                                       */
/************************************************************************************************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numRows;                                                                 //return how many rows you want printed!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!;
        
        cell.textLabel?.text = "ABCD";                                                      //text
        cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 20);       //font
        cell.textLabel?.textAlignment = NSTextAlignment.Center;                             //alignment

        cell.selectionStyle = UITableViewCellSelectionStyle.Gray;   //Options are 'Gray/Blue/Default/None'
        
        if(verbose){ print("'ABCD' was added to the table"); }
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(verbose){ print("ViewController.tableView():         handling a cell tap of row \(indexPath.item)"); }
        
        tableView.deselectRowAtIndexPath(indexPath, animated:true);
        
        let currCell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!;
        
        print("\(currCell.textLabel?.text) was pressed");
        
        return;

    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning(); }
}



