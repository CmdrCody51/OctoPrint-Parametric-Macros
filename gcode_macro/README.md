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
On your OctoPrint server, GCode Macros put its data files in "/home/pi/.octoprint/data/gcode_macro/macros/"
# Tips & Tricks #
