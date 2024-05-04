const Bluetooth = await Service.import("bluetooth");
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
