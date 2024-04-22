{%- set gimme = namespace(gimme = true) -%}
{%- set gimme.E = 0.0 -%}
{%- set gimme.F = 3000.0 -%}
{%- set gimme.G = 1.0 -%}
{%- set gimme.M = 107.0 -%}
{%- set gimme.T = 0 -%}
{%- set gimme.X = 110.0 -%}
{%- set gimme.Y = 110.0 -%}
{%- set gimme.Z = 20.0 -%}
{%- set gimme.BED_Temp = 0.0 -%}
{%- set gimme.TotE = 0.0 -%}
{%- set gimme._AMI = 0 -%}
{%- set gimme._AAI = 0 -%}
{%- set gimme._EAI = 0 -%}
M117 X={{ gimme.X }} Y={{ gimme.Y }} Z={{ gimme.Z }}
