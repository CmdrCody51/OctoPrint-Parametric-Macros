# GCode Macros #
I can not sing the praises enough for Charlie Powell's(cp2004) Gcode Macros plugin!<br>
[https://github.com/cp2004/OctoPrint-GcodeMacros]
# Jinja2 #
Jinja2 is a popular and powerful templating engine for Python programming language.<br><br>
Jinja2 uses a syntax similar to Django's templating language. It employs double curly braces <b>{{ }}</b> for variable<br>
substitution and <b>{% %}</b> for control structures like loops and conditionals. Jinja2 provides a variety of built-in filters<br>
that allow you to manipulate variables within templates. Filters can be chained together to perform complex transformations.<br><br>
Similar to Python, Jinja2 supports control structures like loops (<b>for</b>) and conditionals (<b>if, else, elif</b>). These structures<br>
allow for dynamic rendering of content based on conditions. With the <b>{% include %}</b> tag, you can include other templates<br>
within your current template. This allows for modularization and reuse of template code.<br><br>
You can do macros in Jinja2, reusable blocks of code defined using the <b>{% macro name(value) %}</b> and <b>{% endmacro %}</b> tags.<br>
They can accept parameters and can be called multiple times within the template. Did your head just explode?<br><br>
Overall, Jinja2 is a versatile and feature-rich templating engine that simplifies the process of generating dynamic<br>
content in Python applications, particularly in web development.
# Nitty Gritty #
GCode Macros put its data files in "/home/pi/.octoprint/data/gcode_macro/macros/" and calls them [name].gcode.<br>
You call them using @name<br><br>  
> Note <br>
@ commands (also known as host commands elsewhere) are special commands you may include in GCODE files streamed through OctoPrint to your printer or send as part of GCODE scripts, through the Terminal Tab, the API or plugins. Contrary to other commands they will never be sent to the printer but instead trigger functions inside OctoPrint.<br>
They are always of the form @[command], e.g. @pause or @custom_command<br><br>
Out of the box OctoPrint supports handling of these commands starting with version 1.3.7:<br><br>
@cancel<br>
    OctoPrint will cancel the current print job like if the “Cancel” button had been clicked.<br>
@abort<br>
    Same as cancel.<br>
@pause<br>
    OctoPrint will pause the current print job just like if the “Pause” button had been clicked.<br>
@resume<br>
    OctoPrint will resume the current print job just like if the “Resume” button had been clicked.<br><br>
These four command names are <b>reserved</b> and you can not use them but also other plugins can use custom @commands.<br>
For example, OctoLapse uses @OCTOLAPSE TAKE-SNAPSHOT or the WLED plugin uses @WLED ON or @WLED OFF to control some LEDs.<br>
Now, that being said, you could use @canCel or @aBort or @paUse and even @reSume, but you are just begging for problems.<br>

We now can take a look at a macro. Take @2U.<br>
<code>
G91
M400
G1 Z1 E-3
M400
G90
</code><br>
A simple GCode script to jog the Z axis up 1 mm and do a 3mm filament retract.<br>
The 2D macro reverses the step.<br><br>

# Tips & Tricks #
