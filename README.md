# joomla-component-bare
## Synopsis
Script to create skeletal Joomla! 3.5 component
## Usage
sh ./joomla\_component\_bare.sh component\_name author\_name author\_email author\_url copyright\_info
component\_name _should not_ have a COM\_ prefix 
## Motivation
Saving time with the initial creation of Joomla! 3.5+ components
I create a lot of Joomla! components, as I find having a web-based system with a database fulfills 95% of my client's needs, and the MVC framework helps me reach a deployable state quickly. To accomodate this, I've created this script to create a skeletal Joomla! component with the files and folders I'll need eventually (preventing me from mistakes such as adding a controllers folder but not updating the manifest file).
## Installation
Copy into development folder
## Contributors
I'm sure there's manifold aspects of Joomla! component development that I'm unaware of, so feel free to suggest additions to the skeleton.
## References
[Joomla! Developing an MVC Component](https://docs.joomla.org/J3.x:Developing_an_MVC_Component)
