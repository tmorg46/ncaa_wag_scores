/*

this file cleans the RoadtoNationals.com scrapes
	contained in the raw_scores folder.
	
it de-dupes the gymnasts and adjusts for any who
	have changed their names over their careers.
	
it is updated for scores through the 2026 season!

*/

clear all

*edit this to be the path with all the team-year csv files
global route "C:/Users/toom/Desktop/ncaa_wag_scores"


********************************
*append all the files together!!
********************************
// make an empty file that we'll use as an append base
clear
tempfile appender
save `appender', emptyok

*define the local with all the csv files
cd "${route}/raw_scores"
local files: dir "${route}/raw_scores" files "*.csv"

*run through each csv file and append it to the ever growing append tempfile
foreach f of local files {
	import delimited using `"`f'"', varn(1) clear
	append using `appender'
	save `appender', replace
}


**************************************
*fix name inconsistencies and errors!!
**************************************
// there's a bunch of gymnasts whose names are missing or weird on RTN:

*some gymnasts are blank on RTN, let's fix those:
replace gymnast = "Grace Woolfolk" if gymnast=="" & team=="Iowa State"
replace gymnast = "Polina Poliakova" if gymnast=="" & team=="Rutgers"
replace gymnast = "Carleigh Stillwagon" if gymnast=="" & team=="Western Michigan" // these are the missing names

*fixing typos and misspellings:
replace gymnast = "Desire' Stephens" if gymnast=="DesirÃ© Stephens" // obvious weird thing
replace gymnast = "Zoë Zimmerman" if gymnast=="ZoÃ« Zimmerman" // another one
replace gymnast = "Marie Priest" if gymnast=="Narah Priest" // this was a weird typo on one single meet, there is no Narah Priest as far as I can find
replace gymnast = "Ava Kelley" if (gymnast=="Ava Kelly" | gymnast=="Ava Kelly") & team=="Springfield College" // they spelled her name wrong and there's another Ava Kelly at Southern Conn, plus in 2025 there's a weird escaped character in her name, hence the ( | )
replace gymnast = "Jessica Miley" if gymnast=="Jessisca Miley" // this is just a raw extra-S typo
replace gymnast = "Maddie Vitolo" if gymnast=="Maddie Viltolo" // and an extra-L classic
replace gymnast = "Itzia San Roman" if gymnast=="Itzia San Ramon" // vowel swap!
replace gymnast = "Kaitlin DeGuzman" if gymnast=="Kaitlin Deguzman" // they didn't capitalize her name at Kentucky but did at Clemson
replace gymnast = "Kayla DiCello" if gymnast=="Kayla Dicello" // caps!
replace gymnast = "Jane Heffernan" if gymnast=="Jane Hefferman" // an n to m swap!
replace gymnast = "Julia Krzywanski" if gymnast=="Julia Kryzwanski" // z-y swap!
replace gymnast = "Ariana DeSouza" if gymnast=="Ariana Desouza" // more caps!!
replace gymnast = "Isabella DeCroo" if gymnast=="Isabella Decroo" // more caps!!
replace gymnast = "Sophia LeBlanc" if gymnast=="Sophia Leblanc" // another caps issue here
replace gymnast = "Alexis Frankowski" if gymnast=="Alexis Frakowski" // typo!
replace gymnast = "Madysen Diskerud" if gymnast=="Madysen Disekrud" // typo!!
replace gymnast = "Michaela DeFrancisco" if (gymnast=="Michaela DeFranscisco" | gymnast=="Michaela Defranscisco") // double typo!!
replace gymnast = "Payton Greene" if gymnast=="Payton Green" // extra e!
replace gymnast = "Robyn Dunne" if gymnast=="Robyn Dunn" // extra e!
replace gymnast = "Sunny Hasebe" if gymnast=="Haruka Hasebe" // this is a Winona State gymnast with two names she's used for scores

replace gymnast = subinstr(gymnast, " ", " ", .) // the first one here is a weird non-white space character...
replace gymnast = subinstr(gymnast, "  ", " ", .) // there's a bunch of double space gaps for no reason

replace gymnast = "Lundyn VanderToolen" if gymnast=="Lundyn Vander Toolen" // space issue, featuring weird white space
replace gymnast = "Elizabeth LaRusso" if (gymnast=="Elizabeth Larusso" | gymnast=="Elizabeth Larusso" | gymnast=="Elizabeth Larusso") // more caps, with weird whitespace issues!
replace gymnast = "Katrina Mendez-Abolnik" if (gymnast=="Katrina Mendez Abolnik" | gymnast=="Katrina Mendez Abolnik") // a dash here, none there, whitespace stuff

