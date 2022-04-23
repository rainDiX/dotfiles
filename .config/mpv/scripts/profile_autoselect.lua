-- If the laptop is on battery, the default will be choosen,
-- else the one defined with „hqprofil“ is used.


local msg = require 'mp.msg'
local utils = require 'mp.utils'

local igpuprofile = "iGPU-HQ"
local egpuprofile = "eGPU-HQ"
local egpuvkname = "AMD RADV NAVI14"
local egpupath = "/dev/dri/renderD129"

function get_sys_value(variable)
    local f = assert(io.open(variable, "r"))
    local val = string.gsub(f:read("*all"), "\n", "")
    f:close()
    return val
end

function check_ac()
    local ac = get_sys_value("/sys/class/power_supply/AC/online")
    return ac == "1"
end

function check_gpu(path)
   local f=io.open(path,"r")
   if f~=nil then io.close(f) return true else return false end
end


if mp.get_property("option-info/profile/set-from-commandline") == true then
    return
end

--msg.info(mp.get_property_bool("option-info/profile/set-from-commandline"))
-- msg.info(utils.format_json(check_ac))

if (check_gpu(egpupath)) then
    msg.info("eGPU detected, setting high-quality options.")
    mp.commandv("apply-profile", egpuprofile)
    mp.set_property("vulkan-device", egpuvkname)
    mp.set_property("vaapi-device", egpupath)
    return
end

if (check_ac()) then
    msg.info("On AC, setting high-quality options.")
    mp.commandv("apply-profile", igpuprofile)
    return
end
