#!/bin/sh

cd /system
if [ -f /system/.upgrade ]; then
    cd /backupa
    echo "init upgrading!!!!!!!!!!!!"
    ./upgrade.sh
    rm /system/.upgrade
fi

echo 61 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio61/direction
echo 1 > /sys/class/gpio/gpio61/value
sleep 1
echo 0 > /sys/class/gpio/gpio61/value

#insmod /lib/modules/tx-isp.ko isp_clk=100000000
#insmod /lib/modules/sensor_imx323.ko
#insmod /lib/modules/sensor_jxf22.ko
#insmod /lib/modules/sensor_ps5230.ko
#insmod /lib/modules/exfat.ko
#insmod /lib/modules/sample_motor.ko
#insmod /lib/modules/audio.ko
#insmod /lib/modules/sinfo.ko
#insmod /lib/modules/8189es.ko

insmod /driver/tx-isp.ko isp_clk=100000000
#insmod /driver/sensor_imx323.ko
#insmod /driver/sensor_jxf22.ko
#insmod /driver/sensor_ps5230.ko
insmod /driver/exfat.ko
insmod /driver/sample_motor.ko
insmod /driver/audio.ko
insmod /driver/sinfo.ko
insmod /driver/8189es.ko
insmod /driver/sample_pwm_core.ko
insmod /driver/sample_pwm_hal.ko
#insmod /driver/rtl8189ftv.ko

#wpa_supplicant -Dwext -i wlan0 -c /system/etc/wpa_supplicant.conf -B
#udhcpc -i wlan0 -s /system/etc/udhcpc.script -q

#ifconfig eth0 up
#udhcpc -i eth0 -s /system/etc/udhcpc.script -q
#ifconfig eth0 10.0.22.199
#route add default gw 10.0.22.1

# open ircut
#cp /system/bin/setir /tmp/
#config ip address

#/system/bin/carrier-server --st=imx322

# >>>> begin of wyze_hack customization <<<<<
exec >>/tmp/boot.log
exec 2>&1

export APPVER=4.10.3.108
export PATH=/system/wyze_hack/$APPVER:/system/wyze_hack:$PATH
/system/wyze_hack/run.sh
# >>>> end of wyze_hack customization <<<<<

/system/bin/singleBoadTest
export LD_LIBRARY_PATH=/tmp:$LD_LIBRARY_PATH
/system/bin/iCamera &
