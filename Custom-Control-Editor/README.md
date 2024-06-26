# Custom Control Editor #

When using Custom Control Editor, there are a few things the api can do that is not available<br>
in the editor and must be applied by hand in a SSH session.<br>
Specifically:
<ul>
  <li>
    enabled: [bool]
  </li>
  <li>
    javascript: [command]
  </li>
</ul>
Prime example is my 'Lights' button.<br>
<code>
- children:
  - enabled: true
    javascript: window.open("http://192.168.0.32/")
    name: Lights
</code><br>
The <b>enabled: true</b> makes the button active even it the printer is not connected.<br>
Really useful if the button turns on the printer! <b>But</b> if your control sends any Gcodes,<br>
it makes no sense to mark it enabled...<br><br>
The <b>javascript</b> calls any standard javascript that makes sense.<br>
I use mine to open new browser tabs pointing to my Tasmota switches for lights and power,<br>
as well as calling my local webserver [ShowMe] to display my data files. I have a poor memory<br>
and it's just easier...<br><br>
See them all at: https://docs.octoprint.org/en/master/features/custom_controls.html#sec-features-custom-controls<br><br>
 :warning: Warning:  config.yaml requires specific formatting!<br>
 :warning: Warning:  Always make a backup of the file before editing and expect the edit to fail!<br><br>
With Custom Control Editor, you can call <b>any Gcode</b> that OctoPrint or your printer can process<br>
including <b>Gcode System Commands</b> and <b>Gcode Macros</b>.<br><br>

> Note: <hbr>
Another plugin you may find useful is [<b>Marlin GCode Documentation</b>](https://plugins.octoprint.org/plugins/marlingcodedocumentation/) which ties into the Terminal Tab<br>
and displays the structure and purpose of Gcodes you type on the Send line. It is a bit of a misnomer as<br>
it will work for RepRap and Klipper as well!<br>

# Events #

I use the events interface to prevent my semimonthly full backups of my entire SD card to my NAS unit.<br>
If I start a print, I make a file. If that file exists when running my backup script from crontab, I abort. EZPZ!<br>
Any other event, I delete the file. I backup at 1:00 AM so I shouldn't be printing, unless I am printing a mug...<br>
You only subscribe to the events you want, so I don't care about Pause and Resume.<br>

See them all at:https://docs.octoprint.org/en/master/events/index.html<br><br>