*gymnasts with name changes over time:
replace gymnast = "Lindsey Hunter-Kempler" if team=="BYU" & (gymnast=="Linsey Hunter-Kempler" | gymnast=="Lindsey Hunter") // she got married and hyphenated her name
replace gymnast = "Anna Bramblett-Wilde" if team=="BYU" & gymnast=="Anna Bramblett"	// so did she
replace gymnast = "Brynlee Andersen-Broekman" if team=="BYU" & gymnast=="Brynlee Andersen"	// so did she
replace gymnast = "Heidi Schooley-Meyers" if team=="BYU" & gymnast=="Heidi Schooley"	// so did she
replace gymnast = "Mina Margraf-Benson" if team=="BYU" & gymnast=="Mina Margraf"	// so did she
replace gymnast = "Josie Bergstrom-Te Slaa" if team=="Iowa State" & gymnast=="Josie Bergstrom"	// so did she

replace gymnast = "Natasha Marsh" if team=="BYU" & gymnast=="Natasha Trejo" 	// she got married and changed her name
replace gymnast = "Shannon Evans" if team=="BYU" & gymnast=="Shannon Hortman" 	// so did she
replace gymnast = "Brittni Hawes" if team=="BYU" & gymnast=="Brittni Wilde"		// so did she

replace gymnast = "Julie Rottum Madso" if team=="Pittsburgh" & gymnast=="Julie Madso" // sometimes uses her middle name
replace gymnast = "Rocio Madalena Gora" if team=="Gustavus Adolphus" & gymnast=="Rocio Madalena" // second last name


// gymnasts that share names:
*there are two different Abbie Thompson:
replace gymnast = "Abbie Thompson (Cornell)" if gymnast=="Abbie Thompson" & team=="Cornell"
replace gymnast = "Abbie Thompson (Denver)" if gymnast=="Abbie Thompson" & team=="Denver"

*there are two different Aspen Tucker:
replace gymnast = "Aspen Tucker (George Washington)" if gymnast=="Aspen Tucker" & team=="George Washington"
replace gymnast = "Aspen Tucker (Missouri)" if gymnast=="Aspen Tucker" & team=="Missouri"

*there are two different Emily Anderson:
replace gymnast = "Emily Anderson (Gustavus Adolphus)" if gymnast=="Emily Anderson" & team=="Gustavus Adolphus"
replace gymnast = "Emily Anderson (Hamline)" if gymnast=="Emily Anderson" & team=="Hamline"

*there are two different Emily Leese:
replace gymnast = "Emily Leese (Rutgers)" if gymnast=="Emily Leese" & team=="Rutgers"
replace gymnast = "Emily Leese (UW-Eau Claire)" if gymnast=="Emily Leese" & team=="UW-Eau Claire"

*there are two different Emily White:
replace gymnast = "Emily White (North Carolina)" if gymnast=="Emily White" & team=="North Carolina"
replace gymnast = "Emily White (Arizona State)" if gymnast=="Emily White" & team=="Arizona State"

*there are two different Emma Brown:
replace gymnast = "Emma Brown (Ursinus College)" if gymnast=="Emma Brown" & team=="Ursinus College"
replace gymnast = "Emma Brown (Denver)" if gymnast=="Emma Brown" & team=="Denver"

*there are two different Gabrielle Johnson:
replace gymnast = "Gabrielle Johnson (Central Michigan)" if gymnast=="Gabrielle Johnson" & team=="Central Michigan"
replace gymnast = "Gabrielle Johnson (Winona State)" if gymnast=="Gabrielle Johnson" & team=="Winona State"

*there are two different Jordan William:
replace gymnast = "Jordan Williams (UCLA)" if gymnast=="Jordan Williams" & team=="UCLA"
replace gymnast = "Jordan Williams (S.E. Missouri)" if gymnast=="Jordan Williams" & team=="S.E. Missouri"

*there are two different Katie Bailey:
replace gymnast = "Katie Bailey (Alabama)" if gymnast=="Katie Bailey" & team=="Alabama"
replace gymnast = "Katie Bailey (Lindenwood)" if gymnast=="Katie Bailey" & team=="Lindenwood"

*there are two different Lauren Miller:
replace gymnast = "Lauren Miller (Air Force)" if gymnast=="Lauren Miller" & team=="Air Force"
replace gymnast = "Lauren Miller (LIU)" if gymnast=="Lauren Miller" & team=="LIU"

*there are two different Lauren Wong:
replace gymnast = "Lauren Wong (Cornell)" if gymnast=="Lauren Wong" & team=="Cornell"
replace gymnast = "Lauren Wong (Utah)" if gymnast=="Lauren Wong" & team=="Utah"

