# Special Dialog Forms

<hr>

## Project Setup

<imgl images/ProjectSetup.png>
The ***Project Setup*** form is used to assign setup information to a project. It consists of four tabbed pages where each tab covers a different category of project information. It also includes a checkbox that will save your setup for use in all new future projects.<br>

**Hydraulic Analysis Options**

This page sets some key options that control how network hydraulics are computed:

|             |               |
|-------------|---------------|
|Flow Units   | Sets the units in which flow rates are expressed. Choosing metric flow units will require that all project data be expressed in SI metric units. Otherwise US customary units will apply.|
|Head Loss Formula | The formula used for computing the head loss across a pipe as a function of flow rate.|
|Service Pressure | The pressure required to supply a node's full demand under a pressure driven analysis. It has no effect on a demand driven analysis.|
|Maximum Trials | The maximum number of trials used to solve network hydraulics at each hydraulic time step of a simulation.|
|Accuracy | The principal convergence criterion that determines when a hydraulic solution has been reached. The trials end when the sum of all flow changes from the previous solution divided by the total flow in all links is less than this number.|
|Head Tolerance | Another convergence criterion requiring that the head loss computed by the head loss formula compared to the difference in nodal heads across each link be less than the specified value (in ft or m). If set to 0 then this criterion is not used.|
| Flow Tolerance | Another convergence criterion requiring that the largest absolute flow change between the current and previous solutions be less than the specified value (in flow units). If set to 0 then this criterion is not used.|

**ID Label Prefixes**

On this page you can specify a prefix used to assign ID names to the different types of EPANET objects when they are created. For example, if `Junc` was the ID prefix assigned to Junction nodes then as each new junction is added to a project it would receive an ID name of `Junc1`, `Junc2`, etc.

**Default Properties**

This page assigns default values to some key properties of nodes and pipes. These include the following:
|                  |                                                    |
|------------------|----------------------------------------------------|
| Node Elevation   |The elevation (in feet or meters) above some common reference of the node.|
| Tank Height      |The maximum height (in feet or meters) of the water surface above the bottom elevation of a storage tank node.|
| Tank Diameter    |The diameter of a storage tank node (in feet or meters).|
| Pipe Length      |The length of a pipe (in feet or meters).|
| Pipe Diameter    |The diameter of a pipe in (inches or millimeters).|
| Pipe Roughness   |The roughness coefficient of the pipe. For the Darcy-Weisbach formula it is expressed in millifeet for US units or in millimeters for SI units.|

**Map Dimensions**

This page sets the dimensions of the network map by providing coordinates for its lower left and upper right corners as well as their units (feet, meters, degrees, or none).

