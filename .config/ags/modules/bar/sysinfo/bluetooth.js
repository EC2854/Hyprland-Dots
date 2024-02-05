import { Widget } from "../../../imports.js";
import { Bluetooth } from "../../../imports.js";
const { Box } = Widget;

const bluetooth = () => Box({
    children: [
        Widget.Icon({
        icon: Bluetooth.bind('enabled').transform(on =>
            `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
        })
    ]
})

export const BluetoothWidget = () => Box({
    class_name: 'bluetooth',
    children: [bluetooth()],
});
