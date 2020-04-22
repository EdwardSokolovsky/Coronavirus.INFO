//
//  CountriesDao.swift
//  Coronavirus.INFO
//
//  Created by Edward on 13.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation

class CountriesDao: ObservableObject{
    
 @Published var countriesArray = [
                Country(name: "afghanistan"),
                Country(name: "albania"),
                Country(name: "algeria"),
                Country(name: "andorra"),
                Country(name: "angola"),
                Country(name: "anguilla"),
                Country(name: "antigua-and-barbuda"),
                Country(name: "argentina"),
                Country(name: "armenia"),
                Country(name: "aruba"),
                Country(name: "australia"),
                Country(name: "austria"),
                Country(name: "azerbaijan"),
                Country(name: "bahamas"),
                Country(name: "bahrain"),
                Country(name: "bangladesh"),
                Country(name: "barbados"),
                Country(name: "belarus"),
                Country(name: "belgium"),
                Country(name: "belize"),
                Country(name: "benin"),
                Country(name: "bermuda"),
                Country(name: "bhutan"),
                Country(name: "bolivia"),
                Country(name: "bosnia-and-herzegovina"),
                Country(name: "botswana"),
                Country(name: "brazil"),
                Country(name: "british-virgin-islands"),
                Country(name: "brunei-darussalam"),
                Country(name: "bulgaria"),
                Country(name: "burkina-faso"),
                Country(name: "burundi"),
                Country(name: "cabo-verde"),
                Country(name: "cambodia"),
                Country(name: "cameroon"),
                Country(name: "canada"),
                Country(name: "caribbean-netherlands"),
                Country(name: "cayman-islands"),
                Country(name: "central-african-republic"),
                Country(name: "chad"),
                Country(name: "channel-islands"),
                Country(name: "chile"),
                Country(name: "china"),
                Country(name: "china-hong-kong-sar"),
                Country(name: "china-macao-sar"),
                Country(name: "colombia"),
                Country(name: "congo"),
                Country(name: "costa-rica"),
                Country(name: "cote-d-ivoire"),
                Country(name: "croatia"),
                Country(name: "cuba"),
                Country(name: "curacao"),
                Country(name: "cyprus"),
                Country(name: "czech-republic"),
                Country(name: "democratic-republic-of-the-congo"),
                Country(name: "denmark"),
                Country(name: "djibouti"),
                Country(name: "dominica"),
                Country(name: "dominican-republic"),
                Country(name: "ecuador"),
                Country(name: "egypt"),
                Country(name: "el-salvador"),
                Country(name: "equatorial-guinea"),
                Country(name: "eritrea"),
                Country(name: "estonia"),
                Country(name: "ethiopia"),
                Country(name: "faeroe-islands"),
                Country(name: "falkland-islands-malvinas"),
                Country(name: "fiji"),
                Country(name: "finland"),
                Country(name: "france"),
                Country(name: "french-guiana"),
                Country(name: "french-polynesia"),
                Country(name: "gabon"),
                Country(name: "gambia"),
                Country(name: "georgia"),
                Country(name: "germany"),
                Country(name: "ghana"),
                Country(name: "gibraltar"),
                Country(name: "greece"),
                Country(name: "greenland"),
                Country(name: "grenada"),
                Country(name: "guadeloupe"),
                Country(name: "guatemala"),
                Country(name: "guinea"),
                Country(name: "guinea-bissau"),
                Country(name: "guyana"),
                Country(name: "haiti"),
                Country(name: "holy-see"),
                Country(name: "honduras"),
                Country(name: "hungary"),
                Country(name: "iceland"),
                Country(name: "india"),
                Country(name: "indonesia"),
                Country(name: "iran"),
                Country(name: "iraq"),
                Country(name: "ireland"),
                Country(name: "isle-of-man"),
                Country(name: "israel"),
                Country(name: "italy"),
                Country(name: "jamaica"),
                Country(name: "japan"),
                Country(name: "jordan"),
                Country(name: "kazakhstan"),
                Country(name: "kenya"),
                Country(name: "kuwait"),
                Country(name: "kyrgyzstan"),
                Country(name: "laos"),
                Country(name: "latvia"),
                Country(name: "lebanon"),
                Country(name: "liberia"),
                Country(name: "libya"),
                Country(name: "liechtenstein"),
                Country(name: "lithuania"),
                Country(name: "luxembourg"),
                Country(name: "macedonia"),
                Country(name: "madagascar"),
                Country(name: "malawi"),
                Country(name: "malaysia"),
                Country(name: "maldives"),
                Country(name: "mali"),
                Country(name: "malta"),
                Country(name: "martinique"),
                Country(name: "mauritania"),
                Country(name: "mauritius"),
                Country(name: "mayotte"),
                Country(name: "mexico"),
                Country(name: "moldova"),
                Country(name: "monaco"),
                Country(name: "mongolia"),
                Country(name: "montenegro"),
                Country(name: "montserrat"),
                Country(name: "morocco"),
                Country(name: "mozambique"),
                Country(name: "myanmar"),
                Country(name: "namibia"),
                Country(name: "nepal"),
                Country(name: "netherlands"),
                Country(name: "new-caledonia"),
                Country(name: "new-zealand"),
                Country(name: "nicaragua"),
                Country(name: "niger"),
                Country(name: "nigeria"),
                Country(name: "norway"),
                Country(name: "oman"),
                Country(name: "pakistan"),
                Country(name: "panama"),
                Country(name: "papua-new-guinea"),
                Country(name: "paraguay"),
                Country(name: "peru"),
                Country(name: "philippines"),
                Country(name: "poland"),
                Country(name: "portugal"),
                Country(name: "qatar"),
                Country(name: "reunion"),
                Country(name: "romania"),
                Country(name: "russia"),
                Country(name: "rwanda"),
                Country(name: "saint-barthelemy"),
                Country(name: "saint-kitts-and-nevis"),
                Country(name: "saint-lucia"),
                Country(name: "saint-martin"),
                Country(name: "saint-pierre-and-miquelon"),
                Country(name: "saint-vincent-and-the-grenadines"),
                Country(name: "san-marino"),
                Country(name: "sao-tome-and-principe"),
                Country(name: "saudi-arabia"),
                Country(name: "senegal"),
                Country(name: "serbia"),
                Country(name: "seychelles"),
                Country(name: "sierra-leone"),
                Country(name: "singapore"),
                Country(name: "sint-maarten"),
                Country(name: "slovakia"),
                Country(name: "slovenia"),
                Country(name: "somalia"),
                Country(name: "south-africa"),
                Country(name: "south-korea"),
                Country(name: "south-sudan"),
                Country(name: "spain"),
                Country(name: "sri-lanka"),
                Country(name: "state-of-palestine"),
                Country(name: "sudan"),
                Country(name: "suriname"),
                Country(name: "swaziland"),
                Country(name: "sweden"),
                Country(name: "switzerland"),
                Country(name: "syria"),
                Country(name: "taiwan"),
                Country(name: "tanzania"),
                Country(name: "thailand"),
                Country(name: "timor-leste"),
                Country(name: "togo"),
                Country(name: "trinidad-and-tobago"),
                Country(name: "tunisia"),
                Country(name: "turkey"),
                Country(name: "turks-and-caicos-islands"),
                Country(name: "uganda"),
                Country(name: "uk"),
                Country(name: "ukraine"),
                Country(name: "united-arab-emirates"),
                Country(name: "uruguay"),
                Country(name: "us"),
                Country(name: "uzbekistan"),
                Country(name: "venezuela"),
                Country(name: "viet-nam"),
                Country(name: "western-sahara"),
                Country(name: "zambia"),
                Country(name: "zimbabwe"),
            ]
    
    #if DEBUG
    let testData = [
        Country(name: "china"),
        Country(name: "croatia"),
        Country(name: "italy"),
        Country(name: "russia"),
        Country(name: "us"),
    ]
    #endif
}