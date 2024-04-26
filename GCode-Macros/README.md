# GCode Macros #
I can not sing the praises enough for Charlie Powell's(cp2004) Gcode Macros plugin!<br>
[https://github.com/cp2004/OctoPrint-GcodeMacros]<br><br>
I consider that there are 3(three) classes of Macros available:<br>
<ol>
    <li>
        Basic GCode script.
    </li>
    <li>
        Basic Jinja2 macro.
    </li>
    <li>
        Parametric Jinja2 macro.
    </li>
</ol>

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
You call them using @name. The major 'programming' consideration is that as a <b>template</b> language, Jinja2 outputs a block<br>
of GCode "notum hoc tempore" or with data known at this time. The template is processed in one pass.<br><br>  
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

We now can take a look at a type 1 macro. Take @2U.<br>
<code>
G91
M400
G1 Z1 E-3
M400
G90
</code><br>
A simple GCode script to jog the Z axis up 1 mm and do a 3mm filament retract.<br>
The 2D macro reverses the step.<br><br>
A type 2 macro looks like the @Do_Check_Z.<br>
<code>
M18 S0 ; disable stepper timeout (never shutdown)
{% for try in range(3) -%}
M117 Check Z {{ loop.index }}/{{ loop.length }} ; display current loop (Check Z 1/3)
G91 ; goto incremental
G1 Z20 F1200 ; lift Z 30 mm
M400 ; make sure you get there
G90 ; go back to absolute
G28 X Y ; home X and Y
M400 ; make sure you get there
G28 Z ; Home Z
M400 ; make sure you get there
G0 Z0 ; goto 0 on Z
M400 ; make sure you get there
M84 X Y ; disable X and Y steppers (let's me manually move them while leaving Z locked)
M1 ; in my OctoPrint I have unblocked the M1 as it lets me use the LCD button to continue
: the printer will not return the 'ok' until I click the button up to the comm time out.
; this is mitigated by the temperature reports and busy protocol.
{% endfor -%}
M18 S30 ; restore stepper time out
G91 ; goto incremental (don't really need but BSTS)
G1 Z20 F1200 ; lift the Z
M400 ; make sure you get there
G90 ; go back to absolute
G28 X Y ; rehome X and Y (you and the machine don't know what you did BSTS)
G1 X110 Y110 F10000 ; go mid-table
M117 Check Z Complete
</code><br>
Note: All those comments aren't really there
# Tips & Tricks #
The syntax {%- (or -%}) has a special meaning in this context related to whitespace control.
Here are specific uses of {%- in Jinja2:
<ul>
<li>Start of a Block: Using {%- at the beginning of a block, like {%- if condition %}, tells Jinja2 to strip any leading spaces or newlines from the template output before processing this block.</li>
<li>End of a Block: Similarly, using -%} at the end of a block, like {% endfor -%}, tells Jinja2 to strip any trailing spaces or newlines after processing this block.</li>
<li>
Both: Using {%- at the beginning of an include or set and a -%} at the end of an include or set will prevent any output from the statement.
</li>
</ul>
If you get this wrong, you can fill your <b>octoprint.log</b> file with "octoprint.util.comm - INFO - Refusing to send an empty line to the printer" warnings! You can also 'skip' steps by 'stripping' newlines from the scripts. I suggest turning on serial logging and refering to the log files often when developing macros!<br><br>
We now can take a look at a type 3 macro like @First_Layer.gcode from "gcode_macro/macros".<br>
This is entered from the Settings page for GCode Macros.<br>
<code>
{%- set mine = namespace(my_Working=false) -%}
{%- set message = 'First Layer Check' -%}
{%- include 'Do_Pause.macro' -%}
</code><br>
What makes this different, is the use of the <b>namespace</b> construct. In Jinja2, a namespace is a container for variables and other objects that can be passed to templates or within templates to isolate variables from other contexts.<br><br>
The Do_Pause.macro file can be written with any text editor and is placed in the "gcode_macro" directory. All include files are placed into the "gcode_macro" directory. That keeps the macros being defined in the Settings page from trying to load the includes as macros.<br>
<code>
{%- include 'WhyMe.data' -%}
    {%- set mine.my_Working = false -%}
    {%- set mine.my_State = false -%}
    {%- set mine.my_Pause = true -%}
    {%- set mine.my_BedTemp = 70 -%}
    {%- set mine.my_HeadType = 0 -%}
    {%- set mine.my_HotendTemp = 200 -%}
    {%- set mine.my_HotendMinTemp = 160 -%}
    {%- set mine.my_Feedrate = 100 -%}
    {%- set mine.my_Flowrate = 100 -%}
    {%- set mine.my_T0WT = [10,190] -%}
    {%- set mine.my_T1WT = [20,190] -%}
    {%- set mine.my_T2WT = [30,190] -%}
    {%- set mine.my_T3WT = [40,190] -%}
    {%- set mine.my_PreFeed = 570 -%}
    {%- set mine.my_MaxExt = 200 -%}
    {%- set mine.my_ABL = false -%}
    {%- set mine.my_TimeLapse = false -%}
    {%- set mine.my_Z_Lift = 3.5 -%}
    {%- set mine.my_Fix_Zon = 0.125 -%}
    {%- set mine.my_Fix_Zoff = 2.0 -%}
    {%- set mine.my_Retract = 5 -%}
    {%- set mine.my_TLPts = [5,215] -%}
    {%- set mine.my_Delay = 0 -%}
    {%- set mine.my_LayerCount = 42 -%}
    {%- set mine.my_Layer = 64 -%}
    {%- set mine.my_LayerMatch = 1 -%}
    {%- set mine.my_LayerFR = 7800 -%}
    {%- set mine.my_Levels = [] -%}
    {%- set mine.my_BedLevelCnt = 0 -%}
{%- if mine.my_Pause -%}
M400 ; complete all motion
G60 ; store XYZ (fw) if G60/G61 is not enabled, recompile your firmware to use it SO handy
G91 ; incremental
G1 Z{{ mine.my_Z_Lift }} E-{{ mine.my_Retract }}; lift Z to clear part
G90 ; back to absolute
G0 X{{ mine.my_TLPts.0 }} Y{{ mine.my_TLPts.1 }} F10000 ; clear the build area
M400 ; complete all motion
M18 S0
OCTO203 ; turn lights on
{%- if message is defined -%}
M117 {{ message }}
{%- endif -%}
M300 P1000 ; beep if you got em
M1 ; pause using printers pause
M18 S30
G61 XY
G91
G1 Z-{{ mine.my_Z_Lift }} E{{ mine.my_Retract }}
G90
G61 F{{ mine.my_LayerFR }} ; return to saved position (fw)
{%- endif -%}
OCTO202 ; turn lights off
</code><br>
Now, I always check my first layer, but if I didn't want to, I could change <b>mine.my_Pause</b> to false and all this macro would do is turn off the lights. Likewise I can adjust the <b>mine.my_Z_Lift</b> and <b>mine.my_Retract</b> distances I use. The <b>mine.my_TLPts</b> is a two element array for positioning the hotend for timelapses and I just re-use that here. Notice <b>mine.my_LayerFR</b> is set from the GCode file during slicing using a post processor script to build the approptiate GCode System Command line.<br>
