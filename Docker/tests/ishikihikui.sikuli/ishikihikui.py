import subprocess
import shutil
from time import sleep


def wait_and_click(image, timeout_seconds = 10):
    wait(image, timeout_seconds)
    sleep(0.3)
    i = find(image)
    hover(i)
    sleep(0.3)
    click(i)

shutil.rmtree("/root/.config/blender")
subprocess.Popen(["/root/workdir/blender-2.83.20-linux-x64/blender-softwaregl"], cwd="/root/workdir")

wait_and_click("1653006088062.png", 30)

dragDrop("1653009624328.png", "1653009705365.png")

def install_addon():
    wait_and_click("1653006186042.png")
    wait_and_click("1653006219561.png")
    wait_and_click("1653006245537.png")
    wait_and_click("1653006260204.png")
    wait_and_click("1653006322280.png")
    wait("1653013496625.png")
    wait_and_click("1653013507589.png")
    wait_and_click(Pattern("1653006392352.png").targetOffset(-72,0))
    wait_and_click(Pattern("1653006463807.png").targetOffset(210,0))

install_addon()

wait_and_click("1653013745955.png")

type("n")

wait_and_click("1653007264570.png")

wait_and_click("1653007301490.png")
wait("1653007349148.png", 30)


click("1653007513161.png")
click("1653008285770.png")
click("1653008323373.png")
click("1653008343234.png")
type("Armature\n")
click("1653008471474.png")
type("b\n")
wait_and_click("1653008569519.png")
type("spine\n")

click(Pattern("1653011456504.png").similar(0.80))
wait_and_click(Pattern("1653007555060.png").similar(0.80).targetOffset(-40,-13))

sleep(0.5)
type("0.2")
sleep(0.5)
type("\n")
sleep(0.5)

click(Pattern("1653011456504.png").similar(0.80))
wait_and_click(Pattern("1653007763700.png").similar(0.80).targetOffset(-25,6))

sleep(0.5)
type("0.2")
sleep(0.5)
type("\n")
sleep(0.5)

click(Pattern("1653011456504.png").similar(0.80))
wait_and_click(Pattern("1653007801968.png").similar(0.80).targetOffset(-28,27))

sleep(0.5)
type("0.2")
sleep(0.5)
type("\n")
sleep(0.5)

def append_uv_sphere(bone_name):
    print("Append UV Sphere to " + bone_name)
    size = "0.2" if bone_name == "head" else "0.1"

    wait_and_click("1653007376739.png")
    wait_and_click(Pattern("1653007419304.png").targetOffset(-69,0))
    wait_and_click("1653007450670.png")
    wait("1653010404331.png")

    click(Pattern("1653011456504.png").similar(0.80))
    wait_and_click(Pattern("1653007555060.png").similar(0.80).targetOffset(-42,-12))

    sleep(0.5)
    type(size)
    sleep(0.5)
    type("\n")
    sleep(0.5)
    click(Pattern("1653011456504.png").similar(0.80))  
    wait_and_click(Pattern("1653007763700.png").similar(0.80).targetOffset(-31,7))
    
    sleep(0.5)
    type(size)
    sleep(0.5)
    type("\n")
    sleep(0.5)
    click(Pattern("1653011456504.png").similar(0.80))
    wait_and_click(Pattern("1653007801968.png").similar(0.80).targetOffset(-34,29))
    
    sleep(0.5)
    type(size)
    sleep(0.5)
    type("\n")
    sleep(0.5)

    #click("1653008323373.png")
    click("1653008343234.png")
    type("Armature\n")
    click("1653008471474.png")
    type("b\n")
    wait_and_click("1653008569519.png")
    type(bone_name)
    type("\n")


for bone_name in [
    "head",
    "upper_leg.L",
    "lower_leg.L",
    "upper_leg.R",
    "lower_leg.R",
    "upper_arm.L",
    "hand.L",
    "upper_arm.R",
    "hand.R",
]:
    append_uv_sphere(bone_name)

wait_and_click("1653012330136.png")
wait_and_click("1653012350151.png")
wait_and_click("1653012365257.png")
wait_and_click("1653012399042.png")

output_path = "/root/untitled.vrm"
for retry in range(10):
    sleep(3)
    if os.path.exists(output_path):
        break
shutil.copy(output_path, "/root/workdir/tests/output.vrm")
