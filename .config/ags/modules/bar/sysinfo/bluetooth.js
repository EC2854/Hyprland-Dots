import { Widget } from "../../../imports.js";
import { Bluetooth } from "../../../imports.js";
const { Box } = Widget;

export const BluetoothWidget = () => Box({
    class_name: 'bluetoothindicator',
    children: [
        Widget.Icon({
        icon: Bluetooth.bind('enabled').transform(on =>
            `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
        })
    ]
})
