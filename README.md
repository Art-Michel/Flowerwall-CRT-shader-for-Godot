# CRT Shader for Godot
- made in 4.6, should work a few versions above or below with minimal changes if any.
- works in all Forward+, Mobile and Compatibility renderers.

----------------

## Usage
- Extract the zip files into your addons folder
- Enable the plugin in Project Settings -> Plugins
- Run any scene. At runtime, press F1 to configure.
- It will display on top of everything. if you want a canvas to not be affected by the post process, set its layer above 104.
- To disable everything at runtime, press F2. (if you want to modify these behaviours, inside addons/flowerwall_crt/scripts/flowerwall_crt_plugin are all the functions you need)
- You need (!) the stretch mode to be canvas item in order for the shader to work properly at any resolution
<img width="896" height="277" alt="settings" src="https://github.com/user-attachments/assets/0f9a7a0a-0e38-4a06-a8d8-85a49242ec4d" />

### Presets info
- I recommend 3x3 for **below** 1080p. 4x4 for **above** 1080p. Both will look good **at** 1080p.
- Presets have a good amount of blur for 2d pixel art, for 3D feel free to lower Horizontal Blur (i recommend no lower than 2 due to how the mask works) and Vertical Blur (0 is fine)
----------------

## Screenshots
<img width="484" height="361" alt="f1" src="https://github.com/user-attachments/assets/d0449fea-d03a-45c3-876b-78ae37ad43c5" />
<img width="199" height="281" alt="dracula" src="https://github.com/user-attachments/assets/1b2d63c2-3437-4969-9fc1-ac81a3ff871f" />
<img width="639" height="448" alt="waterfall" src="https://github.com/user-attachments/assets/89db9f50-3a8b-4890-8c27-91f30da96842" />
<img width="707" height="714" alt="NE41Em1HQy" src="https://github.com/user-attachments/assets/00d3b68f-6caa-49d4-a736-48d4ebb393cc" />
<img width="492" height="460" alt="dDaYCJwQjg" src="https://github.com/user-attachments/assets/cbca1dcc-460b-45a6-ac9b-380b36fda872" />
<img width="1200" height="894" alt="RugIApzrV6" src="https://github.com/user-attachments/assets/78668009-eec8-4d0c-a2b8-a725bec225ef" />
