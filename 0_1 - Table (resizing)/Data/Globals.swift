/************************************************************************************************************************************/
/** @file		Globals.swift
 *	@project    0_1 - Table (resizing)
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	4/14/16
 *
 * 	@section	Opens
 * 			none current
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.   Copyright © 2016 Jaostech. All rights reserved.
 */
/************************************************************************************************************************************/
import UIKit

let verbose : Bool    = true;
let globals : Globals = Globals();


/************************************************************************************************************************************/
/*	@fcn		Globals                                                                                                             */
/*  @brief		store all non-changing or low-changing, global public information here                                              */
/************************************************************************************************************************************/
class Globals : NSObject {
    
    //->(put your variables here)
    @objc let example_var_0  : Int = 3;
    var example_var_1 : Int?;


    /********************************************************************************************************************************/
    /*	@fcn		override init()                                                                                                 */
    /*  @brief      initialize the globals var. used to init compound or runtime vars                                               */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        
        //(todo) make an App Setting to check too!
        let dispIsZoomed : Bool = (UIDevice.current.name == "Justin's iPhone");
        
        var zoomStat : String = "Globals.init():                        I am not zoomed";
        
        //setup screen size (display zoom has different pixel count!)
        if(dispIsZoomed) {
            zoomStat = "Globals.init():                        I am zoomed";
        }
        
        if(verbose) { print(zoomStat); }
        
        return;
    }
    
    //******************************************************************************************************************************//
    //												    Misc Helpers                                                                //
    //******************************************************************************************************************************//
    @objc func initCellTitle() -> String {
        return "";                                                      /* Empty at this time                                       */
    }
}


//**********************************************************************************************************************************//
//                                                    Global Definitions                                                            //
//**********************************************************************************************************************************//
let NUM_MONTHS_IN_YEAR    : Int = 12;
let NUM_DAYS_IN_MONTH_MAX : Int = 31;
let NUM_HOURS_IN_DAY      : Int = 24;
let NUM_MIN_IN_HOUR       : Int = 60;
let NUM_SEC_IN_MIN        : Int = 60;

let NOT_A_LAP : Int = -1;


//**********************************************************************************************************************************//
//                                                       Global Structs                                                             //
//**********************************************************************************************************************************//
struct someStruc {
    var xOffs : CGFloat!;
    var yOffs : CGFloat!;
    var width : CGFloat!;
    var height: CGFloat!;
}
