//
//  AppDelegate.m
//  TableCatalog
//
//  Created by Dylan Eirinberg on 8/6/13.
//  Copyright (c) 2013 Dylan Eirinberg. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Team.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* The team entries are intialized here in the AppDelegate (only works if developer knows what index of the
     * navigation controller the view controller is). They can also be set in a ViewController like the groupsArray.
     * Each entry of the array returns an instancetype define in the Team class.
     */
    NSArray *teamArray = @[[Team teamWithName:@"Atlanta Hawks" league:@"NBA" coach:@"Mike Budenholzer" lastChamp:@"1958" division:@"Southeast" hex:@"bec0c2" imgLink:@"/logos/6/220/full/5mdhgjh3aa92kih09pgi.gif"],
                           [Team teamWithName:@"Boston Celtics" league:@"NBA" coach:@"Brad Stevens" lastChamp:@"2008" division:@"Atlantic" hex:@"06864c" imgLink:@"/logos/6/213/full/slhg02hbef3j1ov4lsnwyol5o.gif"],
                           [Team teamWithName:@"Brooklyn Nets" league:@"NBA" coach:@"Jason Kidd" lastChamp:@"1976" division:@"Atlantic" hex:@"ffffff" imgLink:@"/logos/6/3786/full/137_brooklyn-nets-primary-2013.gif"],
                           [Team teamWithName:@"Charlotte Bobcats" league:@"NBA" coach:@"Steve Clifford" lastChamp:@"-" division:@"Southeast" hex:@"f47a24" imgLink:@"/logos/6/258/full/456_charlotte-bobcats-primary-2013.gif"],
                           [Team teamWithName:@"Chicago Bulls" league:@"NBA" coach:@"Tom Thibodeau" lastChamp:@"1998" division:@"Central" hex:@"cc1244" imgLink:@"/logos/6/221/full/hj3gmh82w9hffmeh3fjm5h874.gif"],
                           [Team teamWithName:@"Cleveland Cavaliers" league:@"NBA" coach:@"Mike Brown" lastChamp:@"-" division:@"Central" hex:@"f4ba3c" imgLink:@"/logos/6/222/full/e4701g88mmn7ehz2baynbs6e0.gif"],
                           [Team teamWithName:@"Dallas Mavericks" league:@"NBA" coach:@"Rick Carlisle" lastChamp:@"2011" division:@"Southwest" hex:@"006bb7" imgLink:@"/logos/6/228/full/ifk08eam05rwxr3yhol3whdcm.gif"],
                           [Team teamWithName:@"Denver Nuggets" league:@"NBA" coach:@"Brian Shaw" lastChamp:@"-" division:@"Northwest" hex:@"4b90cd" imgLink:@"/logos/6/229/full/xeti0fjbyzmcffue57vz5o1gl.gif"],
                           [Team teamWithName:@"Detroit Pistons" league:@"NBA" coach:@"Maurice Cheeks" lastChamp:@"2004" division:@"Central" hex:@"ed164b" imgLink:@"/logos/6/223/full/3079.gif"],
                           [Team teamWithName:@"Golden State Warriors" league:@"NBA" coach:@"Mark Jackson" lastChamp:@"1975" division:@"Pacific" hex:@"ffc423" imgLink:@"/logos/6/235/full/qhhir6fj8zp30f33s7sfb4yw0.png"],
                           [Team teamWithName:@"Houston Rockets" league:@"NBA" coach:@"Kevin McHale" lastChamp:@"1995" division:@"Southwest" hex:@"ffffff" imgLink:@"/logos/6/230/full/8xe4813lzybfhfl14axgzzqeq.gif"],
                           [Team teamWithName:@"Indiana Pacers" league:@"NBA" coach:@"Frank Vogel" lastChamp:@"-" division:@"Central" hex:@"ffc422" imgLink:@"/logos/6/224/full/3083.gif"],
                           [Team teamWithName:@"Los Angeles Clippers" league:@"NBA" coach:@"Doc Rivers" lastChamp:@"-" division:@"Pacific" hex:@"ffffff" imgLink:@"/logos/6/236/full/bvv028jd1hhr8ee8ii7a0fg4i.gif"],
                           [Team teamWithName:@"Los Angeles Lakers" league:@"NBA" coach:@"Mike D'Antoni" lastChamp:@"2010" division:@"Pacific" hex:@"fdc82f" imgLink:@"/logos/6/237/full/uig7aiht8jnpl1szbi57zzlsh.gif"],
                           [Team teamWithName:@"Memphis Grizzlies" league:@"NBA" coach:@"Dave Joerger" lastChamp:@"-" division:@"Southwest" hex:@"bed0e1" imgLink:@"/logos/6/231/full/793.gif"],
                           [Team teamWithName:@"Miami Heat" league:@"NBA" coach:@"Erik Spoelstra" lastChamp:@"2013" division:@"Southeast" hex:@"98012e" imgLink:@"/logos/6/214/full/burm5gh2wvjti3xhei5h16k8e.gif"],
                           [Team teamWithName:@"Milwaukee Bucks" league:@"NBA" coach:@"Larry Drew" lastChamp:@"1971" division:@"Central" hex:@"b92432" imgLink:@"/logos/6/225/full/0295onf2c4xsbfsxye6i.gif"],
                           [Team teamWithName:@"Minnesota Timberwolves" league:@"NBA" coach:@"Rick Adelman" lastChamp:@"-" division:@"Northwest" hex:@"005084" imgLink:@"/logos/6/232/full/zq8qkfni1g087f4245egc32po.gif"],
                           [Team teamWithName:@"New Orleans Pelicans" league:@"NBA" coach:@"Monty Williams" lastChamp:@"-" division:@"Southwest" hex:@"e61c39" imgLink:@"/logos/6/4962/full/2681_new_orleans_pelicans-primary-2014.png"],
                           [Team teamWithName:@"New York Knicks" league:@"NBA" coach:@"Mike Woodson" lastChamp:@"1973" division:@"Atlantic" hex:@"f4862c" imgLink:@"/logos/6/216/full/2nn48xofg0hms8k326cqdmuis.gif"],
                           [Team teamWithName:@"Oklahoma City Thunder" league:@"NBA" coach:@"Scott Brooks" lastChamp:@"1979" division:@"Northwest" hex:@"ffba30" imgLink:@"/logos/6/2687/full/khmovcnezy06c3nm05ccn0oj2.gif"],
                           [Team teamWithName:@"Orlando Magic" league:@"NBA" coach:@"Jacque Vaughn" lastChamp:@"-" division:@"Southeast" hex:@"0476bc" imgLink:@"/logos/6/217/full/wd9ic7qafgfb0yxs7tem7n5g4.gif"],
                           [Team teamWithName:@"Philadelphia 76ers" league:@"NBA" coach:@"Brett Brown" lastChamp:@"1983" division:@"Atlantic" hex:@"d0103a" imgLink:@"/logos/6/218/full/qlpk0etqwelv8artgc7tvqefu.gif"],
                           [Team teamWithName:@"Phoenix Suns" league:@"NBA" coach:@"Jeff Hornacek" lastChamp:@"-" division:@"Pacific" hex:@"e66226" imgLink:@"/logos/6/238/full/4370_phoenix_suns-primary-2014.png"],
                           [Team teamWithName:@"Portland Trailblazers" league:@"NBA" coach:@"Terry Stotts" lastChamp:@"1977" division:@"Northwest" hex:@"e2383f" imgLink:@"/logos/6/239/full/bahmh46cyy6eod2jez4g21buk.gif"],
                           [Team teamWithName:@"Sacramento Kings" league:@"NBA" coach:@"Mike Malone" lastChamp:@"-" division:@"Pacific" hex:@"393996" imgLink:@"/logos/6/240/full/832.gif"],
                           [Team teamWithName:@"San Antonio Spurs" league:@"NBA" coach:@"Gregg Popovich" lastChamp:@"2007" division:@"Southwest" hex:@"c4ced4" imgLink:@"/logos/6/233/full/827.gif"],
                           [Team teamWithName:@"Toronto Raptors" league:@"NBA" coach:@"Dwane Casey" lastChamp:@"-" division:@"Atlantic" hex:@"c6cfd4" imgLink:@"/logos/6/227/full/yfypcwqog6qx8658sn5w65huh.gif"],
                           [Team teamWithName:@"Utah Jazz" league:@"NBA" coach:@"Tyrone Corbin" lastChamp:@"-" division:@"Northwest" hex:@"042244" imgLink:@"/logos/6/234/full/m2leygieeoy40t46n1qqv0550.gif"],
                           [Team teamWithName:@"Washington Wizards" league:@"NBA" coach:@"Randy Wittman" lastChamp:@"1978" division:@"Southeast" hex:@"e41634" imgLink:@"/logos/6/219/full/b3619brnphtx65s2th4p9eggf.gif"],
                           [Team teamWithName:@"Arizona Cardinals" league:@"NFL" coach:@"Bruce Arians" lastChamp:@"-" division:@"NFC West" hex:@"b00539" imgLink:@"/logos/7/177/full/kwth8f1cfa2sch5xhjjfaof90.gif"],
                           [Team teamWithName:@"Chicago Bears" league:@"NFL" coach:@"Marc Trestman" lastChamp:@"1986" division:@"NFC North" hex:@"df6108" imgLink:@"/logos/7/169/full/364.gif"],
                           [Team teamWithName:@"Detroit Lions" league:@"NFL" coach:@"Jim Schwartz" lastChamp:@"-" division:@"NFC North" hex:@"006db0" imgLink:@"/logos/7/170/full/cwuyv0w15ruuk34j9qnfuoif9.gif"],
                           [Team teamWithName:@"Kansas City Chiefs" league:@"NFL" coach:@"Andy Reid" lastChamp:@"1970" division:@"AFC West" hex:@"b20032" imgLink:@"/logos/7/162/full/857.gif"],
                           [Team teamWithName:@"New York Giants" league:@"NFL" coach:@"Tom Coughlin" lastChamp:@"2012" division:@"NFC East" hex:@"192e6c" imgLink:@"/logos/7/166/full/919.gif"],
                           [Team teamWithName:@"San Diego Chargers" league:@"NFL" coach:@"Mike McCoy" lastChamp:@"-" division:@"AFC West" hex:@"0472cc" imgLink:@"/logos/7/164/full/8e1jhgblydtow4m3okwzxh67k.gif"],
                           [Team teamWithName:@"Tennessee Titans" league:@"NFL" coach:@"Mike Munchak" lastChamp:@"-" division:@"AFC South" hex:@"648fcc" imgLink:@"/logos/7/160/full/1053.gif"],
                           [Team teamWithName:@"Atlanta Falcons" league:@"NFL" coach:@"Mike Smith" lastChamp:@"-" division:@"NFC South" hex:@"c9233f" imgLink:@"/logos/7/173/full/299.gif"],
                           [Team teamWithName:@"Cincinnati Bengals" league:@"NFL" coach:@"Marvin Lewis" lastChamp:@"-" division:@"AFC North" hex:@"e44a24" imgLink:@"/logos/7/154/full/403.gif"],
                           [Team teamWithName:@"Green Bay Packers" league:@"NFL" coach:@"Mike McCarthy" lastChamp:@"2011" division:@"NFC North" hex:@"313f36" imgLink:@"/logos/7/171/full/dcy03myfhffbki5d7il3.gif"],
                           [Team teamWithName:@"Miami Dolphins" league:@"NFL" coach:@"Joe Philbin" lastChamp:@"1974" division:@"AFC East" hex:@"ff8200" imgLink:@"/logos/7/150/full/4105_miami_dolphins-primary-2013.png"],
                           [Team teamWithName:@"New York Jets" league:@"NFL" coach:@"Rex Ryan" lastChamp:@"1969" division:@"AFC East" hex:@"1c322c" imgLink:@"/logos/7/152/full/v7tehkwthrwefgounvi7znf5k.gif"],
                           [Team teamWithName:@"San Francisco 49ers" league:@"NFL" coach:@"Jim Harbaugh" lastChamp:@"1995" division:@"NFC West" hex:@"c4021c" imgLink:@"/logos/7/179/full/9455_san_francisco_49ers-primary-2009.gif"],
                           [Team teamWithName:@"Washington Redskins" league:@"NFL" coach:@"Mike Shanahan" lastChamp:@"1992" division:@"NFC East" hex:@"8c0234" imgLink:@"/logos/7/168/full/im5xz2q9bjbg44xep08bf5czq.gif"],
                           [Team teamWithName:@"Baltimore Ravens" league:@"NFL" coach:@"John Harbaugh" lastChamp:@"2013" division:@"AFC North" hex:@"24125c" imgLink:@"/logos/7/153/full/318.gif"],
                           [Team teamWithName:@"Cleveland Browns" league:@"NFL" coach:@"Rob Chudzinski" lastChamp:@"-" division:@"AFC North" hex:@"342624" imgLink:@"/logos/7/155/full/2ioheczrkmc2ibc42c9r.gif"],
                           [Team teamWithName:@"Houston Texans" league:@"NFL" coach:@"Gary Kubiak" lastChamp:@"-" division:@"AFC South" hex:@"b20032" imgLink:@"/logos/7/157/full/570.gif"],
                           [Team teamWithName:@"Minnesota Vikings" league:@"NFL" coach:@"Leslie Frazier" lastChamp:@"-" division:@"NFC North" hex:@"582c83" imgLink:@"/logos/7/172/full/2704_minnesota_vikings-primary-2013.png"],
                           [Team teamWithName:@"Oakland Raiders" league:@"NFL" coach:@"Dennis Allen" lastChamp:@"1984" division:@"AFC West" hex:@"c4cacc" imgLink:@"/logos/7/163/full/g9mgk6x3ge26t44cccm9oq1vl.gif"],
                           [Team teamWithName:@"Seattle Seahawks" league:@"NFL" coach:@"Pete Carroll" lastChamp:@"-" division:@"NFC West" hex:@"0c2244" imgLink:@"/logos/7/180/full/pfiobtreaq7j0pzvadktsc6jv.gif"],
                           [Team teamWithName:@"Buffalo Bills" league:@"NFL" coach:@"Doug Marrone" lastChamp:@"-" division:@"AFC East" hex:@"043284" imgLink:@"/logos/7/149/full/n0fd1z6xmhigb0eej3323ebwq.gif"],
                           [Team teamWithName:@"Dallas Cowboys" league:@"NFL" coach:@"Jason Garrett" lastChamp:@"1995" division:@"NFC East" hex:@"0d254c" imgLink:@"/logos/7/165/full/406.gif"],
                           [Team teamWithName:@"Indianapolis Colts" league:@"NFL" coach:@"Chuck Pagano" lastChamp:@"2007" division:@"AFC South" hex:@"043a74" imgLink:@"/logos/7/158/full/593.gif"],
                           [Team teamWithName:@"New England Patriots" league:@"NFL" coach:@"Bill Belichick" lastChamp:@"2005" division:@"AFC East" hex:@"0c2244" imgLink:@"/logos/7/151/full/y71myf8mlwlk8lbgagh3fd5e0.gif"],
                           [Team teamWithName:@"Philadelphia Eagles" league:@"NFL" coach:@"Chip Kelly" lastChamp:@"-" division:@"NFC East" hex:@"003b48" imgLink:@"/logos/7/167/full/960.gif"],
                           [Team teamWithName:@"St. Louis Rams" league:@"NFL" coach:@"Jeff Fisher" lastChamp:@"2000" division:@"NFC West" hex:@"0d254c" imgLink:@"/logos/7/178/full/1029.gif"],
                           [Team teamWithName:@"Carolina Panthers" league:@"NFL" coach:@"Ron Rivera" lastChamp:@"-" division:@"NFC South" hex:@"049ad6" imgLink:@"/logos/7/174/full/f1wggq2k8ql88fe33jzhw641u.gif"],
                           [Team teamWithName:@"Denver Broncos" league:@"NFL" coach:@"John Fox" lastChamp:@"1999" division:@"AFC West" hex:@"fc4e04" imgLink:@"/logos/7/161/full/9ebzja2zfeigaziee8y605aqp.gif"],
                           [Team teamWithName:@"Jacksonville Jaguars" league:@"NFL" coach:@"Gus Bradley" lastChamp:@"-" division:@"AFC South" hex:@"006779" imgLink:@"/logos/7/159/full/8856_jacksonville_jaguars-alternate-2013.png"],
                           [Team teamWithName:@"New Orleans Saints" league:@"NFL" coach:@"Sean Payton" lastChamp:@"2010" division:@"NFC South" hex:@"c9b074" imgLink:@"/logos/7/175/full/907.gif"],
                           [Team teamWithName:@"Pittsburgh Steelers" league:@"NFL" coach:@"Mike Tomlin" lastChamp:@"2009" division:@"AFC North" hex:@"fcc20c" imgLink:@"/logos/7/156/full/970.gif"],
                           [Team teamWithName:@"Tampa Bay Buccanneers" league:@"NFL" coach:@"Greg Schiano" lastChamp:@"2003" division:@"NFC South" hex:@"b20032" imgLink:@"/logos/7/176/full/1046.gif"],
                           [Team teamWithName:@"Baltimore Orioles" league:@"MLB" coach:@"Buck Showalter" lastChamp:@"1983" division:@"AL East" hex:@"fc4e04" imgLink:@"/logos/53/52/full/lty880yrmrra64y6tqfqmdnbf.gif"],
                           [Team teamWithName:@"Houston Astros" league:@"MLB" coach:@"Bo Porter" lastChamp:@"-" division:@"AL West" hex:@"ec6e1c" imgLink:@"/logos/53/4929/full/9503_houston_astros-primary-2000.gif"],
                           [Team teamWithName:@"Oakland Athletics" league:@"MLB" coach:@"Bob Melvin" lastChamp:@"1989" division:@"AL West" hex:@"fdba31" imgLink:@"/logos/53/69/full/6xk2lpc36146pbg2kydf13e50.gif"],
                           [Team teamWithName:@"Boston Red Sox" league:@"MLB" coach:@"John Farrell" lastChamp:@"2007" division:@"AL East" hex:@"031a43" imgLink:@"/logos/53/53/full/c0whfsa9j0vbs079opk2s05lx.gif"],
                           [Team teamWithName:@"Kansas City Royals" league:@"MLB" coach:@"Ned Yost" lastChamp:@"1985" division:@"AL Central" hex:@"042e74" imgLink:@"/logos/53/62/full/fmrl2b6xf5hruiike42gn62yu.gif"],
                           [Team teamWithName:@"Seattle Mariners" league:@"MLB" coach:@"Eric Wedge" lastChamp:@"-" division:@"AL West" hex:@"046e6c" imgLink:@"/logos/53/75/full/1305.gif"],
                           [Team teamWithName:@"Chicago White Sox" league:@"MLB" coach:@"Robin Ventura" lastChamp:@"2005" division:@"AL Central" hex:@"fcfefc" imgLink:@"/logos/53/55/full/oxvkprv7v4inf5dgqdebp0yse.gif"],
                           [Team teamWithName:@"Los Angeles Angels" league:@"MLB" coach:@"Mike Scioscia" lastChamp:@"2002" division:@"AL West" hex:@"0c2244" imgLink:@"/logos/53/922/full/wsghhaxkh5qq0hdkbt1b5se41.gif"],
                           [Team teamWithName:@"Tampa Bay Rays" league:@"MLB" coach:@"Joe Maddon" lastChamp:@"-" division:@"AL East" hex:@"79bde9" imgLink:@"/logos/53/2535/full/qiru2jftx1a378eq8ad0s4ik4.gif"],
                           [Team teamWithName:@"Cleveland Indians" league:@"MLB" coach:@"Terry Francona" lastChamp:@"1948" division:@"AL Central" hex:@"0c2244" imgLink:@"/logos/53/57/full/wnyd2zhh84f50ux4uxyqbktbh.gif"],
                           [Team teamWithName:@"Minnesota Twins" league:@"MLB" coach:@"Ron Gardenhire" lastChamp:@"1991" division:@"AL Central" hex:@"b41234" imgLink:@"/logos/53/65/full/peii986yf4l42v3aa3hy0ovlf.gif"],
                           [Team teamWithName:@"Texas Rangers" league:@"MLB" coach:@"Ron Washington" lastChamp:@"-" division:@"AL West" hex:@"bc0e2c" imgLink:@"/logos/53/77/full/ajfeh4oqeealq37er15r3673h.gif"],
                           [Team teamWithName:@"Detroit Tigers" league:@"MLB" coach:@"Jim Leyland" lastChamp:@"1984" division:@"AL Central" hex:@"0c2244" imgLink:@"/logos/53/59/full/txtu234jlffk0q5l62uhnwm3q.gif"],
                           [Team teamWithName:@"New York Yankees" league:@"MLB" coach:@"Joe Girardi" lastChamp:@"2009" division:@"AL East" hex:@"041e44" imgLink:@"/logos/53/68/full/1256.gif"],
                           [Team teamWithName:@"Toronto Blue Jays" league:@"MLB" coach:@"John Gibbons" lastChamp:@"1993" division:@"AL East" hex:@"1a459d" imgLink:@"/logos/53/78/full/2559d7603ouedg7ldhw0br4fn.png"],
                           [Team teamWithName:@"Arizona Diamondbacks" league:@"MLB" coach:@"Kirk Gibson" lastChamp:@"2001" division:@"NL West" hex:@"a41a2c" imgLink:@"/logos/54/50/full/gnnnrbxcmjhdgeu6mavqk3945.gif"],
                           [Team teamWithName:@"Los Angeles Dodgers" league:@"MLB" coach:@"Don Mattingly" lastChamp:@"1988" division:@"NL West" hex:@"042e6c" imgLink:@"/logos/54/63/full/efvfv5b5g1zgpsf56gb04lthx.gif"],
                           [Team teamWithName:@"Pittsburgh Pirates" league:@"MLB" coach:@"Clint Hurdle" lastChamp:@"1979" division:@"NL Central" hex:@"ffc423" imgLink:@"/logos/54/71/full/uorovupw0jagctt6iu1huivi9.gif"],
                           [Team teamWithName:@"Atlanta Braves" league:@"MLB" coach:@"Fredi González" lastChamp:@"1995" division:@"NL East" hex:@"042a54" imgLink:@"/logos/54/51/full/3kgwjp6heowkeg3w8zoow9ggy.gif"],
                           [Team teamWithName:@"Miami Marlins" league:@"MLB" coach:@"Mike Redmond" lastChamp:@"2003" division:@"NL East" hex:@"ec3e34" imgLink:@"/logos/54/3637/full/y6oklqzigo1ver57oxlt60ee0.gif"],
                           [Team teamWithName:@"San Diego Padres" league:@"MLB" coach:@"Bud Black" lastChamp:@"-" division:@"NL West" hex:@"041e44" imgLink:@"/logos/54/73/full/ebjtzdtqw33dahm7k8zojhe45.gif"],
                           [Team teamWithName:@"Chicago Cubs" league:@"MLB" coach:@"Dale Sveum" lastChamp:@"1908" division:@"NL Central" hex:@"042e6c" imgLink:@"/logos/54/54/full/q9gvs07u72gc9xr3395u6jh68.gif"],
                           [Team teamWithName:@"Milwaukee Brewers" league:@"MLB" coach:@"Ron Roenicke" lastChamp:@"-" division:@"NL Central" hex:@"00225d" imgLink:@"/logos/54/64/full/ophgazfdzfdkeugut9bdw3iyz.gif"],
                           [Team teamWithName:@"San Francisco Giants" league:@"MLB" coach:@"Bruce Bochy" lastChamp:@"2012" division:@"NL West" hex:@"fc4614" imgLink:@"/logos/54/74/full/cpqj6up5bvgpoedg5fwsk20ve.gif"],
                           [Team teamWithName:@"Cincinnati Reds" league:@"MLB" coach:@"Dusty Baker" lastChamp:@"1990" division:@"NL Central" hex:@"231f20" imgLink:@"/logos/54/56/full/z9e0rqit393ojiizsemd0t1hx.gif"],
                           [Team teamWithName:@"New York Mets" league:@"MLB" coach:@"Terry Collins" lastChamp:@"1986" division:@"NL East" hex:@"fc4e04" imgLink:@"/logos/54/67/full/m01gfgeorgvbfw15fy04alujm.gif"],
                           [Team teamWithName:@"St. Louis Cardinals" league:@"MLB" coach:@"Mike Matheny" lastChamp:@"2011" division:@"NL Central" hex:@"c41244" imgLink:@"/logos/54/72/full/3zhma0aeq17tktge1huh7yok5.gif"],
                           [Team teamWithName:@"Colorado Rockies" league:@"MLB" coach:@"Walt Weiss" lastChamp:@"-" division:@"NL West" hex:@"24125c" imgLink:@"/logos/54/58/full/ej4v6a8q5w5gegtf7ilqbhoz7.gif"],
                           [Team teamWithName:@"Philadelphia Phillies" league:@"MLB" coach:@"Charlie Manuel" lastChamp:@"2008" division:@"NL East" hex:@"04529c" imgLink:@"/logos/54/70/full/o4lmh7dq5e3uordl7hvk6i3ug.gif"],
                           [Team teamWithName:@"Washington Nationals" league:@"MLB" coach:@"Davey Johnson" lastChamp:@"-" division:@"NL East" hex:@"bc0e2c" imgLink:@"/logos/54/578/full/rcehah9k0kekjkgzm077fflws.gif"],
                           [Team teamWithName:@"Anaheim Ducks" league:@"NHL" coach:@"Bruce Boudreau" lastChamp:@"2007" division:@"Pacific" hex:@"d44a14" imgLink:@"/logos/1/1736/full/fbh4jfr7lwbpuezjx0xbktfmo.gif"],
                           [Team teamWithName:@"Chicago Blackhawks" league:@"NHL" coach:@"Joel Quenneville" lastChamp:@"2013" division:@"Central" hex:@"e13a3e" imgLink:@"/logos/1/7/full/56.gif"],
                           [Team teamWithName:@"Edmonton Oilers" league:@"NHL" coach:@"Dallas Eakins" lastChamp:@"1990" division:@"Pacific" hex:@"042664" imgLink:@"/logos/1/12/full/6cphie5heyvfwn6lbzfowe61h.gif"],
                           [Team teamWithName:@"Nashville Predators" league:@"NHL" coach:@"Barry Trotz" lastChamp:@"-" division:@"Central" hex:@"fcba34" imgLink:@"/logos/1/17/full/lvchw3qfsun2e7oc02kh2zxb6.gif"],
                           [Team teamWithName:@"Philadelphia Flyers" league:@"NHL" coach:@"Peter Laviolette" lastChamp:@"1975" division:@"Metropolitan" hex:@"f4793e" imgLink:@"/logos/1/22/full/161.gif"],
                           [Team teamWithName:@"Tampa Bay Lightning" league:@"NHL" coach:@"Jon Cooper" lastChamp:@"2004" division:@"Atlantic" hex:@"04225c" imgLink:@"/logos/1/27/full/97hhvk8e5if0riesnex30etgz.gif"],
                           [Team teamWithName:@"Boston Bruins" league:@"NHL" coach:@"Claude Julien" lastChamp:@"2011" division:@"Atlantic" hex:@"fcba14" imgLink:@"/logos/1/3/full/venf9fmhgnsawnxxvehf.gif"],
                           [Team teamWithName:@"Colorado Avalanche" league:@"NHL" coach:@"Patrick Roy" lastChamp:@"2001" division:@"Central" hex:@"6c263c" imgLink:@"/logos/1/8/full/64.gif"],
                           [Team teamWithName:@"Florida Panthers" league:@"NHL" coach:@"Kevin Dineen" lastChamp:@"-" division:@"Atlantic" hex:@"042244" imgLink:@"/logos/1/13/full/94.gif"],
                           [Team teamWithName:@"New Jersey Devils" league:@"NHL" coach:@"Peter DeBoer" lastChamp:@"2003" division:@"Metropolitan" hex:@"cc0e2c" imgLink:@"/logos/1/18/full/32tfs723a3bes0p0hb4hgcy1u.gif"],
                           [Team teamWithName:@"Phoenix Coyotes" league:@"NHL" coach:@"Dave Tippett" lastChamp:@"-" division:@"Pacific" hex:@"dcd2af" imgLink:@"/logos/1/23/full/8lqmtthh0w2wgumr6goswqmki.gif"],
                           [Team teamWithName:@"Toronto Maple Leafs" league:@"NHL" coach:@"Randy Carlyle" lastChamp:@"1967" division:@"Atlantic" hex:@"040274" imgLink:@"/logos/1/28/full/199.gif"],
                           [Team teamWithName:@"Buffalo Sabres" league:@"NHL" coach:@"Ron Rolston" lastChamp:@"-" division:@"Atlantic" hex:@"0c1e44" imgLink:@"/logos/1/4/full/i40oxcdbo7xtfamqqhqachoyo.gif"],
                           [Team teamWithName:@"Columbus Blue Jackets" league:@"NHL" coach:@"Todd Richards" lastChamp:@"-" division:@"Metropolitan" hex:@"dc2e3c" imgLink:@"/logos/1/9/full/jhepegs329pc7ugyypebl28wg.gif"],
                           [Team teamWithName:@"Los Angeles Kings" league:@"NHL" coach:@"Darryl Sutter" lastChamp:@"2012" division:@"Pacific" hex:@"22328a" imgLink:@"/logos/1/14/full/71jepx81eqzz1l6q9g1g5j1lh.gif"],
                           [Team teamWithName:@"New York Islanders" league:@"NHL" coach:@"Jack Capuano" lastChamp:@"1983" division:@"Metropolitan" hex:@"04328c" imgLink:@"/logos/1/19/full/79520qbne58r9i71zhuggbff0.gif"],
                           [Team teamWithName:@"Pittsburgh Penguins" league:@"NHL" coach:@"Dan Bylsma" lastChamp:@"2009" division:@"Metropolitan" hex:@"cdb87c" imgLink:@"/logos/1/24/full/174.gif"],
                           [Team teamWithName:@"Vancouver Canucks" league:@"NHL" coach:@"John Tortorella" lastChamp:@"-" division:@"Pacific" hex:@"00693f" imgLink:@"/logos/1/29/full/2xd2efir5fdew26px6kx.gif"],
                           [Team teamWithName:@"Calgary Flames" league:@"NHL" coach:@"Bob Hartley" lastChamp:@"1989" division:@"Pacific" hex:@"d42604" imgLink:@"/logos/1/5/full/50.gif"],
                           [Team teamWithName:@"Dallas Stars" league:@"NHL" coach:@"Lindy Ruff" lastChamp:@"1999" division:@"Central" hex:@"0b714c" imgLink:@"/logos/1/10/full/7917_dallas_stars-primary-2014.png"],
                           [Team teamWithName:@"Minnesota Wild" league:@"NHL" coach:@"Mike Yeo" lastChamp:@"-" division:@"Central" hex:@"ac1a2c" imgLink:@"/logos/1/15/full/0kcehji928suy4ckk1pdo8s7l.gif"],
                           [Team teamWithName:@"New York Rangers" league:@"NHL" coach:@"Alain Vigneault" lastChamp:@"1994" division:@"Metropolitan" hex:@"e43a3c" imgLink:@"/logos/1/20/full/144.gif"],
                           [Team teamWithName:@"San Jose Sharks" league:@"NHL" coach:@"Todd McLellan" lastChamp:@"-" division:@"Pacific" hex:@"00535e" imgLink:@"/logos/1/26/full/dmo1xf3z4pph27vmg3gf.gif"],
                           [Team teamWithName:@"Washington Capitals" league:@"NHL" coach:@"Adam Oates" lastChamp:@"-" division:@"Metropolitan" hex:@"fffefe" imgLink:@"/logos/1/30/full/llrs2zxi127vkqgcsvfb.gif"],
                           [Team teamWithName:@"Carolina Hurricanes" league:@"NHL" coach:@"Kirk Muller" lastChamp:@"2006" division:@"Metropolitan" hex:@"c4122c" imgLink:@"/logos/1/6/full/fotih31tn5r345nufo5xxayh3.gif"],
                           [Team teamWithName:@"Detroit Red Wings" league:@"NHL" coach:@"Mike Babcock" lastChamp:@"2008" division:@"Atlantic" hex:@"d41e2c" imgLink:@"/logos/1/11/full/yo3wysbjtagzmwj37tb11u0fh.gif"],
                           [Team teamWithName:@"Montreal Canadiens" league:@"NHL" coach:@"Michel Therrien" lastChamp:@"1993" division:@"Atlantic" hex:@"003473" imgLink:@"/logos/1/16/full/124.gif"],
                           [Team teamWithName:@"Ottawa Senators" league:@"NHL" coach:@"Paul MacLean" lastChamp:@"-" division:@"Atlantic" hex:@"e31736" imgLink:@"/logos/1/21/full/2bkf2l3xyxi5p0cavbj8.gif"],
                           [Team teamWithName:@"St. Louis Blues" league:@"NHL" coach:@"Ken Hitchcock" lastChamp:@"-" division:@"Central" hex:@"00529b" imgLink:@"/logos/1/25/full/187.gif"],
                           [Team teamWithName:@"Winnipeg Jets" league:@"NHL" coach:@"Claude Noel" lastChamp:@"-" division:@"Central" hex:@"c41234" imgLink:@"/logos/1/3050/full/z9qyy9xqoxfjn0njxgzoy2rwk.gif"]];
    
    // Finds the pointer to the ViewController and sets the property teams to the teamArray just created above.
    UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
    ViewController *viewController = [navigationController.viewControllers objectAtIndex:0];
    viewController.teams = teamArray;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
