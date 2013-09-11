SportsDataTable
==========================
Created by Dylan Eirinberg


##What is SportsDataTable?

One of my tasks at my internship this summer was to create and display a catalog of YouTube videos. I realized there weren’t many open source projects devoted to explaining how to present dynamic data in a UITableView. I decided to create a project that demonstrates many of the UITableView features in a drill-down navigation system. The app is designed to be very scalable and responsive to changing JSON data.

###Data: 
One of the main things this project shows is how to respond to dynamic and scalable data. When a developer wants to add or update information to their app, it should be quick and easy. I decided to present sports information. Sports have a long drill-down list starting with leagues such as the NBA or MLB, then conferences, then divisions and finally teams.

Two classes in this app hold information properties-Group and Team. Groups contain all of the leagues, conferences, and divisions for each sport. This class stores the name, type (which is essentially a pointer to its parent group) and a link to the URL of its logo if it exists.  The Team class stores much more information-the name, league (for quick sorting), name of its coach, year of its last championship, division (which is another parent pointer), hex string and link to its logo. 

These two classes frequently are compared to display categorized data. While this may seem simple, the program has to handle many variations of data the user would want to display. At first, teams and groups need to be categorized by league. Three options are presented in the main “ViewController” class-an option to see all teams of that league, and then the two conferences in the league. 

The “All Teams” cell takes the user to a list of every team in the league while a conference drills down to the option to see all the teams of the conference or specific divisions. When the user selects an NFL group only NFL teams are sent to the next view controller (DivisionsViewController) to reduce search time. 

Finally the TeamViewController responds to the properties of the team. The background color is set to the hex string. The logo is downloaded from its image link. The last championship text is set to its league type such as “Last Superbowl: YEAR” if its an NFL team or “Last Stanley Cup” if its an NHL team.

To see a visual representation of this hierarchy see the picture below:
![alt text](/SportsHierarchy.png "VCHierarchy")

In this project there are 36 groups and 122 teams. Once I built the initial sorting algorithms for the groups and teams, adding new leagues and teams took very little time.

##What other uses does this have?
There are many different data structures that utilize similar hierarchies. Most music apps first display artists and then sort by albums then songs, always giving the user the option of seeing all songs at any point. Many custom data structures need to use a similar type of tree.

##Update
The project now responds to JSON data. The teams and leagues are stored and converted from local JSON files. 

Standings: The app pulls the HTML pages of each league's standings from ESPN, sorts through them and finds their records. Team records are displayed in order of percentage and can be sorted in the league, conference or division.

<br></br>

###<u>Besides managing data this project describes other Objective-C concepts:</u>

####UITableView:
<p>*Using both UIViewController with a UITableView and a UITableViewController</p>
<p>*Different cell types with images and subtitles</p>
<p>*Sort cells by different parameters. Teams can be sorted alphabetically or sorted by their most recent championship.</p>
<p>*Resizing cells equally to fill screen</p>
<p>*Alternate cell colors</p>
<p>*Reorder control-changing the order of the cells and respond to user-selected sequence.</p>

####Internet
<p>*Images are downloaded from an NSURLConnection asynchronously and stored/cached.</p>
<p>*Downloading images asynchronously greatly reduces loading times for the app. In this project the images are only downloaded when they are visible, so the logo for the Chicago Bulls only when it is selected for the first time.</p>
<p>*The Internet connection is first tested through Apple’s Reachability class. If there is no Internet the images won’t download unnecessarily and an alert is shown.</p>

####UISegmentedControl:
<p>*Shown to separate sports leagues and called to reload table data when the selected segment is changed.</p>
<p>*Used as a picker in settings to sort data by name or championship.</p>

####UINavigationController:
<p>*Customize title with text or image and how to set right or left bar button items.</p>
<p>*Modal segue for UINavigationController view controllers (work around)</p>


####Hex string to UIColor
<p>*The program converts an Objective-C unsupported hex string (team’s background color) to a readable UIColor value.</p>
<p>*This color is converted to a grayscale value, which is used to store the text color. This way text is readable- the text is white if the background color is dark and vice versa.</p>

<br></br>

##What’s next for this project?
<p>*Support for team and/or current scores to make this more useful for users </p>
<p>*Although the app is designed for dynamic data currently no information other than the standings can be changed outside of the app. Ideally this information (most likely JSON files detailed above) can be hosted and downloaded from a server </p>
<p>*Pull to refresh for standings and possibly other data </p>