*there are two different Leah Smith:
replace gymnast = "Leah Smith (Towson)" if gymnast=="Leah Smith" & team=="Towson"
replace gymnast = "Leah Smith (Arkansas)" if gymnast=="Leah Smith" & team=="Arkansas"

*there are two different Maya Davis:
replace gymnast = "Maya Davis (Brown)" if gymnast=="Maya Davis" & team=="Brown"
replace gymnast = "Maya Davis (Lindenwood)" if gymnast=="Maya Davis" & team=="Lindenwood"

*there are two different Olivia Williams:
replace gymnast = "Olivia Williams (Centenary College)" if gymnast=="Olivia Williams" & team=="Centenary College"
replace gymnast = "Olivia Williams (Bowling Green)" if gymnast=="Olivia Williams" & team=="Bowling Green"

*there are two different Payton Murphy:
replace gymnast = "Payton Murphy (Cornell)" if gymnast=="Payton Murphy" & team=="Cornell"
replace gymnast = "Payton Murphy (Western Michigan)" if gymnast=="Payton Murphy" & team=="Western Michigan"

*there are two different Payton Smith:
replace gymnast = "Payton Smith (Rhode Island College)" if gymnast=="Payton Smith" & team=="Rhode Island College"
replace gymnast = "Payton Smith (Auburn)" if gymnast=="Payton Smith" & team=="Auburn"

*there are two different Samantha Henry:
replace gymnast = "Samantha Henry (Cornell)" if gymnast=="Samantha Henry" & team=="Cornell"
replace gymnast = "Samantha Henry (Kent State)" if gymnast=="Samantha Henry" & team=="Kent State"

*there are two different Shannon Farrell:
replace gymnast = "Shannon Farrell (Rutgers)" if gymnast=="Shannon Farrell" & team=="Rutgers"
replace gymnast = "Shannon Farrell (Alaska)" if gymnast=="Shannon Farrell" & team=="Alaska"

*there are two different Sophie Schmitz:
replace gymnast = "Sophie Schmitz (Centenary College)" if gymnast=="Sophie Schmitz" & team=="Centenary College"
replace gymnast = "Sophie Schmitz (Gustavus Adolphus)" if gymnast=="Sophie Schmitz" & team=="Gustavus Adolphus"

*there are two different Sydney Smith:
replace gymnast = "Sydney Smith (Fisk)" if gymnast=="Sydney Smith" & team=="Fisk"
replace gymnast = "Sydney Smith (Southern Conn.)" if gymnast=="Sydney Smith" & team=="Southern Conn."

*there are two different Sydney Ewing:
replace gymnast = "Sydney Ewing (LSU)" if gymnast=="Sydney Ewing" & team=="LSU"
replace gymnast = "Sydney Ewing (Michigan State)" if gymnast=="Sydney Ewing" & team=="Michigan State"


********************************************
*fix meet title inconsistencies and errors!!
********************************************
// there's a bunch of meets whose titles are missing on RTN:
*fix the BIG 5 Meet from 2024:
replace meettitle = "BIG 5 Meet" if date=="Feb-23-2024" & host==""

*fix the Alabama-Auburn Elevate the Stage from 2015:
replace meettitle = "Elevate The Stage" if date=="Mar-08-2015" & host==""

*fix the West Chester Pink Invite from 2019:
replace meettitle = "Pink Invite" if date=="Feb-22-2019" & host==""

*fix the Cancun Classic from 2019:
replace meettitle = "Cancun Classic" if date=="Jan-04-2019" & host==""

// there are two untitled meets involving Georgia in March 2023 (their 10th & 11th meets, 
// which were also Arkansas' 9th and Michigan's 10th, respectively). They had to do some 
// emergency repairs to their arena so they went to a semi-neutral site nearby... so they 
// /kinda/ hosted, but not enough to mark them as hosts (for the purposes of this project) 
// or to title the meet. their event_meet_id made below is still unique for both of the 
// meets due to the different dates of the meets and due to those two meets being the only 
// two (untitled & no-host) meets in the sample.


***********************************************
*final formatting: reshape & numeric ids & save
***********************************************
// now we'd like to generate a string that uniquely identifies events within meets, but it needs a reshape:
rename (vault bars beam floor) (score1 score2 score3 score4)
reshape long score, i(meettitle date host gymnast) j(event)
drop if score==. // good stuff, now let's move along:

*label the events (these export to string in csv format)
gen event_title = event
label define event_lbl 1 "Vault" 2 "Uneven Bars" 3 "Balance Beam" 4 "Floor Exercise"
label values event_title event_lbl


*and now we're done!
compress
sort team year meetnum event score
order meettitle date host gymnast event event_title score team year meetnum
export delimited using "${route}/cleaned_scores.csv", replace // and we're done!







