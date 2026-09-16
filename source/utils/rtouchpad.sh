#!/bin/bash
for dev in /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-*; do
    if [ -e "$dev" ]; then
        echo "$(basename $dev)" | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
        echo "$(basename $dev)" | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/bind
    fi
done