NOTE:
The Map page of the dialog will not appear if you selected to use a dynamic web map service (WMS) as a [basemap](#Using a Basemap).

<hr>

## Demand Categories

<imgl images/DemandEditor.png>
The ***Demand Categories Editor*** is used to assign base consumer demands and their time patterns when you want to model more than one category of water user at a junction. The editor is invoked from the Project Panel's Property Editor by clicking the <imgt images/Ellipsis.png> button when the ***Demand Categories*** feld has the focus. The editor is a table containing three columns. Each category of demand is entered as a new row in the table. The columns contain the following information:<br>
- Base Demand: baseline or average demand for the category (required).
- Time Pattern: ID label of time pattern used to allow demand to vary with time (optional). Click the <imgt images/Ellipsis.png> button to select a time pattern.
- Category: a text label used to identify the demand category (optional).

NOTE:
By convention, the demand placed in the frst row of the editor will be considered the main category for the junction and will appear in the ***Base Demand*** field of the Property Editor.

<hr>

## Time Patterns

When an object requests that a Time Pattern be specified EPANET responds by first displaying a ***Time Pattern Selector*** form.

<imgl images/PatternSelector.png><br>
This form is used to add, edit, or delete a project's Time Patterns. When the <ui2>OK</ui2> button is clicked the selected pattern will be assigned to the object requesting one. (Selecting the ***&lt;blank&gt;*** entry will remove any pattern previously assigned to the object.)

When a new pattern is added or an existing pattern is edited a Time Pattern Editor will be displayed.

<imgl images/PatternEditor.png><br>
This editor is used to assign an ID name to the pattern, attach an optional description to it, and enter multiplier values for each pattern time period. The time period interval is the ***Pattern Step*** value assigned as part of the project's ***[Analysis Options]***. The editing grid is initially sized for 24 periods. When in the last cell you can press the <imgt images/left_arrow_key.png> key to add an additional one.

The <ui2>Save</ui2> button will save the pattern data to a file while the <ui2>Load</ui2> button will load a previously saved pattern into the editor.

NOTE:
If the pattern ends before the simulation duration then it wraps around and starts repeating itself again.

<hr>

## Data Curves

When an object requests that a Data Curve be specified EPANET responds by first displaying a ***Data Curve Selector*** form.

<imgl images/CurveSelector.png><br>
This form is used to add, edit, or delete a project's Data Curves. When the <ui2>OK</ui2> button is clicked the selected curve will be assigned to the object requesting one. (Selecting the ***&lt;blank&gt;*** entry will remove any curve previously assigned to the object.)

When a new curve is added or an existing curve is edited a Data Curve Editor will be displayed.

<imgl images/CurveEditor.png><br>
This editor is used to assign an ID name to the curve, select the type of curve, attach an optional description to it, and enter a series of X and Y values for the curve. When in the last row of the data entry grid pressing the <imgt images/down_arrow_key.png> key will add an additional row to the grid.

The Curve Type dropdown list allows you to select from the following types of curves:
| Curve Type   | Description                                                       |
|--------------|-------------------------------------------------------------------|
| `Pump`       | how the head delivered by a pump varies with flow rate  |
| `Efficiency` | how a pump's percent efficiency varies with flow rate   |
| `Volume`     | how storage tank volume varies with height above the tank bottom |
| `Valve`      | how the percentage of flow with respect to a fully open ***Positional Control Valve*** varies with the percent that the valve is open |
| `Head Loss`  | how the head loss across a ***General Purpose Valve*** varies with flow through the valve |
| `Generic` | X, Y data that can be applied to any specific type of curve |

NOTE:
When three points are provided for a `Pump` or `Efficiency` curve EPANET fits a continuous function through the points to define the entire curve. If just a single design point is provided for a `Pump` curve then EPANET adds a point at 0 flow and 133% of design head, another point at 200% of design flow and 0 head, and then fits the three points to a continuous curve. If a single point is provided for an `Efficiency` curve additional points are added at 0 flow and 0 efficiency as well as at twice the design flow and 0 efficiency which are then fitted to a continuous function.

<hr>

## Simple Controls Editor

<p><imgr images/ControlsEditor.png></p>

<p>The ***Simple Controls Editor*** is launched by expanding the <b>Control Actions</b> category in the Project Explorer and then selecting the <b>Simple Controls</b> sub-category. The buttons below the list of controls in the Editor are used to
- add a new control,
- edit the currently selected control,
- delete the currently selected control,
- move a control up or down in the list.
The checkboxes in the rules listing are used to indicate if a rule is enabled or not.
</p>
<p>
<imgr images/SingleControl.png>When adding or editing a control a ***Single Control Editor*** form will appear where you would enter the contents of the control. The format of a simple control is described in the <a>Simple Controls</a> topic.</p>

<hr>

## Rule-Based Controls Editor

<p><imgl images/RulesEditor.png></p><br>

<p>The ***Rule-Based Controls Editor*** is launched by expanding the <b>Control Actions</b> category in the Project Explorer and then selecting the <b>Rule-Based Controls</b> sub-category. The buttons below the list of rules in the Editor are used to
- insert a new rule after the currently selected rule
- edit the currently selected rule,
- delete the currently selected rule,
- move a rule up or down in the list.
The checkboxes in the rules listing are used to indicate if a rule is enabled or not.
</p>
<p>
<imgr images/SingleRule.png>When adding or editing a rule a ***Single Rule Editor*** form will appear where you would enter the contents of the rule. The format of a control rule is described in the <a>Rule-Based Controls</a> topic.
</p><br>

<hr>

## Single Species Quality

<p><imgl images/WaterQualityEditor.png><br>
The ***Single Species Water Quality Editor*** selects the type of water quality analysis to conduct and its parameters. It contains the following data fields:</p>

<p><b>Type of Quality Analysis</b><br>
Selects to analyze either a <i>CHEMICAL, WATER AGE, SOURCE TRACING,</i> or no quality.</p>
<p><b>Constituent Name</b><br>
The name of the chemical being analyzed.</p>
<p><b>Quality Tolerance</b><br>
The smallest change in quality that will cause a new parcel of water to be created in a pipe. A typical setting might be 0.01 for chemicals and 0.1 for water age and source tracing.</p>

NOTE:
The Quality Tolerance determines when the quality of one parcel of water is essentially the same as another parcel. For chemical analysis this might be the detection limit of the procedure used to measure the chemical, adjusted by a suitable factor of safety. Using too large a value for this tolerance might affect simulation accuracy. Using too small a value will affect computational efficiency.

<p><b>Concentration Units</b><br>
Mass units used to express concentration. Choices are mg/L or ug/L. Units for Age and Source Tracing analyses are fixed at hours and percent, respectively.</p>
<p><b>Bulk Reaction Order</b><br>
Power to which concentration is raised when computing a bulk flow reaction rate in pipes. Use 1 for first-order reactions, 2 for second-order reactions, etc.</p>
<p><b>Tank Reaction Order</b><br>
Power to which concentration is raised when computing a reaction rate in tanks. Use 1 for first-order reactions, 2 for second-order reactions, etc.</p>
<p><b>Wall Reaction Order</b><br>
Power to which concentration is raised when computing a pipe wall reaction rate. Choices are FIRST (1) for first-order reactions or ZERO (0) for constant rate reactions.</p>
<p><b>Limiting Concentration</b><br>
Maximum concentration that a substance can grow to or minimum value it can decay to. Bulk reaction rates will be proportional to the difference between the current concentration and this value. Leave blank if not applicable.</p> 
<p><b>Specific Diffusivity</b><br>
Molecular diffusivity of the chemical being modeled relative to that of chlorine at 20 deg. C (0.00112 sq ft/day). Use 2 if the chemical diffuses twice as fast as chlorine, 0.5 if half as fast, etc. Only used when modeling mass transfer for pipe wall reactions. Set to zero to ignore mass transfer effects.</p>

<hr>

## Source Quality
<imgl images/SourceEditor.png>
The ***Source Quality Editor*** is used to describe the quality of source flow entering the network at a specific node. This source might represent the main treatment works, a well-head or satellite treatment facility, or an unwanted contaminant intrusion. The editor is invoked from the Project Panel's Property Editor when editing a node's ***Source Quality*** property by clicking the <imgt images/Ellipsis.png> button or pressing <kbd>Enter</kbd>. The editor contains the following data fields:<br>
***Source Strength***<br>
Baseline or average concentration (or mass flow rate) of the source - enter 0 to remove the source.<br><br>
***Time Pattern***<br>
ID label of a time pattern used to make source quality vary with time - leave blank if not applicable.<br><br>
***Source Type***<br>
Select either <i>Concentration, Mass Booster, Set Point Booster,</i> or <i>Flow Paced Booster</i>. See the <a>Water Quality Sources</a> section for more details.

<hr>

## Multi-Species Quality
<p><imgl images/MsxEditor.png>
The ***Multi-Species Quality Editor*** is used to describe a multi-species water quality model. The data needed to define a model are divided into several categories listed in the left hand panel of the editor. Selecting a category will bring up its associated editor page. The minimum required categories are ***Species*** and ***Pipe Reactions***.</p>

<p>The editor for each category is a data entry grid as shown in the figure above. Clicking the <ui2>Help</ui2> button will describe what the entries in each column of the grid should be. Pressing the <imgt images/down_arrow_key.png> key when in the last row of a grid will add a new row to it. The toolbar buttons above the grid allow you to:
- cut, copy and paste selections made in the grid,
- add or delete a row of the grid,
- move a row up or down,
- and when applicable, toggle a display of reserved symbol names that can be used when entering reaction expressions.</p>

<p>The <ui2>Load</ui2> button loads a previously saved multi-species data file into the editor while the <ui2>Save</ui2> button will save the current contents of the editor to file. The <ui2>Clear</ui2> button clears the contents of the editor.</p>

<hr>

## Map Legend
<imgl images/LegendEditor.png>
The Legend Editor is used to set numerical ranges to which different colors are assigned for viewing the currently selected node or link theme on the network map. It is invoked by clicking on either the ***Node Legend*** or ***Link Legend ***icons that appear on the ***View*** tab of the Menu Panel.
<p>
Numerical values, in increasing order, are entered in the edit boxes to define the color ranges. Not all four boxes need to have values.<br><br>
To change a color, click on its color band and then select a new color from the ***Color Dialog*** box that will appear.<br><br>
Click the ***Interval Scale*** button to assign ranges based on dividing the range of the current theme at the current time period into equal intervals.<br><br>
Click the ***Color Palette*** button to select from a list of built-in color schemes.<br><br>
Click the ***Reverse Colors*** button to reverse the ordering of the current set of colors (the color in the lowest range becomes that of the highest range and so on).
</p>


