//
//  ColorGenerator.swift
//  StantDrawing
//
//  Created by Stant 02 on 21/02/18.
//  Copyright © 2018 Stant. All rights reserved.
//

import UIKit

public class ColorGenerator {
    
    public static func getAll() -> [String]{
        var colors = [UIColor.red.toHexString(),
                      UIColor.green.toHexString(),
                      UIColor.blue.toHexString(),
                      UIColor.cyan.toHexString(),
                      UIColor.yellow.toHexString(),
                      UIColor.magenta.toHexString(),
                      UIColor.orange.toHexString(),
                      UIColor.purple.toHexString(),
                      UIColor.brown.toHexString(),
                      UIColor.black.toHexString(),
                      UIColor.lightGray.toHexString(),
                      UIColor.gray.toHexString()]
        
        colors.append(contentsOf: secondaryColors())
        return colors
    }
    
    private static func secondaryColors() -> [String] {
        let Black            = colorWithHexString(hex: "#000000")
        let Green            = colorWithHexString(hex:"#00FF00")
        let Blue             = colorWithHexString(hex:"#0000FF")
        let Red              = colorWithHexString(hex: "#FF0000")
        let Cyan             = colorWithHexString(hex:"#01FFFE")
        let Light_Pink       = colorWithHexString(hex:"#FF9CFE")
        let Pale_Yellow      = colorWithHexString(hex:"#FFDB66")
        let Tree_Green       = colorWithHexString(hex:"#09630C")
        let Deep_Purple      = colorWithHexString(hex:"#020865")
        let Burgundy         = colorWithHexString(hex:"#93063B")
        let Pale_Blue        = colorWithHexString(hex:"#127EB3")
        let Tree_Brown       = colorWithHexString(hex:"#764D0D")
        let Light_Green      = colorWithHexString(hex:"#94F996")
        let Baby_Blue        = colorWithHexString(hex:"#157AFB")
        let Lemonade_Green   = colorWithHexString(hex:"#D6FD35")
        let Salmon           = colorWithHexString(hex:"#FD9381")
        let Greyish          = colorWithHexString(hex:"#6B826D")
        let Orange           = colorWithHexString(hex:"#FC8924")
        let Light_Purple     = colorWithHexString(hex:"#794981")
        let Purple           = colorWithHexString(hex:"#7D37CF")
        let Algae_Green      = colorWithHexString(hex:"#86A81F")
        let Hot_Red          = colorWithHexString(hex:"#FC1159")
        let Red_Brown        = colorWithHexString(hex:"#A2250F")
        let Petrol_Green     = colorWithHexString(hex:"#1AAD7F")
        let Pale_Brown       = colorWithHexString(hex:"#673D3C")
        let Cyan_Purple      = colorWithHexString(hex:"#BDC7FD")
        let Deep_Green       = colorWithHexString(hex:"#263304")
        let Smug_Green       = colorWithHexString(hex:"#1BB729")
        let Red_Purple       = colorWithHexString(hex:"#9C128C")
        let Navy_Blue        = colorWithHexString(hex:"#011743")
        let Dark_Nude        = colorWithHexString(hex:"#C18D9F")
        let Easy_Pink        = colorWithHexString(hex:"#FD76A3")
        let Tiffany_Blue     = colorWithHexString(hex:"#24D1FD")
        let Petrol_Blue      = colorWithHexString(hex:"#064753")
        let Pinkish          = colorWithHexString(hex:"#E374FB")
        let Smug             = colorWithHexString(hex:"#788137")
        let Darker_Blue      = colorWithHexString(hex:"#144E9F")
        let Lighter_Blue     = colorWithHexString(hex:"#93D0CB")
        let Light_Brown      = colorWithHexString(hex:"#BD9973")
        let Levander         = colorWithHexString(hex:"#968CE5")
        let Shoosh_Brown     = colorWithHexString(hex:"#BA871D")
        let Wine             = colorWithHexString(hex:"#42022C")
        let Lightlemon_green = colorWithHexString(hex:"#DFFD7D")
        let Light_Cyan       = colorWithHexString(hex:"#2BFEC7")
        let Gold_Yellow      = colorWithHexString(hex:"#FEE333")
        let Ramish_Red       = colorWithHexString(hex:"#610F05")
        let Dark_Cyan        = colorWithHexString(hex:"#158F9B")
        let Reflex_Green     = colorWithHexString(hex:"#9BFD5E")
        let Regular_Purple   = colorWithHexString(hex:"#7448AF")
        let Lighter_Purple   = colorWithHexString(hex:"#B326FB")
        let Greenish         = colorWithHexString(hex:"#2AFD7E")
        let Salmon_Orange    = colorWithHexString(hex:"#FD6F49")
        let Deep_Green_      = colorWithHexString(hex:"#095E3A")
        let Grey             = colorWithHexString(hex:"#6B6981")
        let Leafs_Green      = colorWithHexString(hex:"#62AC53")
        let Brown            = colorWithHexString(hex:"#A65743")
        let Lighter_Cyan     = colorWithHexString(hex:"#A8FED3")
        let Easy_Salmon      = colorWithHexString(hex:"#FDB06D")
        let Cute_Blue        = colorWithHexString(hex:"#1B9DFC")
        let Cute_Pink        = colorWithHexString(hex:"#E662BD")
        
        return [Black,
                Green,
                Blue,
                Red,
                Cyan, Light_Pink, Pale_Yellow,
                Tree_Green, Deep_Purple, Burgundy, Pale_Blue, Tree_Brown,
                Light_Green, Baby_Blue, Lemonade_Green, Salmon, Greyish,
                Orange, Light_Purple, Purple, Algae_Green, Hot_Red, Red_Brown,
                Petrol_Green, Pale_Brown, Cyan_Purple, Deep_Green, Smug_Green,
                Red_Purple, Navy_Blue, Dark_Nude, Easy_Pink, Tiffany_Blue,
                Petrol_Blue, Pinkish, Smug, Darker_Blue, Lighter_Blue,
                Light_Brown, Levander, Shoosh_Brown, Wine, Lightlemon_green,
                Light_Cyan, Gold_Yellow, Ramish_Red, Dark_Cyan, Reflex_Green,
                Regular_Purple, Lighter_Purple, Greenish, Salmon_Orange,
                Deep_Green_, Grey, Leafs_Green, Brown, Lighter_Cyan,
                Easy_Salmon, Cute_Blue, Cute_Pink]
    }
    
    private static func colorWithHexString(hex: String) -> String {
        return UIColor(hexString:hex).toHexString()
    }
    
}
