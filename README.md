# joomla-component-bare
## Synopsis
Script to create skeletal Joomla! 3.5 component
## Usage
`sh ./joomla_component_bare.sh component_name author_name author_email author_url copyright_info`    
* component\_name: name of the component, which is used in the folder name, manifest file, language files, etc. This _should not_ have a COM\_ prefix.
* author\_name: Your name, or company's name. Used in the manifest file, which appears in the extension manager.
* author\_email: Also in the manifest file, this is the address you want to get slammed when something goes wrong.
* author\_url: Manifest file again (these are all just for aesthetic customization, really).
* copyright\_info: The copyright section of your manifest will read "(c) \[the current month\] \[the current year\]" and appends whatever you provide as this argument.

## Motivation
Saving time with the initial creation of Joomla! 3.5+ components
I create a lot of Joomla! components, as I find having a web-based system with a database fulfills 95% of my client's needs, and the MVC framework helps me reach a deployable state quickly. To accomodate this, I've created this script to create a skeletal Joomla! component with the files and folders I'll need eventually (preventing me from mistakes such as adding a controllers folder but not updating the manifest file).
## Installation
Copy into development folder, run script with appropriate arguments to create component development folder. Included is a makefile to package your component as a zip, ready for install on your Joomla! site.
## Contributors
I'm sure there's manifold aspects of Joomla! component development that I'm unaware of, so feel free to suggest additions to the skeleton.
## References
[Joomla! Developing an MVC Component](https://docs.joomla.org/J3.x:Developing_an_MVC_Component)
