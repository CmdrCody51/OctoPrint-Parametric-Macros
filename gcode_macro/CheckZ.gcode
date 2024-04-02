M18 S0
{%- for try in range(3) %}
M117 Check Z {{ loop.index }}/{{ loop.length }}
G91
G1 Z20 F1200
M400
G90
G28 X Y
M400
G28 Z
M400
G0 Z0
M400
M84 X Y
M1
{%- endfor %}
M18 S30
G91
G1 Z20 F1200
M400
G90
G28 X Y
G1 X110 Y110 F10000
M117 Check Z Complete
