# -*- encoding=utf8 -*-
__author__ = "WDAGUtilityAccount"

from airtest.core.api import *

auto_setup(__file__)

dev = connect_device("Windows:///?title_re=Blender")
print(dev.get_title())
