# Using a Basemap
EPANET can display a basemap image behind the network map so that you can see the physical location of of network objects. These images can come from either a static image file or from a dynamic web map service (WMS).  
<imgl images/Basemap.png>  

## Adding a Basemap
To add a basemap to the network map:
- Click the ***Basemap*** button on the ***Map*** page of the Menu Panel.
- Select ***Load*** from the drop-down menu that appears.
- A ***Basemap Source Selection*** form will appear asking you to choose either an image file or a web map service for the basemap.
- If you choose to use an image file a standard Open File dialog will appear asking you to select a file stored in several different popular formats. Once selected the image will appear centered in the map panel and scaled to maintain its aspect ratio.
- If you are starting a new project and choose to use a web map service then you will be prompted to provide the name of a location (such as a city) or a latitude, longitude where the initial location of your network will be centered.
- If you want to use a web map service for an existing network then its coordinate units must be in decimal degrees. Otherwise this option will be disabled on the Basemap Source Selection form.

## Removing a Basemap
- Click the ***Basemap*** button on the ***Map*** page of the Menu Panel.
- Select ***Unload*** from the drop-down menu that appears.

You can also hide or show a loaded basemap using the ***Basemap*** check box that appears on the Map Legend Panel.

## Adjusting the Basemap Image
- Click the ***Basemap*** button on the ***Map*** page of the Menu Panel.
- Select ***Lighten*** from the drop-down menu to lighten the basemap image.
- Select ***Grayscale*** from the drop-down menu to display the basemap in grayscale.

The figure below contrasts an original basemap image with one lightened and converted to grayscale.
<imgc images/AdjustedBasemap.png>

## Georeferencing a Basemap
When a static basemap image file is added to a project it assumes whatever distance scaling and units that are in effect for the Map Panel. For a new project these are arbitrarily set at 0 to 10,000 with no units assigned.

You can re-scale the basemap and assign it coordinate units (a process called georeferencing) by clicking the ***Basemap*** button on the ***Map*** page of the Menu Panel and selecting ***Georeference*** from its drop-down menu. A ***Georeferencer*** panel will appear above the Map Legend panel. It offers two options for georeferencing the basemap:
- Specifying the distance between two control points selected on the basemap image as well as the coordinates of a third selected point.
- Using a World file that contains a scaling factor (distance per image pixel) and coordinates of the image's top left corner in a plain text format.
Depending on your choice the ***Georeferencer*** will take you through the steps of supplying it with the required information. After the basemap has been georeferenced the coordinates of all network objects previously appearing on the Map Panel will be recomputed so as to maintain their relative position to one another.

## Aligning the Network and Basemap
When a static basemap image file is added to an existing project it may not align correctly with the objects already displayed on the network map. You can attempt to correct this manually by moving individual nodes as described in the [Working with the Map] topic, or you can request that EPANET perform an automatic adjustment by pinning a set of nodes to specific locations on the basemap image.

To use the automatic alignment feature:
- Click the ***Basemap*** button on the ***Map*** page of the Menu Panel.
- Select ***Align*** from the drop-down menu that appears.
- An ***Alignment Tool*** panel will appear above the Map Legend.

The tool will ask you to select three network nodes to serve as control points along with the positions on the basemap where they should be located. It will then transform the coordinates of all of the other network objects to be consistent with how the coordinates of the control nodes were modified.

HINT:
Ideally the control nodes should be selected at known physical locations, such as at storage tanks or reservoirs, and should span a wide area of the basemap.
